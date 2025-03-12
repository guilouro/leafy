import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:leafy/env/env.dart';

/// Service class for interacting with OpenAI's API to generate task suggestions
class OpenAIService {
  final String _apiKey = Env.apiKey;

  /// Generates AI-powered task suggestions for a given challenge title
  ///
  /// Takes a [challengeName] string and returns a list of 5-10 logically ordered
  /// task suggestions related to completing that challenge.
  ///
  /// Makes a request to OpenAI's chat completions API using GPT-4 to generate
  /// the suggestions. The prompt instructs the AI to return tasks in JSON array format.
  ///
  /// @param challengeName The title of the challenge to generate tasks for
  /// @returns Future<List<String>> containing the generated task suggestions
  /// @throws Exception if the API request fails
  Future<List<String>> getAISuggestions(String challengeName) async {
    final prompt =
        """Given a challenge title, create an array containing 5 to 10 actionable tasks related to the title. 
        The tasks must follow the most logical and optimal order possible.
        Provide only the JSON array as response, nothing else.

        Example:
        Title: "Make a fruit smoothie"
        [
          "Choose a fruit",
          "Peel the fruit",
          "Put fruit in the blender",
          "Add milk",
          "Blend ingredients",
          "Pour into a glass"
        ]
        Now, given the title: "{user_input}", provide the JSON array of tasks following the best logical order:
        """;

    final url = Uri.parse('https://api.openai.com/v1/chat/completions');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        "model": "gpt-4o-mini",
        "messages": [
          {
            "role": "system",
            "content": prompt.replaceAll(RegExp(r'\s+'), ' ').trim(),
          },
          {"role": "user", "content": challengeName},
        ],
        "max_tokens": 300,
        "temperature": 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final content = data['choices'][0]['message']['content'];
      final tasks = jsonDecode(content) as List;
      return tasks.cast<String>();
    } else {
      throw Exception('Failed to get AI suggestions');
    }
  }
}
