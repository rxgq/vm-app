import 'dart:io';

import 'package:allium/vm/parser.dart';
import 'package:allium/vm/result.dart';
import 'package:allium/vm/stack.dart';
import 'package:allium/vm/value.dart';

abstract interface class VM {
  void execute(String _program);
}

final class VirtualMachine implements VM {

  // executable bytecode compiled from the program string
  late List<int> _programBytes;

  // virtual machine stack
  final _stack = VMStack();

  // max number of items allowed on the virtual stack
  static const _stackLimit = 16;

  // a pointer to the current instruction in program
  int _ip = 0;

  // a flag that will halt the execution of instructions if 'true'
  bool _isHalted = false;

  // Instruction Set Architecture
  late final Map<int, Function> _isa;

  // number of instructions to execute per second
  static const _execSpeed = 16;

  // displays a verbose execution output if 'true'
  static const bool _logInfo = true;

  final Function(VMStack, List<String>) emitData;
  final Future<String> Function() getInput;

  VirtualMachine({
    required this.emitData,
    required this.getInput,
  }) {
    _isa = {
      0x00: _nop,
      0x01: _halt,
      0x02: _push,
      0x03: _pop,
      0x04: _add,
      0x05: _sub,
      0x06: _mul,
      0x07: _div,
      0x08: _jmp,
      0x09: _out,
      0x0a: _jz,
      0x0b: _jnz,
      0x0c: _in,
    };
  }

  @override
  Future<VMResult> execute(final String programStr) async {
    final parser = VirtualMachineParser(source: programStr);
    final result = parser.parse();

    if (!result.isSuccess) return result;
    _programBytes = result.value;

    while (!isEnd() && !_isHalted) {
      var result = await _eval();
      if (!result.isSuccess) return result;

      _ip++;

      await Future.delayed(Duration(milliseconds: (1000 / _execSpeed).round()));
      emitData(_stack, _programBytes.map((byte) => "0x${byte.toRadixString(16).padLeft(2, '0')}").toList());
    }

    _stack.dump();
    return VMResult.ok();
  }

  Future<VMResult> _eval() async {
    final instr = _programBytes[_ip];
    final handler = _isa[instr];

    if (handler == null) {
      return VMResult.undefinedOpCode(instr);
    }

    return await handler();
  }

  bool isEnd() {
    return _ip >= _programBytes.length;
  }

  VMResult _nop() {
    return VMResult.ok();
  }

  VMResult _halt() {
    if (_logInfo) print("HALTED");

    _isHalted = true;
    return VMResult.ok();
  }
  
  VMResult _push() {
    if (_logInfo) print("PUSH");

    if (_stack.length == _stackLimit) {
      return VMResult.stackOverflow(_stackLimit);
    }

    _ip++;
    if (isEnd()) {
      return VMResult.expectedArgument(_programBytes[_ip - 1]);
    }

    _stack.push(Number(_programBytes[_ip]));
    return VMResult.ok();
  }

  VMResult _pop() {
    if (_logInfo) print("POP");

    if (_stack.isEmpty) {
      return VMResult.stackUnderflow();
    }
    _stack.pop();

    return VMResult.ok();
  }

  VMResult _add() {
    if (_logInfo) print("ADD");

    if (_stack.length < 2) {
      return VMResult.expectedStackArgs(2, _programBytes[_ip]);
    }

    final arg1 = _stack.pop() as Number;
    final arg2 = _stack.pop() as Number;

    _stack.push(Number(arg1.value + arg2.value));
    return VMResult.ok();
  }

  VMResult _sub() {
    if (_logInfo) print("SUB");

    if (_stack.length < 2) {
      return VMResult.expectedStackArgs(2, _programBytes[_ip]);
    }

    final arg1 = _stack.pop() as Number;
    final arg2 = _stack.pop() as Number;

    _stack.push(Number(arg2.value - arg1.value));
    return VMResult.ok();
  }

  VMResult _mul() {
    if (_logInfo) print("MUL");

    if (_stack.length < 2) {
      return VMResult.expectedStackArgs(2, _programBytes[_ip]);
    }

    final arg1 = _stack.pop() as Number;
    final arg2 = _stack.pop() as Number;

    _stack.push(Number(arg1.value * arg2.value));
    return VMResult.ok();
  }

  VMResult _div() {
    if (_logInfo) print("DIV");

    if (_stack.length < 2) {
      return VMResult.expectedStackArgs(2, _programBytes[_ip]);
    }

    final arg1 = _stack.pop() as Number;
    final arg2 = _stack.pop() as Number;

    if (arg1.value == 0 || arg2.value == 0) {
      return VMResult.divideByZero();
    }

    _stack.push(Number((arg2.value / arg1.value).round()));
    return VMResult.ok();
  }

  VMResult _jmp() {
    if (_logInfo) print("JMP");

    final targetIp = _programBytes[++_ip];

    // -1 to account for the offset of the ip++
    // in exec() when this method returns
    _ip = targetIp - 1;

    return VMResult.ok();
  }

  VMResult _out() {
    if (_stack.isEmpty) return VMResult.stackUnderflow();

    if (_logInfo) print("OUT: ${(_stack.peek as Number).value}");
    return VMResult.ok();
  }

  VMResult _jz() {
    if (_logInfo) print("JZ");
    
    if (_stack.isEmpty) return VMResult.stackUnderflow();

    if ((_stack.peek as Number).value != 0) {
      _ip++;
      return VMResult.ok();
    }

    _jmp();
    return VMResult.ok();
  }

  VMResult _jnz() {
    if (_logInfo) print("JNZ");

    if (_stack.isEmpty) return VMResult.stackUnderflow();

    if ((_stack.peek as Number).value == 0) {
      _ip++;
      return VMResult.ok();
    }

    _jmp();
    return VMResult.ok();
  }

  Future<VMResult> _in() async {
    if (_logInfo) print("IN");

    final input = await getInput();
    if (input.isEmpty) {
      return VMResult.expectedArgument(_programBytes[_ip]);
    }

    final value = int.tryParse(input) ?? -1;

    _stack.push(Number(value));
    return VMResult.ok();
  }
}