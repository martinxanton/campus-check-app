import 'package:campus_check_app/view/components/card_button.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:campus_check_app/utils/config.dart';
import 'package:campus_check_app/utils/utils.dart';
import 'package:campus_check_app/models/student_model.dart';
import 'package:campus_check_app/routes/routes.dart';
import 'package:campus_check_app/view/components/dialog.dart';
import 'package:campus_check_app/services/storage_service.dart';
import 'package:http/http.dart' as http;

final StorageService _storageService = StorageService();

Future<Map<String, dynamic>?> fetchPersonData(String id, String token) async {
  final baseUrl = Config.baseUrl;
  final url = '$baseUrl/student/$id';

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

class RegisterAttendanceScreen extends StatefulWidget {
  const RegisterAttendanceScreen({super.key});

  @override
  State<RegisterAttendanceScreen> createState() =>
      _RegisterAttendanceScreenState();
}

class _RegisterAttendanceScreenState extends State<RegisterAttendanceScreen> {
  final TextEditingController _idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var title = ModalRoute.of(context)!.settings.arguments as String? ?? '';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Text(
                'Para verificar la identidad puedes usar cualquiera de las 2 opciones'),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: CardButton(
                icon: Icons.qr_code_scanner,
                title: 'Escanear código QR',
                onTap: () {
                  Navigator.pushNamed(context, Routes.scannerbar,
                      arguments: title);
                },
              ),
            ),
            const SizedBox(height: 16),
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
    if (mounted) {
      if (personData != null) {
        var args = ModalRoute.of(context)!.settings.arguments as String? ?? '';
        Navigator.pushNamed(
          context,
          Routes.profile,
          arguments: {
            'studentModel': StudentModel(
              id: personData['student']['id'],
              code: personData['student']['cod'],
              docID: personData['person']['dni'],
              name: personData['person']['firstName'],
              faculty: personData['student']['faculty'],
              career: personData['student']['career'],
              stateEnrollment: 1,
              semester: 0,
              photoURL:
                  'https://firebasestorage.googleapis.com/v0/b/campuscheck-unmsm.appspot.com/o/photo-user%2F${personData['student']['cod']}.jpg?alt=media&token=6d1fcb27-1914-4b11-a3f1-9053f203d552',
            ),
            'additionalArgs': args,
          },
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
