import 'dart:convert';
import 'package:campus_check_app/routes/routes.dart';
import 'package:campus_check_app/services/storage_service.dart';
import 'package:campus_check_app/view/components/button.dart';
import 'package:campus_check_app/view/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final StorageService _storageService = StorageService();
  bool _rememberMe = false;
  String? _usernameError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    _validateLogin();
    _loadSavedUserName();
    _loadRememberMe();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _validateLogin() {
    _storageService.getToken().then((token) {
      if (token != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.home, (route) => false);
      }
    });
  }

  void _validateUsername() {
    setState(() {
      final username = _usernameController.text;
      if (username.contains(' ')) {
        _usernameError = 'No pueden haber espacios';
      } else {
        _usernameError = null;
      }
    });
  }

  void _validatePassword() {
    setState(() {
      final password = _passwordController.text;
      if (password.contains(' ')) {
        _passwordError = 'No pueden haber espacios';
      } else {
        _passwordError = null;
      }
    });
  }

  void _loadSavedUserName() async {
    final savedUserName = await _storageService.getUserName();
    if (savedUserName != null) {
      _usernameController.text = savedUserName;
    }
  }

  void _loadRememberMe() async {
    final rememberMe = await _storageService.getRememberMe();
    setState(() {
      _rememberMe = rememberMe;
    });
  }

  void _onRememberMeChanged(bool value) {
    setState(() {
      _rememberMe = value;
      _storageService.saveRememberMe(_rememberMe);
      if (_rememberMe) {
        _storageService.saveUserName(_usernameController.text);
      } else {
        _storageService.saveUserName('');
      }
    });
  }

  Future<void> _onLogin() async {
    _validateUsername();
    _validatePassword();
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty) {
      setState(() {
        _usernameError = 'Campo obligatorio';
      });
    }
    if (password.isEmpty) {
      setState(() {
        _passwordError = 'Campo obligatorio';
      });
    }
    if (_usernameError == null && _passwordError == null) {
      final response = await http.post(
        Uri.parse('http://192.168.18.36:5050/api/v1/staff/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        await _storageService.saveToken(token);
        if (mounted) {
          // Navigate to home page
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.home, (route) => false);
        }
      } else {
        if (mounted) {
          // Show error dialog
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('Usuario y/o contraseña incorrectos'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Aceptar'),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: const Color(0xff415f91),
      child: Column(
        children: [
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                            image: AssetImage('assets/images/unmsm.png'),
                            width: 80,
                            fit: BoxFit.contain),
                        SizedBox(width: 10),
                        Text(
                          'Campus Check',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        )
                      ]))),
          Container(
            padding:
                const EdgeInsets.only(top: 35, bottom: 20, left: 30, right: 30),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bienvenido de nuevo',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                const Text(
                  'Inicia sesión para continuar',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 30),
                TextFieldCustom(
                  label: 'Usuario',
                  controller: _usernameController,
                  errorText: _usernameError,
                  onChanged: (p0) => _validateUsername(),
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  label: 'Contraseña',
                  obscure: true,
                  controller: _passwordController,
                  errorText: _passwordError,
                  onChanged: (p0) => _validatePassword(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        value: _rememberMe,
                        checkColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            if (_usernameController.text.isNotEmpty) {
                              _rememberMe = value!;
                              _onRememberMeChanged(_rememberMe);
                            }
                          });
                        }),
                    const Text(
                      'Recuerdame',
                      style: TextStyle(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                      child: const Text(
                        'Iniciar sesión',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () => _onLogin(),
                    )),
                    const SizedBox(width: 10),
                    CustomButton(
                      child: const Icon(
                        Icons.fingerprint,
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, Routes.home),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
