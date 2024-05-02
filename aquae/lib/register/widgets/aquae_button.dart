import 'package:flutter/material.dart';

import '../../constants.dart';

class AquaeButton extends StatelessWidget {
  const AquaeButton({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      width: 200,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(64),
        color: const Color.fromARGB(255, 234, 234, 234),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: primaryTextColor,
            fontSize: 12,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    ),
  );
}
