import 'package:campus_check_app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:campus_check_app/routes/routes.dart';

final storageService = StorageService();

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Configuración',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              title: Text('Nombre'),
              subtitle: Text('Seguridad Universidad'),
              trailing: Icon(Icons.edit),
            ),
            const ListTile(
              title: Text('Correo Electrónico'),
              subtitle: Text('seguridad@universidad.com'),
              trailing: Icon(Icons.edit),
            ),
            const ListTile(
              title: Text('Idioma'),
              subtitle: Text('Español'),
              trailing: Icon(Icons.arrow_drop_down),
            ),
            ListTile(
              title: const Text('Notificaciones'),
              trailing: Switch(value: true, onChanged: (bool value) {}),
            ),
            const ListTile(
              title: Text('Tema'),
              subtitle: Text('Claro'),
              trailing: Icon(Icons.arrow_drop_down),
            ),
            FilledButton(
                onPressed: () => {
                      storageService.deleteToken(),
                      Navigator.popAndPushNamed(context, Routes.login)
                    },
                child: const Text('Cerrar Sesión'))
          ],
        ),
      ),
    );
  }
}
