import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/exercise.dart';
import 'models/train.dart';
import 'screens/train_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(TrainAdapter());

  await Hive.openBox<Train>('trains');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Treino HIIT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TrainListScreen(),
    );
  }
}
