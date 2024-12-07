import 'package:allium/constants.dart';
import 'package:flutter/material.dart';

class AlliumField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final double width;
  final double height;
  final int? maxLines;
  final bool readonly;

  const AlliumField({
    super.key,
    required this.controller,
    this.hintText,
    this.width = 120,
    this.height = 212,
    this.maxLines = 1,
    this.readonly = false
  });

  @override
  State<AlliumField> createState() => _AlliumFieldState();
}

class _AlliumFieldState extends State<AlliumField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: TextField(
            cursorColor: const Color.fromARGB(255, 195, 195, 195),
            controller: widget.controller,
            enabled: !widget.readonly,
            readOnly: widget.readonly,
            maxLines: widget.maxLines,
            style: font(
              fontSize: 12
            ),
            decoration: InputDecoration(
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16.0, 
              ),
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey[400]),
            ),
          ),
        ),
      ),
    );
  }
}
