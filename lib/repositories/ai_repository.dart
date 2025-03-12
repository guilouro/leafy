import 'package:leafy/models/tasks.dart';
import 'package:leafy/services/openai_service.dart';

class AiRepository {
  final OpenAIService openaiService = OpenAIService();

  /// Gets AI-suggested tasks for a challenge title
  ///
  /// Takes a [challengeTitle] and requests task suggestions from the OpenAI service.
  /// Returns a list of [Task] objects with pending status.
  ///
  /// @param challengeTitle The title of the challenge to get suggestions for
  /// @returns Future<List<Task>> A list of suggested tasks with pending status
  Future<List<Task>> getSuggestedTasks(String challengeTitle) async {
    final suggestions = await openaiService.getAISuggestions(challengeTitle);
    return suggestions
        .map((e) => Task(title: e, status: TaskStatus.pending))
        .toList();
  }
}
