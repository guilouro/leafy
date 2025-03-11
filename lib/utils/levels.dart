import 'package:leafy/models/challenges.dart';
import 'package:leafy/models/tasks.dart';

/// Calculates the level of a challenge based on task completion progress
///
/// Takes a [Challenge] object and returns a string representing the level:
/// - 'L1': 0-25% completion
/// - 'L2': 26-50% completion
/// - 'L3': 51-75% completion
/// - 'L4': 76-99% completion
/// - 'L5': 100% completion
///
/// @param challenge The challenge to calculate level for
/// @returns A string representing the level ('L1' through 'L5')
String challengeLevel(Challenge challenge) {
  final totalTasks = challenge.tasks.length;
  final completedTasks =
      challenge.tasks
          .where((task) => task.status == TaskStatus.completed)
          .length;

  final progress = totalTasks > 0 ? (completedTasks / totalTasks) * 100 : 0.0;

  if (progress <= 25) return 'L1';
  if (progress <= 50) return 'L2';
  if (progress <= 75) return 'L3';
  if (progress < 100) return 'L4';
  if (progress == 100) return 'L5';

  return 'L1';
}
