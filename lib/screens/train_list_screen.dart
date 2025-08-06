import 'package:flutter/material.dart';
import 'package:treino_hit_app/screens/train_detail_screen.dart';
import '../models/train.dart';

class TrainListScreen extends StatefulWidget {
  const TrainListScreen({super.key});

  @override
  State<TrainListScreen> createState() => _TrainListScreenState();
}

class _TrainListScreenState extends State<TrainListScreen> {
  final List<Train> _trains = [];

  void _addTrain() {
    showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text('Novo Treino'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Nome do treino'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final name = controller.text.trim();
                if (name.isNotEmpty) {
                  setState(() {
                    _trains.add(Train(name: name, exercises: []));
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Treinos'), centerTitle: true),
      body: _trains.isEmpty
          ? const Center(child: Text('Nenhum treino criado ainda'))
          : ListView.builder(
              itemCount: _trains.length,
              itemBuilder: (context, index) {
                final train = _trains[index];
                return ListTile(
                  title: Text(train.name),
                  subtitle: Text('${train.exercises.length} exercício(s)'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrainDetailScreen(train: train),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTrain,
        child: const Icon(Icons.add),
      ),
    );
  }
}
