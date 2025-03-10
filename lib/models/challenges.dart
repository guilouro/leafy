import 'package:hive/hive.dart';
import 'package:leafy/models/tasks.dart';
part 'challenges.g.dart';

@HiveType(typeId: 0)
class Challenge extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final List<Task> tasks;

  Challenge({required this.title, required this.tasks});
}
