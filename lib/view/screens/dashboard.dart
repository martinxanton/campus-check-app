import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenido, Seguridad',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            Text(
              'Notificaciones',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Card(
              child: ListTile(
                title: Text('Nueva actualización disponible'),
                subtitle: Text('Versión 2.0 está disponible para su descarga.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

