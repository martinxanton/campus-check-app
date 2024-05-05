import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuario Encontrado'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: const Column(
          children: [
            Icon(Icons.person, size: 100),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Nombres'),
              subtitle: Text('Jeff Oneil Magallanes Aguero'),
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text('Facultad'),
              subtitle:
                  Text('Facultad de Ingenieria de Sistemas e Informatica'),
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Carrera'),
              subtitle: Text('Ingeniería de Software'),
            ),
            ListTile(
              leading: Icon(Icons.science),
              title: Text('Ciclo'),
              subtitle: Text('IX'),
            ),
            ListTile(
              leading: Icon(Icons.app_registration_rounded),
              title: Text('Estado de Matricula'),
              subtitle: Text('Suspendido'),
            ),
          ],
        ),
      ),
    );
  }
}
