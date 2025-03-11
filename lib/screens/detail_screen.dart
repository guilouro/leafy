import 'package:flutter/material.dart';
import 'package:leafy/models/extensions/challenges_extension.dart';
import 'package:leafy/models/tasks.dart';
import 'package:leafy/repositories/challenges.dart';
import 'package:leafy/screens/group_form_screen.dart';
import 'package:leafy/ui/flower.dart';
import 'package:leafy/ui/tast_tile.dart';
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(challenge.title),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupForm(challenge: challenge),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit_rounded,
                color: Colors.blueGrey,
                size: 16,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: removeChallenge,
              icon: const Icon(
                Icons.delete_rounded,
                color: Colors.blueGrey,
                size: 16,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Flower(challenge: challenge, width: 250, height: 250),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
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
                    child: TaskTile(task: tasks[index]),
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
