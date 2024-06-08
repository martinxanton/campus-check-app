import 'package:flutter/material.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Registrat Usuario',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [Text('Register User')],
        ),
      ),
    );
  }
}
