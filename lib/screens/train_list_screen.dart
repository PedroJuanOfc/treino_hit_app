import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/train.dart';
import 'train_detail_screen.dart';

class TrainListScreen extends StatefulWidget {
  const TrainListScreen({super.key});

  @override
  State<TrainListScreen> createState() => _TrainListScreenState();
}

class _TrainListScreenState extends State<TrainListScreen> {
  late Box<Train> _trainBox;

  @override
  void initState() {
    super.initState();
    _trainBox = Hive.box<Train>('trains');
  }

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
                  final newTrain = Train(name: name, exercises: []);
                  _trainBox.add(newTrain);
                  setState(() {}); // atualiza a UI
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
    final trains = _trainBox.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Treinos'), centerTitle: true),
      body: trains.isEmpty
          ? const Center(child: Text('Nenhum treino criado ainda'))
          : ListView.builder(
              itemCount: trains.length,
              itemBuilder: (context, index) {
                final train = trains[index];
                return ListTile(
                  title: Text(train.name),
                  subtitle: Text('${train.exercises.length} exercício(s)'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TrainDetailScreen(train: train),
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
