import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final int itemId;
  final String title;

  const DetailScreen({super.key, required this.itemId, required this.title});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tasks = [
      {'title': 'Task 1', 'status': 'pending'},
      {'title': 'Task 2', 'status': 'completed'},
      {'title': 'Task 3', 'status': 'pending'},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Group Title')),
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
                      tasks[index]['title'],
                      style: TextStyle(
                        decoration:
                            tasks[index]['status'] == 'completed'
                                ? TextDecoration.lineThrough
                                : null,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            tasks[index]['status'] == 'completed'
                                ? Icons.check_circle
                                : Icons.check_circle_outline,
                          ),
                          color: Colors.green,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.cancel_outlined),
                          color: Colors.red,
                          onPressed: () {},
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
