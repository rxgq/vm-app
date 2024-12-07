import 'package:allium/constants.dart';
import 'package:flutter/material.dart';

class AlliumButton extends StatefulWidget {
  const AlliumButton({
    super.key, 
    required this.onTap, 
    this.color = lightGrey, 
    required this.text,
    this.textColor = Colors.black,
    this.width = 120
  });

  final VoidCallback onTap;
  final Color color;
  final String text;
  final Color textColor;
  final double width;

  @override
  State<AlliumButton> createState() => _AlliumButtonState();
}

class _AlliumButtonState extends State<AlliumButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color darkenColor(Color color, [double factor = 0.07]) {
      return color
        .withRed((color.red * (1 - factor)).toInt())
        .withGreen((color.green * (1 - factor)).toInt())
        .withBlue((color.blue * (1 - factor)).toInt());
    }

    final Color hoverColor = darkenColor(widget.color);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() {
          _isHovered = true;
        }),
        onExit: (_) => setState(() {
          _isHovered = false;
        }),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            height: buttonHeight,
            width: widget.width,
            decoration: BoxDecoration(
              color: _isHovered ? hoverColor : widget.color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  widget.text,
                  style: font(
                    color: widget.textColor,
                    fontSize: 12,
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
