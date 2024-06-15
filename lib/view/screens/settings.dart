import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ajustes de Usuario',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Nombre'),
              subtitle: Text('Seguridad Universidad'),
              trailing: Icon(Icons.edit),
            ),
            ListTile(
              title: Text('Correo Electrónico'),
              subtitle: Text('seguridad@universidad.com'),
              trailing: Icon(Icons.edit),
            ),
            ListTile(
              title: Text('Idioma'),
              subtitle: Text('Español'),
              trailing: Icon(Icons.arrow_drop_down),
            ),
            ListTile(
              title: Text('Notificaciones'),
              trailing: Switch(value: true, onChanged: (bool value) {}),
            ),
          ],
        ),
      ),
    );
  }
}