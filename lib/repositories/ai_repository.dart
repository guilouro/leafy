import 'package:leafy/models/tasks.dart';
import 'package:leafy/services/openai_service.dart';

class AiRepository {
  final OpenAIService openaiService = OpenAIService();

  Future<List<Task>> getSuggestedTasks(String challengeTitle) async {
    final suggestions = await openaiService.getAISuggestions(challengeTitle);
    return suggestions
        .map((e) => Task(title: e, status: TaskStatus.pending))
        .toList();
  }
}
