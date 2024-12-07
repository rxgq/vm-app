import 'package:flutter/material.dart';

import '../../../constants.dart';

class VMStackBox extends StatefulWidget {
  const VMStackBox({super.key, required this.stackValues});

  final List<String> stackValues;

  @override
  State<VMStackBox> createState() => _VMStackBoxState();
}

class _VMStackBoxState extends State<VMStackBox> {
  @override
  Widget build(BuildContext context) {
    return _buildStack();
  }

  Widget _buildStack() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 140,
        height: vmHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "stack",
                style: font(
                  fontSize: 12
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var val in widget.stackValues) 
                      _stackItem(val),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stackItem(String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(val),
          ),
        ),
      ),
    );
  }
}