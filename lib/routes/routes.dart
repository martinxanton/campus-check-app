import 'package:campus_check_app/view/screens/bardcode_scanner.dart';
import 'package:campus_check_app/view/screens/face_detector.dart';
import 'package:campus_check_app/view/home.dart';
import 'package:campus_check_app/view/screens/login.dart';
import 'package:campus_check_app/view/screens/user_profile.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = '/';
  static const String profile = '/profile';
  static const String scannerbar = '/scannerbar';
  static const String scannerface = '/scannerface';
  static const String login = '/login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case profile:
        return MaterialPageRoute(
            builder: (context) => const UserProfilePage(), settings: settings);
      case login:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case scannerbar:
        return MaterialPageRoute(
            builder: (context) => const BarcodeScannerView(),
            settings: settings);
      case scannerface:
        return MaterialPageRoute(
            builder: (context) => const FaceMeshDetectorView(), settings: settings);
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
