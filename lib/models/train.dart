import 'package:hive/hive.dart';
import 'exercise.dart';

part 'train.g.dart';

@HiveType(typeId: 1)
class Train extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<Exercise> exercises;

  Train({required this.name, required this.exercises});
}
