import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Usuario no encontrado'),
      content: const Text('¿Deseas registrar al usuario?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.popAndPushNamed(context, '/register'),
          child: const Text('Sí'),
        ),
      ],
    );
  }
}
