import 'package:flutter/material.dart';
import 'screens/main_navigation.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(useMaterial3: true, fontFamily: 'Roboto'),
      home: const MainNavigation(),
    );
  }
}
