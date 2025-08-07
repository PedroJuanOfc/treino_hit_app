import 'package:flutter/material.dart';
import '../models/train.dart';
import '../models/exercise.dart';
import 'add_exercise_screen.dart';
import 'workout_screen.dart';

class TrainDetailScreen extends StatefulWidget {
  final Train train;

  const TrainDetailScreen({super.key, required this.train});

  @override
  State<TrainDetailScreen> createState() => _TrainDetailScreenState();
}

class _TrainDetailScreenState extends State<TrainDetailScreen> {
  late List<Exercise> _exercises;

  @override
  void initState() {
    super.initState();
    _exercises = List.from(widget.train.exercises);
  }

  void _addExercise() async {
    final result = await Navigator.push<Exercise>(
      context,
      MaterialPageRoute(builder: (context) => const AddExerciseScreen()),
    );

    if (result != null) {
      setState(() {
        _exercises.add(result);
        widget.train.exercises.add(result);
        widget.train.save();
      });
    }
  }

  void _removeExercise(int index) {
    setState(() {
      widget.train.exercises.removeAt(index);
      _exercises.removeAt(index);
      widget.train.save();
    });
  }

  void _startWorkout() {
    if (_exercises.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => WorkoutScreen(exercises: _exercises)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.train.name),
        actions: [
          IconButton(
            onPressed: _startWorkout,
            icon: const Icon(Icons.play_arrow),
            tooltip: 'Iniciar treino',
          ),
        ],
      ),
      body: _exercises.isEmpty
          ? const Center(child: Text('Nenhum exercício adicionado ainda'))
          : ListView.builder(
              itemCount: _exercises.length,
              itemBuilder: (context, index) {
                final ex = _exercises[index];
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.delete, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Excluir', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  onDismissed: (_) => _removeExercise(index),
                  child: ListTile(
                    title: Text(ex.name),
                    subtitle: Text(
                      'Duração: ${ex.durationSeconds}s | Descanso: ${ex.restSeconds}s',
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addExercise,
        child: const Icon(Icons.add),
      ),
    );
  }
}
