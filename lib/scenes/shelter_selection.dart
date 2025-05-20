import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'disaster_result.dart';

class ShelterSelection extends StatefulWidget {
  const ShelterSelection({super.key});

  @override
  State<ShelterSelection> createState() => _ShelterSelectionState();
}

class _ShelterSelectionState extends State<ShelterSelection> {
  int _remainingSeconds = 30;
  int? _selectedShelterId;
  Offset? _shadowPosition;
  Timer? _timer;

  final Map<int, Offset> shelterPositionsRatio = {
    1: Offset(0.05, 0.55),
    2: Offset(0.25, 0.55),
    3: Offset(0.45, 0.55),
    4: Offset(0.65, 0.55),
    5: Offset(0.85, 0.55),
  };

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 1) {
        timer.cancel();
        _finalizeShelterSelection();
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  void _selectShelter(int shelterId, Size screenSize) {
    final Offset ratio = shelterPositionsRatio[shelterId]!;
    final Offset pixelPosition = Offset(
      ratio.dx * screenSize.width,
      ratio.dy * screenSize.height,
    );

    setState(() {
      _selectedShelterId = shelterId;
      _shadowPosition = pixelPosition;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('你選擇了第 $shelterId 號避難所'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _finalizeShelterSelection() {
    final shelterToUse = _selectedShelterId ?? (Random().nextInt(5) + 1);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => DisasterResult(selectedShelter: shelterToUse),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _buildShelterButton(String imagePath, int shelterId, Size screenSize) {
    final Offset ratio = shelterPositionsRatio[shelterId]!;
    final Offset position = Offset(
      ratio.dx * screenSize.width,
      ratio.dy * screenSize.height,
    );

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onTap: () => _selectShelter(shelterId, screenSize),
        child: Image.asset(imagePath, width: screenSize.width * 0.15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenSize = constraints.biggest;

          return Stack(
            children: [
              SizedBox.expand(
                child: Image.asset(
                  'assets/images/background.png',
                  fit: BoxFit.fill,
                ),
              ),

              // countdown
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '倒數 $_remainingSeconds 秒',
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),

              // shelter button
              _buildShelterButton('assets/images/military-base.png', 1, screenSize),
              _buildShelterButton('assets/images/bunker.png', 2, screenSize),
              _buildShelterButton('assets/images/lab.png', 3, screenSize),
              _buildShelterButton('assets/images/island.png', 4, screenSize),
              _buildShelterButton('assets/images/building.png', 5, screenSize),

              // user shodaw
              if (_shadowPosition != null)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  left: _shadowPosition!.dx + 10,
                  top: _shadowPosition!.dy + 10,
                  child: Image.asset('assets/images/shadow-person.png', width: screenSize.width * 0.05),
                ),
            ],
          );
        },
      ),
    );
  }
}
