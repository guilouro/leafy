import 'package:leafy/models/challenges.dart';
import 'package:leafy/models/tasks.dart';

extension ChallengesExtension on List<Challenge> {
  Challenge? findAndUpdate({
    required Challenge challenge,
    required Task task,
    required TaskStatus newStatus,
  }) {
    final challengeIndex = indexOf(challenge);
    if (challengeIndex == -1) return null;

    final taskIndex = challenge.tasks.indexOf(task);
    if (taskIndex == -1) return null;

    final updatedTask = Task(title: task.title, status: newStatus);
    final updatedTasks = List<Task>.from(challenge.tasks)
      ..[taskIndex] = updatedTask;

    return Challenge(title: challenge.title, tasks: updatedTasks);
  }
}

extension TaskStatusExtension on Task {
  bool get isCompleted => status == TaskStatus.completed;
  bool get isPending => status == TaskStatus.pending;
}
