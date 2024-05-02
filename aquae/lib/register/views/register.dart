import 'package:aquae/register/auth/auth.dart';
import 'package:aquae/register/views/login.dart';
import 'package:aquae/register/widgets/change_register_or_login.dart';
import 'package:aquae/register/widgets/forgot_password.dart';
import 'package:aquae/register/widgets/aquae_button.dart';
import 'package:aquae/register/widgets/header.dart';
import 'package:aquae/register/widgets/text_field.dart';
import 'package:flutter/material.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SingleChildScrollView(
      child: SizedBox(
        height: 900,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 128),
            const RegisterHeader(text: "REGISTER"),
            const SizedBox(height: 128),
            RegisterTextField(text: "username", icon: Icons.person, controller: usernameController),
            RegisterTextField(text: "email", icon: Icons.email, controller: emailController),
            RegisterTextField(text: "password", icon: Icons.password, controller: passwordController),
            const SizedBox(height: 32),
            AquaeButton(text: "REGISTER", onTap: () {
              _auth.createNewUser(emailController.text, passwordController.text);
            }),
            const SizedBox(height: 16),
            const ForgotPasswordText(),       
            const SizedBox(height: 224),
            ChangeRegisterOrLogin(
              message: 'Already have and account? ', 
              actionMessage: 'Login Here', 
              onTap: () {  
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Login())
                );
              }
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    )
  );
}
