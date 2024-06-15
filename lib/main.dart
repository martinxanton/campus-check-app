import 'package:camera/camera.dart';
import 'package:campus_check_app/view/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:campus_check_app/theme/theme.dart';
import 'package:campus_check_app/utils/utils.dart';
import 'package:campus_check_app/routes/routes.dart';
import 'package:campus_check_app/providers/navigation_provider.dart';

// Global variable for storing the list of cameras available
List<CameraDescription> cameras = [];

Future<void> main() async {
  // Fetch the available cameras before initializing the app
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    debugPrint('CameraError: ${e.description}');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme =
        createTextTheme(context, "Albert Sans", "Albert Sans");
    MaterialTheme theme = MaterialTheme(textTheme);
    return ChangeNotifierProvider(
      create: (_) => NavigationProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        initialRoute: Routes.login,
        onGenerateRoute: Routes.generateRoute,
        home: const HomePage(), 
      ),
    );
  }
}
