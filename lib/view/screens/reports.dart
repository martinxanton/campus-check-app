import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Generar Reportes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Funcionalidad para generar reporte semanal
              },
              child: const Text('Generar Reporte Semanal'),
            ),
            ElevatedButton(
              onPressed: () {
                // Funcionalidad para generar reporte mensual
              },
              child: const Text('Generar Reporte Mensual'),
            ),
          ],
        ),
      ),
    );
  }
}