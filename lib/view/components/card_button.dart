import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final IconData leftIcon;
  final String label;
  final VoidCallback onTap;

  const CardButton({
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
