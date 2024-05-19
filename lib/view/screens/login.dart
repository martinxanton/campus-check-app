import 'package:campus_check_app/routes/routes.dart';
import 'package:campus_check_app/services/storage_service.dart';
import 'package:campus_check_app/view/components/button.dart';
import 'package:campus_check_app/view/components/textfield.dart';
import 'package:flutter/material.dart';

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
    _loadSavedUserName();
    _loadRememberMe();
  }

  @override
  void dispose() {
    super.dispose();
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

  void _onLogin() {
    _validateUsername();
    _validatePassword();
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty) {
      _usernameError = 'Campo obligatorio';
    }
    if (password.isEmpty) {
      _passwordError = 'Campo obligatorio';
    }
    if (_usernameError == null && _passwordError == null) {
      if (username == 'admin' && password == 'admin') {
        Navigator.pushNamed(context, Routes.home);
      } else {
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
                      child: const Text('Aceptar'))
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Theme.of(context).colorScheme.primary,
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
                  padding: const EdgeInsets.only(
                      top: 35, bottom: 20, left: 30, right: 30),
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
                      Text(
                        'Bienvenido de nuevo',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Inicia sesión para continuar',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 18),
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
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                  _onRememberMeChanged(_rememberMe);
                                });
                              }),
                          Text(
                            'Recuerdame',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () => _onLogin(),
                          )),
                          const SizedBox(width: 10),
                          CustomButton(
                            child: const Icon(
                              Icons.fingerprint,
                              color: Colors.white,
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
            )));
  }
}
