import 'package:flutter/material.dart';
import 'scenes/main_menu.dart';

void main() {
  runApp(const ShelterGameApp());
}

class ShelterGameApp extends StatelessWidget {
  const ShelterGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shelter Survival',
      debugShowCheckedModeBanner: false,
      home: const MainMenu(),
    );
  }
}
