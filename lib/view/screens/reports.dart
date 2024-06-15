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
            Text(
              'Generar Reportes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Funcionalidad para generar reporte semanal
              },
              child: Text('Generar Reporte Semanal'),
            ),
            ElevatedButton(
              onPressed: () {
                // Funcionalidad para generar reporte mensual
              },
              child: Text('Generar Reporte Mensual'),
            ),
          ],
        ),
      ),
    );
  }
}