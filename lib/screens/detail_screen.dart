import 'package:flutter/material.dart';
import 'package:leafy/models/extensions/challenges_extension.dart';
import 'package:leafy/models/tasks.dart';
import 'package:leafy/repositories/challenges.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class DetailScreen extends StatelessWidget {
  final String itemKey;

  const DetailScreen({super.key, required this.itemKey});

  @override
  Widget build(BuildContext context) {
    final challengesRepository = Provider.of<ChallengesRepository>(context);

    final challenge = challengesRepository.listChallenges.firstWhereOrNull(
      (challenge) => challenge.key.toString() == itemKey,
    );

    if (challenge == null) {
      return const Scaffold(body: Center(child: Text('Challenge not found')));
    }

    final tasks = challenge.tasks;

    void removeChallenge() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete Challenge'),
            content: const Text(
              'Are you sure you want to delete this challenge?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  challengesRepository.removeChallenge(challenge);
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Return to previous screen

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Challenge deleted')),
                  );
                },
                child: const Text('Delete'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(challenge.title),
        actions: [
          IconButton(
            onPressed: () {
              removeChallenge();
            },
            icon: const Icon(Icons.delete_rounded),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                  child: Text(
                    challenge.title,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      tasks[index].title,
                      style: TextStyle(
                        decoration:
                            tasks[index].isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            tasks[index].isCompleted
                                ? Icons.check_circle
                                : Icons.check_circle_outline,
                          ),
                          color: Colors.green,
                          onPressed: () {
                            final status =
                                tasks[index].isCompleted
                                    ? TaskStatus.pending
                                    : TaskStatus.completed;

                            challengesRepository.updateTaskStatus(
                              challenge,
                              tasks[index],
                              status,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
