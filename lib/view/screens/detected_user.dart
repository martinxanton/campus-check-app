import 'package:campus_check_app/view/components/card_button.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class DetectedUserScreen extends StatefulWidget {
  const DetectedUserScreen({super.key});

  @override
  State<DetectedUserScreen> createState() => _DetectedUserScreenState();
}

class _DetectedUserScreenState extends State<DetectedUserScreen> {
  int _selectedIndex = 0;

  List<Widget> tabItems = [
    Row(
      children: [
        CardButton(
            icon: Icons.checklist_outlined, title: 'Entrada', onTap: () {}),
        CardButton(icon: Icons.exit_to_app, title: 'Salida', onTap: () {})
      ],
    ),
    const Center(child: Text("1")),
    const Center(child: Text("2")),
    const Center(child: Text("3")),
    const Center(child: Text("4"))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        body: SafeArea(
          child: Column(
            children: [
              const Image(
                  image: AssetImage('assets/images/bg_study_team.png'),
                  width: double.infinity,
                  height: 150,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      top: 35, bottom: 20, left: 30, right: 30),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: tabItems[_selectedIndex],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: FlashyTabBar(
          selectedIndex: _selectedIndex,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            FlashyTabBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Inicio'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Perfil'),
            ),
          ],
        ));
  }
}
