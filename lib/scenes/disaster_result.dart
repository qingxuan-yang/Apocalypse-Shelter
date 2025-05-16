import 'package:flutter/material.dart';
import 'dart:math';

class DisasterResult extends StatelessWidget {
  final int selectedShelter;

  const DisasterResult({super.key, required this.selectedShelter});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final disaster = random.nextBool() ? 'earthquake' : 'zombie';
    final destroyedShelter = random.nextBool() ? 1 : 2;

    final survived = selectedShelter != destroyedShelter;
    final resultImage = 'assets/images/disaster_\$disaster.png';

    return Scaffold(
      appBar: AppBar(title: const Text("結果")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(resultImage, width: 200),
            const SizedBox(height: 20),
            Text(
              survived ? "你倖存了！" : "你死了...",
              style: TextStyle(fontSize: 32, color: survived ? Colors.green : Colors.red),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text("回主選單"),
            )
          ],
        ),
      ),
    );
  }
}
