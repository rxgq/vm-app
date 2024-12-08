import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

import 'vm/models/vm_operation.dart';

const appName = "allium stack machine";

const lightGrey = Color.fromARGB(255, 244, 244, 244);

const font = GoogleFonts.jetBrainsMono;

const double buttonHeight = 34;

const double vmHeight = 280;
const double consoleHeight = 140;

const double vmWidth = 600;
const double stDoutWidth = 120;

List<VmOperation> operations = [
    VmOperation(
        name: "nop",
        opCode: 0,
        description: "No operation is executed.",
        errorsThrown: []
    ),
    VmOperation(
        name: "hlt",
        opCode: 1,
        description: "Halts the execution of the virtual machine. The program stops running.",
        errorsThrown: []
    ),
    VmOperation(
        name: "push",
        opCode: 2,
        description: "Pushes a value onto the stack.",
        errorsThrown: ["StackOverflow", "ExpectedArgument"]
    ),
    VmOperation(
        name: "pop",
        opCode: 3,
        description: "Removes the top value from the stack.",
        errorsThrown: ["StackUnderflow"]
    ),
    VmOperation(
        name: "add",
        opCode: 4,
        description: "Adds the top two values on the stack, replacing them with the result.",
        errorsThrown: ["ExpectedStackArgs"]
    ),
    VmOperation(
        name: "sub",
        opCode: 5,
        description: "Subtracts the second value on the stack from the top value, replacing them with the result.",
        errorsThrown: ["ExpectedStackArgs"]
    ),
    VmOperation(
        name: "mul",
        opCode: 6,
        description: "Multiplies the top two values on the stack, replacing them with the result.",
        errorsThrown: ["ExpectedStackArgs"]
    ),
    VmOperation(
        name: "div",
        opCode: 7,
        description: "Divides the second value on the stack by the top value, replacing them with the result.",
        errorsThrown: ["ExpectedStackArgs"]
    ),
    VmOperation(
        name: "jmp",
        opCode: 8,
        description: "Unconditionally jumps to a specified memory address in the program.",
        errorsThrown: ["ExpectedArgument"]
    ),
    VmOperation(
        name: "out",
        opCode: 9,
        description: "Outputs the top value on the stack to the standard output.",
        errorsThrown: ["StackUnderflow"]
    ),
    VmOperation(
        name: "jz",
        opCode: 10,
        description: "Jumps to a specified memory address if the top value on the stack is zero.",
        errorsThrown: ["StackUnderflow", "ExpectedArgument"]
    ),
    VmOperation(
        name: "jnz",
        opCode: 11,
        description: "Jumps to a specified memory address if the top value on the stack is not zero.",
        errorsThrown: ["StackUnderflow", "ExpectedArgument"]
    ),
    VmOperation(
        name: "in",
        opCode: 12,
        description: "Takes an integer input from the user and pushes it onto the stack.",
        errorsThrown: []
    ),
    VmOperation(
        name: "dup",
        opCode: 13,
        description: "Duplicates the value at the top of the stack.",
        errorsThrown: ["StackUnderflow"]
    ),
];