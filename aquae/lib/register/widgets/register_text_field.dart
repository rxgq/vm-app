import 'package:flutter/material.dart';

class RegisterTextField extends StatelessWidget {
  const RegisterTextField({super.key, required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(64),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.white,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Icon(
                icon,
                    color: const Color.fromARGB(255, 196, 196, 196)
              ),
            ),
            SizedBox(
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  hintText: text,
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 196, 196, 196)
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  border: InputBorder.none
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}