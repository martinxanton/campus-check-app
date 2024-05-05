import 'package:campus_check_app/routes/routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title:
            const Text('Campus Check', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF831216),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
                'Para verificar la identidad puedes usar cualquiera de las 2 opciones'),
            const SizedBox(height: 16),
            CardWidget(
              leftIcon: Icons.badge_outlined,
              label: 'Escanear carnet',
              onTap: () {
                Navigator.pushNamed(context, Routes.camera);
              },
            ),
            CardWidget(
              leftIcon: Icons.badge_outlined,
              label: 'Escanear DNI',
              onTap: () {
                Navigator.pushNamed(context, Routes.scannerbar);
              },
            ),
            /*
            CardWidget(
              leftIcon: Icons.face_outlined,
              label: 'Escanear rostro',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FaceIdPage()));
              },
            ),
            */
          ],
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
    Key? key,
    required this.leftIcon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.black45,
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
