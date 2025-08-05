import 'package:flutter/material.dart';
import 'add_exercise_screen.dart'; // 👈 importa aqui

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Treino HIIT'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Nenhum exercício adicionado ainda',
          style: TextStyle(fontSize: 16),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddExerciseScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
