import 'package:flutter/material.dart';

import '../../constants.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key});

  @override
  Widget build(BuildContext context) => const Text(
    "Forgot your password?",
    style: TextStyle(
      fontSize: 12,
      color: primaryTextColor
    ),
  );
}
