import 'package:hive/hive.dart';
part 'tasks.g.dart';

@HiveType(typeId: 2)
class Task extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final TaskStatus status;

  Task({required this.title, required this.status});
}

@HiveType(typeId: 3)
enum TaskStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  completed,
}
