import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';

class Config {
  // Método para cargar el archivo .env
  static Future<void> load() async {
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      throw const FileSystemException(
          "El archivo .env no fue encontrado o no pudo ser cargado.");
    }
  }

  // Getters para las variables de entorno
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
}
