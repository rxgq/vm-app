import 'package:aquae/register/widgets/register_text_field.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 128),
          Text(
            "REGISTER",
            style: TextStyle(
              color: Color.fromARGB(255, 197, 197, 197),
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 128),
          RegisterTextField(text: "email", icon: Icons.email),
          RegisterTextField(text: "password", icon: Icons.password),
        ],
      )
    );
  }
}