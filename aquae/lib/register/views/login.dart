import 'package:aquae/register/views/register.dart';
import 'package:aquae/register/widgets/forgot_password.dart';
import 'package:aquae/register/widgets/aquae_button.dart';
import 'package:aquae/register/widgets/header.dart';
import 'package:aquae/register/widgets/text_field.dart';
import 'package:flutter/material.dart';

import '../widgets/change_register_or_login.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 128),
          const RegisterHeader(text: "LOGIN"),
          const SizedBox(height: 128),
          RegisterTextField(text: "email", icon: Icons.email, controller: emailController),
          RegisterTextField(text: "password", icon: Icons.password, controller: passwordController),
          const SizedBox(height: 32),
          AquaeButton(text: "LOGIN", onTap: () {
      
          }),
          const SizedBox(height: 16),
          const ForgotPasswordText(),
          const SizedBox(height: 16),
          ChangeRegisterOrLogin(
            message: 'Don\'t have and account? ', 
            actionMessage: 'Register Here', 
            onTap: () {  
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const Register())
              );
            }
          ),
        ],
      ),
    )
  );
}
