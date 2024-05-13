import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final String label;
  final bool obscure;

  const TextFieldCustom({super.key, required this.label, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.black38,
      obscureText: obscure,
      decoration: InputDecoration(
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black45),
      ),
    );
  }
}