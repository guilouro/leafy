import 'package:flutter/material.dart';
import 'package:leafy/models/challenges.dart';
import 'package:leafy/screens/detail_screen.dart';

class Seedling extends StatelessWidget {
  final Challenge challenge;

  const Seedling({required this.challenge, super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate progress safely
    final totalTasks = challenge.tasks.length;
    final completedTasks =
        challenge.tasks.where((task) => task.status == 'completed').length;

    // Avoid division by zero
    final progress = totalTasks > 0 ? (completedTasks / totalTasks) * 100 : 0.0;

    String progressLevel(double progress) {
      if (progress <= 20) return 'L1';
      if (progress <= 40) return 'L2';
      if (progress <= 60) return 'L3';
      if (progress <= 80) return 'L4';
      if (progress <= 100) return 'L5';
      return 'L1';
    }

    return Card(
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => DetailScreen(
                    itemId: challenge.key.toString(),
                    title: challenge.title,
                  ),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              progressLevel(progress),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text('$completedTasks/$totalTasks', style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
