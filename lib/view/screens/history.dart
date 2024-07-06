import 'dart:convert';

import 'package:campus_check_app/services/storage_service.dart';
import 'package:campus_check_app/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

final StorageService _storageService = StorageService();

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> records = [];

  @override
  void initState() {
    super.initState();
    getRegister();
  }

  String changueName(String name) {
    if (name == 'in') {
      return 'Entrada';
    } else {
      return 'Salida';
    }
  }

  void getRegister() async {
    final url = Uri.parse('http://192.168.18.36:5050/api/v1/staff/records');
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
      printIfDebug('Registros: $fetchedRecords');

      // Procesa los registros y actualiza el estado
      setState(() {
        records = fetchedRecords.map((record) {
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
          'Historial de Asistencia',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: records.length,
          itemBuilder: (context, index) {
            var record = records[index];
            printIfDebug('Registroto: $record');
            if (record.isEmpty) {
              return const ListTile(
                title: Text('No hay registros'),
              );
            }
            return ListTile(
              leading: Icon(record['icon'], color: record['color']),
              title: Text(
                  '${changueName(record['type'])}: ${record['time']} - ${record['personId']}'),
              subtitle: Text(record['date']),
            );
          },
        ),
      ),
    );
  }
}
