import 'package:flutter/material.dart';
import 'disaster_result.dart';

class ShelterSelection extends StatelessWidget {
  const ShelterSelection({super.key});

  void _selectShelter(BuildContext context, int shelterId) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => DisasterResult(selectedShelter: shelterId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("選擇避難所")),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => _selectShelter(context, 1),
            child: Image.asset('assets/images/military-base.png', width: 150),
          ),
          GestureDetector(
            onTap: () => _selectShelter(context, 2),
            child: Image.asset('assets/images/bunker.png', width: 150),
          ),
          GestureDetector(
            onTap: () => _selectShelter(context, 3),
            child: Image.asset('assets/images/lab.png', width: 150),
          ),
          GestureDetector(
            onTap: () => _selectShelter(context, 4),
            child: Image.asset('assets/images/island.png', width: 150),
          ),
          GestureDetector(
            onTap: () => _selectShelter(context, 5),
            child: Image.asset('assets/images/building.png', width: 150),
          ),
        ],
      ),
    );
  }
}
