import 'package:hive/hive.dart';
import 'package:leafy/models/tasks.dart';

part 'challenges.g.dart';

@HiveType(typeId: 0)
class Challenge extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final List<Task> tasks;
  @HiveField(2)
  final FlowerType flowerType;

  Challenge({
    required this.title,
    required this.tasks,
    required this.flowerType,
  });
}

@HiveType(typeId: 1)
enum FlowerType {
  @HiveField(0)
  peony,
  @HiveField(1)
  pansy,
  @HiveField(2)
  iris,
}
