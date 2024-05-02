import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ChangeRegisterOrLogin extends StatelessWidget {
  const ChangeRegisterOrLogin({super.key, required this.onTap, required this.message, required this.actionMessage});

  final VoidCallback onTap;

  final String message;
  final String actionMessage;

  @override
  Widget build(BuildContext context) => RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: message,
          style: const TextStyle(
            fontSize: 12,
            color: primaryTextColor,
          ),
        ),
        TextSpan(
          text: actionMessage,
          style: const TextStyle(
            fontSize: 12,
            color: primaryTextColor,
            fontWeight: FontWeight.bold
          ),
          recognizer: TapGestureRecognizer()..onTap = onTap,
        ),
      ],
    ),
  );
}
