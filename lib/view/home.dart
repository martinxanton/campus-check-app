import 'dart:convert';
import 'package:campus_check_app/models/student_model.dart';
import 'package:campus_check_app/routes/routes.dart';
import 'package:campus_check_app/utils/utils.dart';
import 'package:campus_check_app/view/components/card_button.dart';
import 'package:flutter/material.dart';
import 'package:campus_check_app/view/components/dialog.dart';
import 'package:campus_check_app/services/storage_service.dart';
import 'package:http/http.dart' as http;

final StorageService _storageService = StorageService();

Future<Map<String, dynamic>?> fetchPersonData(String id, String token) async {
  final url = 'http://192.168.18.36:5050/api/v1/student/$id';

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load person data');
    }
  } catch (e) {
    printIfDebug('Error fetching person data: $e');
    return null;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _idController = TextEditingController();

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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
                'Para verificar la identidad puedes usar cualquiera de las 2 opciones'),
            const SizedBox(height: 16),
            CardButton(
              leftIcon: Icons.badge_outlined,
              label: 'Escanear carnet / DNI',
              onTap: () {
                Navigator.pushNamed(context, Routes.scannerbar);
              },
            ),
            CardButton(
              leftIcon: Icons.face_outlined,
              label: 'Escanear rostro',
              onTap: () {
                Navigator.pushNamed(context, Routes.scannerface);
              },
            ),
            CodeTextField(controller: _idController),
          ],
        ),
      ),
    );
  }
}

class CodeTextField extends StatefulWidget {
  const CodeTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<CodeTextField> createState() => _CodeTextFieldState();
}

class _CodeTextFieldState extends State<CodeTextField> {
  Future<void> _search() async {
    String id = widget.controller.text.trim();
    if (id.isEmpty || id.length < 8) return;

    String token = await _storageService.getToken() ?? '';
    var personData = await fetchPersonData(id, token);

    if (personData != null) {
      Navigator.pushNamed(
        context,
        Routes.profile,
        arguments: StudentModel(
          code: personData['student']['cod'],
          docID: personData['person']['dni'],
          name: personData['person']['firstName'],
          faculty: personData['student']['faculty'],
          career: personData['student']['career'],
          stateEnrollment: 1,
          semester: 0,
          photoURL: personData['student']['image'],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const DialogBox();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: widget.controller,
      decoration: InputDecoration(
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: 'Ingrese el código',
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: _search,
        ),
      ),
      onChanged: (value) {
        setState(() {});
      },
    );
  }
}
