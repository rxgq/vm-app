import 'package:aquae/register/widgets/forgot_password_text.dart';
import 'package:aquae/register/widgets/register_button.dart';
import 'package:aquae/register/widgets/register_header.dart';
import 'package:aquae/register/widgets/register_text_field.dart';
import 'package:flutter/material.dart';


class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 128),
        const RegisterHeader(),
        const SizedBox(height: 128),
        const RegisterTextField(text: "email", icon: Icons.email),
        const RegisterTextField(text: "password", icon: Icons.password),
        const SizedBox(height: 32),
        AquaeButton(text: "REGISTER", onTap: () {

        }),
        const SizedBox(height: 16),
        const ForgotPasswordText(),
      ],
    )
  );
}
