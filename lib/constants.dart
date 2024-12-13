import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

import 'vm/machine/vm_macro.dart';
import 'vm/models/vm_operation.dart';

const appName = "griffin stack machine";

const lightGrey = Color.fromARGB(255, 244, 244, 244);

const font = GoogleFonts.jetBrainsMono;

const double buttonHeight = 34;

const double vmHeight = 280;
const double consoleHeight = 140;

const double vmWidth = 600;
const double stDoutWidth = 120;

final _nop = VMOperation(
  name: "nop",
  opCode: 0,
  description: "No operation is executed.",
  errorsThrown: []
);

final _hlt = VMOperation(
  name: "hlt",
  opCode: 1,
  description: "Halts the execution of the virtual machine. The program stops running.",
  errorsThrown: []
);

final _push = VMOperation(
  name: "push",
  opCode: 2,
  description: "Pushes a value onto the stack.",
  errorsThrown: ["StackOverflow", "ExpectedArgument"]
);

final _pop = VMOperation(
  name: "pop",
  opCode: 3,
  description: "Removes the top value from the stack.",
  errorsThrown: ["StackUnderflow"]
);

final _add = VMOperation(
  name: "add",
  opCode: 4,
  description: "Adds the top two values on the stack, replacing them with the result.",
  errorsThrown: ["ExpectedStackArgs"]
);

final _sub = VMOperation(
  name: "sub",
  opCode: 5,
  description: "Subtracts the second value on the stack from the top value, replacing them with the result.",
  errorsThrown: ["ExpectedStackArgs"]
);

final _mul = VMOperation(
  name: "mul",
  opCode: 6,
  description: "Multiplies the top two values on the stack, replacing them with the result.",
  errorsThrown: ["ExpectedStackArgs"]
);

final _div = VMOperation(
  name: "div",
  opCode: 7,
  description: "Divides the second value on the stack by the top value, replacing them with the result.",
  errorsThrown: ["ExpectedStackArgs"]
);

final _jmp = VMOperation(
  name: "jmp",
  opCode: 8,
  description: "Unconditionally jumps to a specified memory address in the program.",
  errorsThrown: ["ExpectedArgument"]
);

final _out = VMOperation(
  name: "out",
  opCode: 9,
  description: "Outputs the top value on the stack to the standard output.",
  errorsThrown: ["StackUnderflow"]
);

final _jz = VMOperation(
  name: "jz",
  opCode: 10,
  description: "Jumps to a specified memory address if the top value on the stack is zero.",
  errorsThrown: ["StackUnderflow", "ExpectedArgument"]
);

final _jnz = VMOperation(
  name: "jnz",
  opCode: 11,
  description: "Jumps to a specified memory address if the top value on the stack is not zero.",
  errorsThrown: ["StackUnderflow", "ExpectedArgument"]
);

final _in = VMOperation(
  name: "in",
  opCode: 12,
  description: "Takes an integer input from the user and pushes it onto the stack.",
  errorsThrown: ["StackOverflow"]
);

final _dup = VMOperation(
  name: "dup",
  opCode: 13,
  description: "Duplicates the value at the top of the stack.",
  errorsThrown: ["ExpectedStackArgs", "StackOverflow"]
);

final _swp = VMOperation(
  name: "swp",
  opCode: 14,
  description: "Swaps the top two values at the top of the stack.",
  errorsThrown: ["ExpectedStackArgs"]
);

List<VMOperation> operations = [
  _nop,
  _hlt,
  _push,
  _pop,
  _add,
  _sub,
  _mul,
  _div,
  _jmp,
  _out,
  _jz,
  _jnz,
  _in,
  _dup,
  _swp,
];

List<VMMacro> macros = [
  VMMacro(
    commandName: "outfive",
    operations: [
      _out, _out, _out, _out, _out
    ]
  ),
];