import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Check'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'Para verificar la identidad puedes usar cualquiera de las 2 opciones'),
            FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.badge_outlined, color: Colors.white),
                label: const Text('Escanear carnet')),
            FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.badge_outlined, color: Colors.white),
                label: const Text('Escanear código QR')),
            FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.sentiment_satisfied_alt,
                    color: Colors.white),
                label: const Text('Escanear rostro')),
          ],
        ),
      ),
    );
  }
}
