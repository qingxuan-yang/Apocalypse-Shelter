import 'package:flutter/material.dart';
import 'shelter_selection.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/background.png', fit: BoxFit.cover, width: double.infinity, height: double.infinity),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ShelterSelection()));
              },
              child: const Text("開始遊戲"),
            ),
          ),
        ],
      ),
    );
  }
}
