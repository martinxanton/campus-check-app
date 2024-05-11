import 'package:campus_check_app/screens/camera.dart';
import 'package:campus_check_app/screens/camera_2.dart';
import 'package:campus_check_app/screens/home.dart';
import 'package:campus_check_app/screens/login.dart';
import 'package:campus_check_app/screens/user_profile.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = '/';
  static const String profile = '/profile';
  static const String scannerbar = '/scannerbar';
  static const String scannerface = '/scannerface';
  static const String login = '/login';
  static const String camera = '/camera';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case profile:
        return MaterialPageRoute(
            builder: (context) => const UserProfilePage(), settings: settings);
      case login:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case camera:
        return MaterialPageRoute(builder: (context) => const CameraScreen());
      case scannerbar:
        return MaterialPageRoute(
            builder: (context) => const BarcodeScannerView(),
            settings: settings);
      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(
                    child: Text('Error: Ruta no encontrada'),
                  ),
                ));
    }
  }
}
