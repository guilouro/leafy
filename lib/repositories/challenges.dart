import 'package:flutter/material.dart';
import 'package:leafy/models/challenges.dart';
import 'package:leafy/models/tasks.dart';
import 'package:leafy/models/extensions/challenges_extension.dart';

class ChallengesRepository extends ChangeNotifier {
  final List<Challenge> _challenges = [];

  List<Challenge> get listChallenges => _challenges;

  void addChallenge(Challenge challenge) {
    _challenges.add(challenge);
    notifyListeners();
  }

  void removeChallenge(Challenge challenge) {
    _challenges.remove(challenge);
    notifyListeners();
  }

  void updateChallenge(Challenge challenge) {
    final index = _challenges.indexOf(challenge);
    if (index != -1) {
      _challenges[index] = challenge;
      notifyListeners();
    }
  }

  void updateTaskStatus(Challenge challenge, Task task, String status) {
    final updatedChallenge = _challenges.findAndUpdate(
      challenge: challenge,
      task: task,
      newStatus: status,
    );

    if (updatedChallenge != null) {
      final index = _challenges.indexOf(challenge);
      _challenges[index] = updatedChallenge;
      notifyListeners();
    }
  }
}
