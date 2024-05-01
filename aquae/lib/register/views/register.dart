import 'package:aquae/register/widgets/register_text_field.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "REGISTER"
          ),
          RegisterTextField(text: "email", icon: Icons.email),
          RegisterTextField(text: "password", icon: Icons.password),
        ],
      )
    );
  }
}