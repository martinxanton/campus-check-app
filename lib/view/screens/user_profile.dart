import 'dart:convert';

import 'package:campus_check_app/models/student_model.dart';
import 'package:campus_check_app/utils/utils.dart';
import 'package:campus_check_app/view/components/button.dart';
import 'package:flutter/material.dart';
import 'package:campus_check_app/services/storage_service.dart';
import 'package:http/http.dart' as http;

final StorageService _storageService = StorageService();

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final StudentModel userModel = args['studentModel'] as StudentModel;
    final String additionalArgs = args['additionalArgs'] as String;

    void sendPostRequest(type) async {
      final url = Uri.parse('http://192.168.18.36:5050/api/v1/record/');
      String token = await _storageService.getToken() ?? '';
      printIfDebug('Token: $token');
      if (type == 'Entrada') {
        type = 'in';
      } else {
        type = 'out';
      }

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final body = jsonEncode({
        'personId': userModel.id,
        'type': type, // o 'out'
        'gate': 7,
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // Maneja la respuesta exitosa
        printIfDebug('Respuesta: ${response.body}');
      } else {
        // Maneja el error
        printIfDebug('Error: ${response.statusCode}');
        printIfDebug('Respuesta: ${response.body}');
      }
    }

    String enrollmentText = '';
    Color enrollmentColor = Colors.red;

    if (userModel.stateEnrollment == 1) {
      enrollmentText = 'Matriculado';
      enrollmentColor = Colors.green; // Color para el estado 1
    } else if (userModel.stateEnrollment == 2) {
      enrollmentText = 'Suspendido';
      enrollmentColor = Colors.grey; // Color para el estado 2
    } else if (userModel.stateEnrollment == 3) {
      enrollmentText = 'Egresado';
      enrollmentColor = Colors.orange; // Color para el estado 3
    } else {
      enrollmentText = 'No disponible';
      enrollmentColor = Colors.red; // Color predeterminado para otros estados
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Perfil',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(10, 0, 0, 0),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                              image: NetworkImage(userModel.photoURL),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: enrollmentColor,
                            ),
                            child: Text(
                              enrollmentText,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userModel.name,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          'Estudiante',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      _buildUserInfoTile(const Icon(Icons.qr_code_outlined),
                          'Código de alumno', userModel.code, context),
                      const SizedBox(height: 10),
                      _buildUserInfoTile(
                          const Icon(Icons.perm_identity_outlined),
                          'DNI',
                          userModel.docID,
                          context),
                      const SizedBox(height: 10),
                      _buildUserInfoTile(const Icon(Icons.school_outlined),
                          'Facultad', userModel.faculty, context),
                      const SizedBox(height: 10),
                      _buildUserInfoTile(const Icon(Icons.book_outlined),
                          'Carrera', userModel.career, context),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          child: Text(
                            'Registrar $additionalArgs',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          onPressed: () => {
                            sendPostRequest(additionalArgs),
                            Navigator.pop(context)
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoTile(
      Icon icon, String title, String? subtitle, BuildContext? context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context!).colorScheme.secondary),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        subtitle: Text(subtitle ?? 'No disponible'),
      ),
    );
  }
}
