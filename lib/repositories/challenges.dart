import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:leafy/models/challenges.dart';
import 'package:leafy/models/tasks.dart';
import 'package:leafy/models/extensions/challenges_extension.dart';

class ChallengesRepository extends ChangeNotifier {
  final List<Challenge> _challenges = [];
  late LazyBox<Challenge> box;

  ChallengesRepository() {
    _startRepository();
  }

  void _startRepository() async {
    await _openBox();
    await _readChallenges();
  }

  Future<void> _openBox() async {
    Hive.registerAdapter(ChallengeAdapter());
    Hive.registerAdapter(TaskAdapter());
    box = await Hive.openLazyBox<Challenge>('challenges');
  }

  Future<void> _readChallenges() async {
    for (var key in box.keys) {
      final challenge = await box.get(key);
      if (challenge != null) {
        _challenges.add(challenge);
      }
    }
    notifyListeners();
  }

  List<Challenge> get listChallenges => _challenges;

  void addChallenge(Challenge challenge) async {
    _challenges.add(challenge);
    await box.add(challenge);
    notifyListeners();
  }

  void removeChallenge(Challenge challenge) async {
    _challenges.remove(challenge);
    await box.delete(challenge.key);
    notifyListeners();
  }

  void updateChallenge(Challenge challenge) async {
    final index = _challenges.indexOf(challenge);
    if (index != -1) {
      _challenges[index] = challenge;
      await box.put(challenge.key, challenge);
      notifyListeners();
    }
  }

  void updateTaskStatus(Challenge challenge, Task task, String status) async {
    final updatedChallenge = _challenges.findAndUpdate(
      challenge: challenge,
      task: task,
      newStatus: status,
    );

    if (updatedChallenge != null) {
      final index = _challenges.indexOf(challenge);
      _challenges[index] = updatedChallenge;
      await box.put(challenge.key, updatedChallenge);
      notifyListeners();
    }
  }

  void clearChallenges() async {
    await box.clear();
    _challenges.clear();
    notifyListeners();
  }
}
