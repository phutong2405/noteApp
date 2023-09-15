import 'package:flutter/material.dart';
import 'package:someapp/screens/budgetscreen/go_screen.dart';
import 'package:someapp/screens/notescreens/home_screen.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  int _selectedIndex = 1;
  List<BottomNavigationBarItem> botItems = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.sunny), label: 'Notes', backgroundColor: Colors.amber),
    BottomNavigationBarItem(
        icon: Icon(Icons.cloud_circle),
        label: 'Budgets',
        backgroundColor: Colors.cyan)
  ];
  final botScreen = [const HomeScreen(), const GoScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: botItems,
        selectedItemColor: Theme.of(context).colorScheme.background,
      ),
      body: botScreen[_selectedIndex],
    );
  }
}
