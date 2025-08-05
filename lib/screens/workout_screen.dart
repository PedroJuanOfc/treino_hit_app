import 'dart:async';

import 'package:flutter/material.dart';
import '../models/exercise.dart';

class WorkoutScreen extends StatefulWidget {
  final List<Exercise> exercises;

  const WorkoutScreen({super.key, required this.exercises});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  int _currentIndex = 0;
  bool _isResting = false;
  int _timeLeft = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startNext();
  }

  void _startNext() {
    if (_currentIndex >= widget.exercises.length) {
      _showCompletedDialog();
      return;
    }

    final current = widget.exercises[_currentIndex];
    setState(() {
      _timeLeft = _isResting ? current.restSeconds : current.durationSeconds;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft == 0) {
        if (_isResting) {
          _currentIndex++;
        }
        setState(() {
          _isResting = !_isResting;
        });
        _startNext();
      } else {
        setState(() {
          _timeLeft--;
        });
      }
    });
  }

  void _showCompletedDialog() {
    _timer?.cancel();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Treino Concluído!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // fecha o diálogo
              Navigator.pop(context); // volta pra tela inicial
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex >= widget.exercises.length) {
      return const Scaffold(
        body: Center(child: Text('Finalizando...')),
      );
    }

    final current = widget.exercises[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Executando Treino'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isResting ? 'Descanso' : current.name,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              '$_timeLeft s',
              style: const TextStyle(fontSize: 48),
            ),
          ],
        ),
      ),
    );
  }
}
