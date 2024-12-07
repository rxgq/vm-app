import 'package:flutter/material.dart';

import '../../../constants.dart';

class VMStdout extends StatefulWidget {
  const VMStdout({super.key, required this.stdout});

  final List<String> stdout;

  @override
  State<VMStdout> createState() => _VMStdoutState();
}

class _VMStdoutState extends State<VMStdout> {
  @override
  Widget build(BuildContext context) {
    return _buildOutput();
  }

  Widget _buildOutput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        width: 120,
        height: vmHeight + consoleHeight + 8,
        decoration: BoxDecoration(
          border: Border.all(color: lightGrey, width: 4),
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "stdout",
                style: font(
                  fontSize: 12
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      widget.stdout.join("\n"),
                      style: font(
                        fontSize: 14, 
                        color: Colors.black
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}