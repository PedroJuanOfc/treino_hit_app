import 'package:flutter/material.dart';
import '../models/exercise.dart';


class AddExerciseScreen extends StatefulWidget {
  const AddExerciseScreen({super.key});

  @override
  State<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  final _nameController = TextEditingController();
  final _durationController = TextEditingController();
  final _restController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    _restController.dispose();
    super.dispose();
  }

  void _saveExercise() {
  final name = _nameController.text;
  final duration = int.tryParse(_durationController.text) ?? 0;
  final rest = int.tryParse(_restController.text) ?? 0;

  if (name.isEmpty || duration <= 0 || rest < 0) return;

  final newExercise = Exercise(
    name: name,
    durationSeconds: duration,
    restSeconds: rest,
  );

  Navigator.pop(context, newExercise);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Exercício'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome do exercício'),
            ),
            TextField(
              controller: _durationController,
              decoration: const InputDecoration(labelText: 'Duração (segundos)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _restController,
              decoration: const InputDecoration(labelText: 'Descanso (segundos)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveExercise,
              child: const Text('Salvar'),
            )
          ],
        ),
      ),
    );
  }
}
