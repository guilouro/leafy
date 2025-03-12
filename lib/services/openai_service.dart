import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:leafy/env/env.dart';

class OpenAIService {
  final String apiKey = Env.apiKey;

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
        'Authorization': 'Bearer $apiKey',
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
