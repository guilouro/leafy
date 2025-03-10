import 'package:flutter/material.dart';
import 'package:leafy/repositories/challenges.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final String itemId;
  final String title;

  const DetailScreen({super.key, required this.itemId, required this.title});

  @override
  Widget build(BuildContext context) {
    final challengesRepository = Provider.of<ChallengesRepository>(context);

    final challenge = challengesRepository.listChallenges.firstWhere(
      (challenge) => challenge.title == title,
    );
    final tasks = challenge.tasks;

    return Scaffold(
      appBar: AppBar(title: Text(challenge.title)),
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
                    'Item $itemId',
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
                            tasks[index].status == 'completed'
                                ? TextDecoration.lineThrough
                                : null,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            tasks[index].status == 'completed'
                                ? Icons.check_circle
                                : Icons.check_circle_outline,
                          ),
                          color: Colors.green,
                          onPressed: () {
                            final status =
                                tasks[index].status == 'completed'
                                    ? 'pending'
                                    : 'completed';

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
