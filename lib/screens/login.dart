import 'package:campus_check_app/routes/routes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: const Color(0xFF831216),
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
                                  fit: BoxFit.contain,
                                  color: Colors.white,
                                  colorBlendMode: BlendMode.srcIn),
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
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
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
                          color: Colors.black87,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const Text(
                        'Inicia sesión para continuar',
                        style: TextStyle(color: Colors.black54, fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        cursorColor: Colors.black38,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13)),
                          labelText: 'Usuario',
                          labelStyle: const TextStyle(color: Colors.black45),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        cursorColor: Colors.black38,
                        obscureText: true,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13)),
                          labelText: 'Contraseña',
                          labelStyle: const TextStyle(color: Colors.black45),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CheckBoxRemenber(),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Recuerdame',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(
                              child: SizedBox(
                            height: 56,
                            child: FilledButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xFF831216)),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.home);
                              },
                              child: const Text(
                                'Iniciar sesion',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          )),
                          const SizedBox(width: 10),
                          SizedBox(
                              height: 56,
                              child: FilledButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xFF831216)),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.home);
                                },
                                child: const Icon(
                                  Icons.fingerprint,
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}

class CheckBoxRemenber extends StatefulWidget {
  const CheckBoxRemenber({
    super.key,
  });

  @override
  State<CheckBoxRemenber> createState() => _CheckBoxRemenberState();
}

class _CheckBoxRemenberState extends State<CheckBoxRemenber> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: isChecked,
        checkColor: Colors.white,
        activeColor: const Color(0xFF831216),
        onChanged: (value) {
          setState(() {
            isChecked = value!;
          });
        });
  }
}
