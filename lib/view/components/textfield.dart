import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final String label;
  final bool obscure;
  final TextEditingController controller;
  final String? errorText;
  final void Function(String)? onChanged;

  const TextFieldCustom(
      {super.key,
      required this.label,
      this.obscure = false,
      required this.controller,
      required this.errorText,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      cursorColor: Theme.of(context).colorScheme.onSecondary,
      obscureText: obscure,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.onSecondary)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.onPrimary)),
        labelText: label,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        errorText: errorText,
      ),
    );
  }
}
