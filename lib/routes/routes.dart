import 'package:campus_check_app/view/screens/bardcode_scanner.dart';
import 'package:campus_check_app/view/screens/detected_user.dart';
import 'package:campus_check_app/view/screens/face_detector.dart';
import 'package:campus_check_app/view/home.dart';
import 'package:campus_check_app/view/screens/login.dart';
import 'package:campus_check_app/view/screens/register_attendance.dart';
import 'package:campus_check_app/view/screens/register_user.dart';
import 'package:campus_check_app/view/screens/user_profile.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = '/home';
  static const String attendance = '/attendance';
  static const String profile = '/profile';
  static const String scannerbar = '/scannerbar';
  static const String scannerface = '/scannerface';
  static const String registeruser = '/register';
  static const String detecteduser = '/detected';
  static const String login = '/';

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
            builder: (context) => const FaceMeshDetectorView(),
            settings: settings);
      case registeruser:
        return MaterialPageRoute(
            builder: (context) => const RegisterUserScreen(),
            settings: settings);
      case detecteduser:
        return MaterialPageRoute(
            builder: (context) => const DetectedUserScreen(),
            settings: settings);
      case attendance:
        return MaterialPageRoute(
            builder: (context) => const RegisterAttendanceScreen(), settings: settings);
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
