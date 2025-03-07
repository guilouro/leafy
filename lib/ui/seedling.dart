import 'package:flutter/material.dart';
import 'package:leafy/screens/detail_screen.dart';

class Seedling extends StatelessWidget {
  final int id;
  final String title;
  final int totalTasks;
  final int completedTasks;

  const Seedling({
    required this.id,
    required this.title,
    required this.totalTasks,
    required this.completedTasks,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final progress = ((completedTasks / totalTasks) * 100);

    String progressLevel(int progress) {
      switch (progress) {
        case <= 20:
          return '🔴';
        case <= 40:
          return '🟡';
        case <= 60:
          return '🟡';
        case <= 80:
          return '🟡';
        case <= 100:
          return '🟢';
        default:
          return '🔴';
      }
    }

    return Card(
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(itemId: id, title: title),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(id.toString()),
            Text('$completedTasks/$totalTasks', style: TextStyle(fontSize: 12)),
            Text(progressLevel(progress.toInt())),
          ],
        ),
      ),
    );
  }
}
