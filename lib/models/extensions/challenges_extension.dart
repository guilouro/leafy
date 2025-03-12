import 'package:leafy/models/challenges.dart';
import 'package:leafy/models/tasks.dart';

extension ChallengesExtension on List<Challenge> {
  /// Finds a challenge and updates the status of a specific task within it
  ///
  /// Takes a [challenge] to find in the list, a [task] within that challenge to update,
  /// and a [newStatus] to set for that task.
  ///
  /// Returns a new Challenge instance with the updated task status if found,
  /// or null if either the challenge or task is not found.
  ///
  /// @param challenge The challenge containing the task to update
  /// @param task The task to update the status for
  /// @param newStatus The new TaskStatus to set
  /// @returns Challenge? A new Challenge instance with updated task or null
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

    return Challenge(
      title: challenge.title,
      tasks: updatedTasks,
      flowerType: challenge.flowerType,
    );
  }
}

extension TaskStatusExtension on Task {
  /// Whether the task status is completed
  bool get isCompleted => status == TaskStatus.completed;

  /// Whether the task status is pending
  bool get isPending => status == TaskStatus.pending;
}
