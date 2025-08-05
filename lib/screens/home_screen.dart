import 'package:flutter/material.dart';
import '../models/exercise.dart';
import 'add_exercise_screen.dart';
import 'workout_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Exercise> _exercises = [];

  void _navigateAndAddExercise() async {
    final result = await Navigator.push<Exercise>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddExerciseScreen(),
      ),
    );

    if (result != null) {
      setState(() {
        _exercises.add(result);
      });
    }
  }

  void _startWorkout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutScreen(exercises: _exercises),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Treino HIIT'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (_exercises.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _startWorkout,
                child: const Text('Iniciar treino'),
              ),
            ),
          Expanded(
            child: _exercises.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum exercício adicionado ainda',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
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
                              Text(
                                'Excluir',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        onDismissed: (_) {
                          setState(() {
                            _exercises.removeAt(index);
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Exercício removido')),
                          );
                        },
                        child: ListTile(
                          title: Text(ex.name),
                          subtitle: Text(
                            'Duração: ${ex.durationSeconds}s | Descanso: ${ex.restSeconds}s',
                          ),
                          trailing: const Icon(Icons.delete), // 👈 opcional pra sugerir ação
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateAndAddExercise,
        child: const Icon(Icons.add),
      ),
    );
  }
}
