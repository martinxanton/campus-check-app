import 'dart:convert';
import 'package:campus_check_app/utils/config.dart';
import 'package:campus_check_app/services/storage_service.dart';
import 'package:campus_check_app/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

final StorageService _storageService = StorageService();

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int inCount = 0;
  int outCount = 0;

  void getRegister() async {
    final baseUrl = Config.baseUrl;
    final url = Uri.parse('$baseUrl/staff/records');
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

      List<dynamic> records = data['records'];

      // Inicializa los contadores
      int tempInCount = 0;
      int tempOutCount = 0;

      // Cuenta los registros de tipo "in" y "out"
      for (var record in records) {
        if (record['type'] == 'in') {
          tempInCount++;
        } else if (record['type'] == 'out') {
          tempOutCount++;
        }
      }

      // Actualiza el estado con los nuevos contadores
      setState(() {
        inCount = tempInCount;
        outCount = tempOutCount;
        printIfDebug('Entradas: $inCount');
        printIfDebug('Salidas: $outCount');
      });
    } else {
      // Maneja el error
      printIfDebug('Error: ${response.statusCode}');
      printIfDebug('Respuesta: ${response.body}');
    }
  }

  @override
  void initState() {
    super.initState();
    getRegister();
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen Diario',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                title: const Text('Entradas Registradas'),
                subtitle: Text('$inCount estudiantes han ingresado hoy'),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Salidas Registradas'),
                subtitle: Text('$outCount estudiantes han salido hoy'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
