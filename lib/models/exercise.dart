import 'package:hive/hive.dart';

part 'exercise.g.dart';

@HiveType(typeId: 0)
class Exercise {
  @HiveField(0)
  String name;

  @HiveField(1)
  int durationSeconds;

  @HiveField(2)
  int restSeconds;

  Exercise({
    required this.name,
    required this.durationSeconds,
    required this.restSeconds,
  });
}
