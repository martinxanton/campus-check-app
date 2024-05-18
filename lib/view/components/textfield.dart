import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final String label;
  final bool obscure;
  final TextEditingController controller;

  const TextFieldCustom(
      {super.key,
      required this.label,
      this.obscure = false,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Theme.of(context).colorScheme.onSecondary,
      obscureText: obscure,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.onSecondary)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
        labelText: label,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
      ),
    );
  }
}
