import 'package:allium/home/widgets/operations/vm_operations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

import 'vm/models/vm_operation.dart';

const lightGrey = Color.fromARGB(255, 244, 244, 244);

const font = GoogleFonts.jetBrainsMono;

const double buttonHeight = 34;

const double vmHeight = 280;
const double consoleHeight = 140;

const double vmWidth = 600;
const double stDoutWidth = 120;

// const Map<String, int> opCodeMap = {
//     'nop':  0x00,
//     'hlt':  0x01,
//     'push': 0x02,
//     'pop':  0x03,
//     'add':  0x04,
//     'sub':  0x05,
//     'mul':  0x06,
//     'div':  0x07,
//     'jmp':  0x08,
//     'out':  0x09,
//     'jz':   0x0a,
//     'jnz':  0x0b,
//     'in':   0x0c,
//   };

List<VmOperation> operations = [
    VmOperation(
        name: "nop",
        opCode: 0,
        description: ""
    ),
    VmOperation(
        name: "hlt",
        opCode: 1,
        description: ""
    ),
    VmOperation(
        name: "push",
        opCode: 2,
        description: ""
    ),
    VmOperation(
        name: "pop",
        opCode: 3,
        description: ""
    ),
    VmOperation(
        name: "add",
        opCode: 4,
        description: ""
    ),
    VmOperation(
        name: "sub",
        opCode: 5,
        description: ""
    ),
    VmOperation(
        name: "mul",
        opCode: 6,
        description: ""
    ),
    VmOperation(
        name: "div",
        opCode: 7,
        description: ""
    ),
    VmOperation(
        name: "jmp",
        opCode: 8,
        description: ""
    ),
    VmOperation(
        name: "out",
        opCode: 9,
        description: ""
    ),
    VmOperation(
        name: "jz",
        opCode: 10,
        description: ""
    ),
    VmOperation(
        name: "jnz",
        opCode: 11,
        description: ""
    ),
    VmOperation(
        name: "in",
        opCode: 12,
        description: ""
    ),
];