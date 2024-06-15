import 'package:campus_check_app/view/components/card_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:campus_check_app/providers/navigation_provider.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Registro de Asistencia',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Marque su entrada o salida con los botones de abajo.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardButton(
                      icon: Icons.checklist_outlined,
                      title: 'Entrada',
                      onTap: () {}),
                  CardButton(
                      icon: Icons.exit_to_app, title: 'Salida', onTap: () {})
                ],
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Historial de Asistencia',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Provider.of<NavigationProvider>(context, listen: false)
                        .setIndex(2); // Índice de la pantalla de historial
                  },
                  child: Text('Ver todo'),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.green),
                    title: Text('Entrada: 08:00 AM'),
                    subtitle: Text('15 de Junio, 2024'),
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app, color: Colors.red),
                    title: Text('Salida: 05:00 PM'),
                    subtitle: Text('15 de Junio, 2024'),
                  ),
                  ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.green),
                    title: Text('Entrada: 08:15 AM'),
                    subtitle: Text('14 de Junio, 2024'),
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app, color: Colors.red),
                    title: Text('Salida: 04:45 PM'),
                    subtitle: Text('14 de Junio, 2024'),
                  ),
                  // Añade más entradas de historial según sea necesario
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
