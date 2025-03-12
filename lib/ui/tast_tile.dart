import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:leafy/models/tasks.dart';
import 'package:leafy/models/extensions/challenges_extension.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          utf8.decode(task.title.codeUnits),
          style: TextStyle(
            fontSize: 16,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            decorationColor: Colors.green,
            color: task.isCompleted ? Colors.grey : Colors.black87,
          ),
        ),
        leading: Icon(
          Icons.eco_rounded,
          color:
              task.isCompleted
                  ? Colors.green
                  : Colors.green.withValues(alpha: .3),
        ),
        trailing: Icon(
          task.isCompleted ? Icons.check_circle : Icons.check_circle_outline,
          size: 28,
          color:
              task.isCompleted
                  ? Colors.green
                  : Colors.green.withValues(alpha: .5),
        ),
      ),
    );
  }
}
