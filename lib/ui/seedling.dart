import 'package:flutter/material.dart';
import 'package:leafy/screens/detail_screen.dart';

class Seedling extends StatelessWidget {
  final String id;
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
              builder: (context) => DetailScreen(itemId: id, title: title),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              progressLevel(progress.toInt()),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text('$completedTasks/$totalTasks', style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
