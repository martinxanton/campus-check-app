import 'package:campus_check_app/routes/routes.dart';
import 'package:campus_check_app/view/components/button.dart';
import 'package:campus_check_app/view/components/checkbox.dart';
import 'package:campus_check_app/view/components/textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                      const TextFieldCustom(label: 'Usuario'),
                      const SizedBox(height: 20),
                      const TextFieldCustom(label: 'Contraseña', obscure: true),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CheckBoxCustom(),
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
                              child: CustomButton(
                            child: const Text(
                              'Iniciar sesion',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () =>
                                Navigator.pushNamed(context, Routes.home),
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
