import 'package:flutter/material.dart';
import 'dart:math';

class DisasterResult extends StatefulWidget {
  final int selectedShelter;

  const DisasterResult({super.key, required this.selectedShelter});

  @override
  State<DisasterResult> createState() => _DisasterResultState();
}

class _DisasterResultState extends State<DisasterResult> {
  late String disaster;
  late int destroyedShelter;
  late bool survived;
  bool showResult = false;

  @override
  void initState() {
    super.initState();
    final random = Random();
    disaster = random.nextBool() ? 'earthquake' : 'zombie';
    destroyedShelter = random.nextInt(5) + 1; // 1 ~ 5
    survived = widget.selectedShelter != destroyedShelter;

    // 等待 2 秒模擬災難動畫，再顯示結果
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showResult = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final resultImage = 'assets/images/$disaster.png';

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(resultImage, fit: BoxFit.cover),
          ),
          if (showResult)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
            )
        ],
      ),
    );
  }
}
