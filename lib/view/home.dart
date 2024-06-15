
import 'package:campus_check_app/view/screens/attendance.dart';
import 'package:campus_check_app/view/screens/dashboard.dart';
import 'package:campus_check_app/view/screens/history.dart';
import 'package:campus_check_app/view/screens/settings.dart';
import 'package:flutter/material.dart';


import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:campus_check_app/providers/navigation_provider.dart';
import 'package:provider/provider.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  List<Widget> tabItems = [
    const DashboardScreen(),
    const AttendanceScreen(),
    const HistoryScreen(),
    const SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
        builder: (context, navigationProvider, child) {
      return Scaffold(
          body: tabItems[navigationProvider.selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: navigationProvider.selectedIndex,
            onDestinationSelected: (index) {
              navigationProvider.setIndex(index);
            },
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(Symbols.team_dashboard_rounded, fill: 1),
                icon: Icon(Symbols.team_dashboard_rounded, weight: 500),
                label: 'Inicio',
              ),
              NavigationDestination(
                selectedIcon: Icon(Symbols.checkbook_rounded, fill: 1),
                icon: Icon(Symbols.checkbook_rounded, weight: 500),
                label: 'Asistencia',
              ),
              NavigationDestination(
                selectedIcon: Icon(Symbols.history_rounded, fill: 1),
                icon: Icon(Symbols.history_rounded, weight: 500),
                label: 'Historial',
              ),
              NavigationDestination(
                selectedIcon: Icon(Symbols.settings_rounded, fill: 1),
                icon: Icon(Symbols.settings_rounded, weight: 500),
                label: 'Ajustes',
              ),
            ],
          ));
    });
  }
}
