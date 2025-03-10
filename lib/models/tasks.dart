import 'package:hive/hive.dart';
part 'tasks.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String status;

  Task({required this.title, required this.status});
}
