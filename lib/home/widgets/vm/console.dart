import 'package:flutter/material.dart';

import '../../../constants.dart';

class VMConsole extends StatefulWidget {
  const VMConsole({super.key, required this.values});

  final List<String> values;

  @override
  State<VMConsole> createState() => _VMConsoleState();
}

class _VMConsoleState extends State<VMConsole> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 600,
        height: consoleHeight,
        decoration: BoxDecoration(
          border: Border.all(color: lightGrey, width: 4),
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.values.join("\n"),
            style: font(fontSize: 14, color: Colors.black),
          ),
        ),
      ),
    );
  }
}