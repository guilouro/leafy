import 'package:leafy/models/challenges.dart';
import 'package:leafy/models/tasks.dart';

String challengeLevel(Challenge challenge) {
  final totalTasks = challenge.tasks.length;
  final completedTasks =
      challenge.tasks
          .where((task) => task.status == TaskStatus.completed)
          .length;

  final progress = totalTasks > 0 ? (completedTasks / totalTasks) * 100 : 0.0;

  if (progress <= 20) return 'L1';
  if (progress <= 40) return 'L2';
  if (progress <= 60) return 'L3';
  if (progress <= 80) return 'L4';
  if (progress <= 100) return 'L5';

  return 'L1';
}
