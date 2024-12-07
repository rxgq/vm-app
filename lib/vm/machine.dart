import 'package:allium/vm/parser.dart';
import 'package:allium/vm/result.dart';
import 'package:allium/vm/stack.dart';
import 'package:allium/vm/value.dart';

abstract interface class VM {
  void execute();
}

final class VirtualMachine implements VM {

  // a string representation of the program loaded into the virtual machine
  final String _programStr;

  // executable bytecode compiled from the program string
  late final List<int> _program;

  // virtual stack
  final _stack = VMStack();

  // max number of items allowed on the virtual stack
  static const _stackLimit = 64;

  // a pointer to the current instruction in program
  int _ip = 0;

  // a flag that will halt the execution of instructions if 'true'
  bool _isHalted = false;

  // Instruction Set Architecture
  late final Map<int, Function> _isa;

  // number of instructions to execute per second
  static const _execSpeed = 32;

  VirtualMachine({
    required String programStr,
  }) : _programStr = programStr {
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
    };
  }

  @override
  Future<VMResult> execute() async {
    final parser = VirtualMachineParser(source: _programStr);
    final result = parser.parse();

    if (!result.isSuccess) return result;
    _program = result.value;

    while (!isEnd() && !_isHalted) {
      var result = _eval();
      if (!result.isSuccess) return result;

      _ip++;

      await Future.delayed(Duration(milliseconds: (1000 / _execSpeed).round()));
    }

    _stack.dump();
    return VMResult.ok();
  }

  VMResult _eval() {
    final instr = _program[_ip];
    final handler = _isa[instr];

    if (handler == null) {
      return VMResult.undefinedOpCode(instr);
    }

    return handler();
  }

  bool isEnd() {
    return _ip >= _program.length;
  }

  VMResult _nop() {
    return VMResult.ok();
  }

  VMResult _halt() {
    print("HALTED");

    _isHalted = true;
    return VMResult.ok();
  }
  
  VMResult _push() {
    if (_stack.length == _stackLimit) {
      return VMResult.stackOverflow(_stackLimit);
    }

    _ip++;
    if (isEnd()) {
      return VMResult.expectedArgument(_program[_ip - 1]);
    }

    _stack.push(Number(_program[_ip]));
    return VMResult.ok();
  }

  VMResult _pop() {
    if (_stack.isEmpty) {
      return VMResult.stackUnderflow();
    }

    _stack.pop();
    return VMResult.ok();
  }

  VMResult _add() {
    if (_stack.length < 2) {
      return VMResult.expectedStackArgs(2, _program[_ip]);
    }

    final arg1 = _stack.pop() as Number;
    final arg2 = _stack.pop() as Number;

    _stack.push(Number(arg1.value + arg2.value));
    return VMResult.ok();
  }

  VMResult _sub() {
    if (_stack.length < 2) {
      return VMResult.expectedStackArgs(2, _program[_ip]);
    }

    final arg1 = _stack.pop() as Number;
    final arg2 = _stack.pop() as Number;

    _stack.push(Number(arg2.value - arg1.value));
    return VMResult.ok();
  }

  VMResult _mul() {
    if (_stack.length < 2) {
      return VMResult.expectedStackArgs(2, _program[_ip]);
    }

    final arg1 = _stack.pop() as Number;
    final arg2 = _stack.pop() as Number;

    _stack.push(Number(arg1.value * arg2.value));
    return VMResult.ok();
  }

  VMResult _div() {
    if (_stack.length < 2) {
      return VMResult.expectedStackArgs(2, _program[_ip]);
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
    final targetIp = _program[++_ip];

    // -1 to account for the offset of the ip++
    // in exec() when this method returns
    _ip = targetIp - 1;

    return VMResult.ok();
  }

  VMResult _out() {
    print((_stack.peek as Number).value);
    return VMResult.ok();
  }

  VMResult _jz() {
    if (_stack.isEmpty) return VMResult.stackUnderflow();

    if ((_stack.peek as Number).value != 0) {
      _ip++;
      return VMResult.ok();
    }

    _jmp();
    return VMResult.ok();
  }

  VMResult _jnz() {
    if (_stack.isEmpty) return VMResult.stackUnderflow();

    if ((_stack.peek as Number).value == 0) {
      _ip++;
      return VMResult.ok();
    }

    _jmp();
    return VMResult.ok();
  }
}