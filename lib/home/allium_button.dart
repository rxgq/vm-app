import 'package:allium/home/constants.dart';
import 'package:flutter/material.dart';

class AlliumButton extends StatefulWidget {
  const AlliumButton({
    super.key, 
    required this.onTap, 
    this.color = lightGrey, 
    required this.text,
    this.textColor = Colors.black
  });

  final VoidCallback onTap;
  final Color color;
  final String text;
  final Color textColor;

  @override
  State<AlliumButton> createState() => _AlliumButtonState();
}

class _AlliumButtonState extends State<AlliumButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  widget.text,
                  style:  TextStyle(
                    color: widget.textColor
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}