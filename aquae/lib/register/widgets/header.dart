import 'package:flutter/material.dart';

import '../../constants.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      color: secondaryTextColor,
      fontSize: 20,
      fontWeight: FontWeight.bold
    ),
  );
}
