import 'dart:convert';
import 'package:campus_check_app/utils/config.dart';
import 'package:campus_check_app/services/storage_service.dart';
import 'package:campus_check_app/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:campus_check_app/routes/routes.dart';
import 'package:campus_check_app/view/components/card_button.dart';
import 'package:provider/provider.dart';
import 'package:campus_check_app/providers/navigation_provider.dart';

final StorageService _storageService = StorageService();

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<Map<String, dynamic>> records = [];

  @override
  void initState() {
    super.initState();
    getRecentRecords();
  }

  String changueName(String name) {
    if (name == 'in') {
      return 'Entrada';
    } else {
      return 'Salida';
    }
  }

  void getRecentRecords() async {
    final baseUrl = Config.baseUrl;
    final url = Uri.parse('$baseUrl/staff/records');
    // Aquí deberías manejar la obtención del token de autenticación según tu lógica
    // String token = await _storageService.getToken() ?? '';
    String token = await _storageService.getToken() ?? '';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // Maneja la respuesta exitosa
      printIfDebug('Respuesta: ${response.body}');
      final data = json.decode(response.body);

      List<dynamic> fetchedRecords = data['records'];

      setState(() {
        records = fetchedRecords.take(4).map((record) {
          String type = record['type'];
          IconData icon = type == 'in' ? Icons.check_circle : Icons.exit_to_app;
          Color color = type == 'in' ? Colors.green : Colors.red;
          String time = DateTime.parse(record['createdAt'])
              .toLocal()
              .toString()
              .split(' ')[1]
              .substring(0, 5);
          String date = DateTime.parse(record['createdAt'])
              .toLocal()
              .toString()
              .split(' ')[0];
          return {
            'type': type,
            'icon': icon,
            'color': color,
            'time': time,
            'date': date,
            'personId': record['personId'],
          };
        }).toList();
      });
    } else {
      // Maneja el error
      printIfDebug('Error: ${response.statusCode}');
      printIfDebug('Respuesta: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Registro de Asistencia',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Marque su entrada o salida con los botones de abajo.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardButton(
                      icon: Icons.checklist_outlined,
                      title: 'Entrada',
                      onTap: () {
                        Navigator.pushNamed(context, Routes.attendance,
                            arguments: 'Entrada');
                      }),
                  CardButton(
                      icon: Icons.exit_to_app,
                      title: 'Salida',
                      onTap: () {
                        Navigator.pushNamed(context, Routes.attendance,
                            arguments: 'Salida');
                      }),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Historial de Asistencia',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Provider.of<NavigationProvider>(context, listen: false)
                        .setIndex(2); // Índice de la pantalla de historial
                  },
                  child: const Text('Ver todo'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: records.length,
                itemBuilder: (context, index) {
                  var record = records[index];
                  return ListTile(
                    leading: Icon(record['icon'], color: record['color']),
                    title: Text(
                        '${changueName(record['type'])} - ${record['time']}'),
                    subtitle: Text('${record['date']} - ${record['personId']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
