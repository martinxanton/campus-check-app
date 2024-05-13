// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:campus_check_app/models/student_model.dart';
import 'package:campus_check_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:campus_check_app/view/components/dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Campus Check'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
                'Para verificar la identidad puedes usar cualquiera de las 2 opciones'),
            const SizedBox(height: 16),
            CardWidget(
              leftIcon: Icons.badge_outlined,
              label: 'Escanear carnet / DNI',
              onTap: () {
                Navigator.pushNamed(context, Routes.scannerbar);
              },
            ),
            CardWidget(
              leftIcon: Icons.face_outlined,
              label: 'Escanear rostro',
              onTap: () {
                Navigator.pushNamed(context, Routes.scannerface);
              },
            ),
            CodeTextField(controller: controller),
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
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      onChanged: (value) {
        // Cuando cambie el texto en el TextField, actualiza el estado del widget.
        setState(() {});
      },
      controller: widget.controller,
      cursorColor: Colors.black45,
      decoration: InputDecoration(
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black45)),
        labelText: 'Ingrese el código',
        labelStyle: const TextStyle(color: Colors.black45),
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: widget.controller.text.isEmpty ||
                  widget.controller.text.length < 8
              ? null // Si el TextField está vacío, deshabilita el botón.
              : () async {
                  String text = widget.controller.text.trim();
                  String responseJson = '';
                  bool isSucess = true;
                  if (text == '20200133') {
                    responseJson = await rootBundle
                        .loadString('assets/json/20200133.json');
                  } else if (text == '20200137') {
                    responseJson = await rootBundle
                        .loadString('assets/json/20200137.json');
                  } else if (text == '20200012') {
                    responseJson = await rootBundle
                        .loadString('assets/json/20200012.json');
                  } else if (text == '20200054') {
                    responseJson = await rootBundle
                        .loadString('assets/json/20200054.json');
                  } else if (text == '20200297') {
                    responseJson = await rootBundle
                        .loadString('assets/json/20200297.json');
                  } else {
                    isSucess = false;
                  }

                  if (isSucess == false) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const DialogBox();
                      },
                    );
                    return;
                  } else {
                    final userData = json.decode(responseJson);
                    Navigator.pushNamed(context, Routes.profile,
                        arguments: StudentModel(
                          code: userData['code'],
                          docID: userData['docID'],
                          name: userData['name'],
                          faculty: userData['faculty'],
                          career: userData['career'],
                          stateEnrollment: userData['stateEnrollment'],
                          semester: userData['semester'],
                          photoURL: userData['photoURL'],
                        ));
                  }
                },
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final IconData leftIcon;
  final String label;
  final VoidCallback onTap;

  const CardWidget({
    super.key,
    required this.leftIcon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.black87,
          width: 1.0,
        ),
      ),
      elevation: 0,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(leftIcon, color: Colors.black87),
        title: Text(label,
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded,
            size: 16, color: Colors.black),
        onTap: onTap,
      ),
    );
  }
}
