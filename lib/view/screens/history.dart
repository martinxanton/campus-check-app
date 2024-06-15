import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            ListTile(
              title: Text('15 de Junio, 2024'),
              subtitle: Text('Entrada: 08:00 AM | Salida: 05:00 PM'),
            ),
            ListTile(
              title: Text('14 de Junio, 2024'),
              subtitle: Text('Entrada: 08:15 AM | Salida: 04:45 PM'),
            ),
            ListTile(
              title: Text('13 de Junio, 2024'),
              subtitle: Text('Entrada: 08:05 AM | Salida: 05:10 PM'),
            ),
            // Más registros de ejemplo
          ],
        ),
      ),
    );
  }
}
