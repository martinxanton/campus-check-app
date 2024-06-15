import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Historial de Asistencia',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Entrada: 08:00 AM - 20200128'),
              subtitle: Text('15 de Junio, 2024'),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Salida: 05:00 PM  - 20200012'),
              subtitle: Text('15 de Junio, 2024'),
            ),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Entrada: 08:00 AM - 20200012'),
              subtitle: Text('15 de Junio, 2024'),
            ),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Entrada: 08:00 AM - 20200012'),
              subtitle: Text('15 de Junio, 2024'),
            ),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Entrada: 08:00 AM - 20200012'),
              subtitle: Text('15 de Junio, 2024'),
            ),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Entrada: 08:00 AM - 20200012'),
              subtitle: Text('15 de Junio, 2024'),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Salida: 05:00 PM - 20200012'),
              subtitle: Text('15 de Junio, 2024'),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Salida: 05:00 PM - 20200135'),
              subtitle: Text('15 de Junio, 2024'),
            ),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Entrada: 08:00 AM - 20200012'),
              subtitle: Text('15 de Junio, 2024'),
            ),
          ],
        ),
      ),
    );
  }
}
