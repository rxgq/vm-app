import 'package:flutter/material.dart';

import '../../constants.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) => const Text(
    "REGISTER",
    style: TextStyle(
      color: secondaryTextColor,
      fontSize: 20,
      fontWeight: FontWeight.bold
    ),
  );
}
