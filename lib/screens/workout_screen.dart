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
  bool _isPaused = false;
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
      if (_isPaused) return;

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

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _skip() {
    _timer?.cancel();
    if (_isResting) {
      _currentIndex++;
    } else {
      _isResting = true;
    }
    _startNext();
  }

  void _finishEarly() {
    _timer?.cancel();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Finalizar treino?'),
        content: const Text('Tem certeza que deseja encerrar agora?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Encerrar'),
          ),
        ],
      ),
    );
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
              Navigator.pop(context);
              Navigator.pop(context);
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
      return const Scaffold(body: Center(child: Text('Finalizando...')));
    }

    final current = widget.exercises[_currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Executando Treino')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isResting ? 'Descanso' : current.name,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text('$_timeLeft s', style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 36,
                  icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
                  tooltip: _isPaused ? 'Retomar' : 'Pausar',
                  onPressed: _togglePause,
                ),
                const SizedBox(width: 24),
                IconButton(
                  iconSize: 36,
                  icon: const Icon(Icons.skip_next),
                  tooltip: 'Pular',
                  onPressed: _skip,
                ),
                const SizedBox(width: 24),
                IconButton(
                  iconSize: 36,
                  icon: const Icon(Icons.stop),
                  tooltip: 'Finalizar',
                  onPressed: _finishEarly,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
