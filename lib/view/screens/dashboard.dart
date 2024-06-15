import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Campus Check',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumen Diario',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Card(
              child: ListTile(
                title: Text('Entradas Registradas'),
                subtitle: Text('50 estudiantes han ingresado hoy'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Salidas Registradas'),
                subtitle: Text('30 estudiantes han salido hoy'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
