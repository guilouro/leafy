import 'package:leafy/models/tasks.dart';

class Challenge {
  final String id;
  final String title;
  final List<Task> tasks;

  Challenge({required this.id, required this.title, required this.tasks});
}
