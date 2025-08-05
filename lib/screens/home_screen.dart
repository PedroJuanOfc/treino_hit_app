import 'package:flutter/material.dart';

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
          // Futura tela de adicionar exercício
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
