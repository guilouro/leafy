import 'package:flutter/material.dart';
import 'package:leafy/ui/seedling.dart';
import 'package:leafy/screens/group_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '🌿 Leafy',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GroupForm(),
                      ),
                    );
                  },
                  child: const Text('Create New Challenge'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children: [
                  Seedling(
                    id: 1,
                    title: 'Item 1',
                    totalTasks: 8,
                    completedTasks: 2,
                  ),
                  Seedling(
                    id: 2,
                    title: 'Item 2',
                    totalTasks: 5,
                    completedTasks: 4,
                  ),
                  Seedling(
                    id: 3,
                    title: 'Item 3',
                    totalTasks: 12,
                    completedTasks: 3,
                  ),
                  Seedling(
                    id: 4,
                    title: 'Item 4',
                    totalTasks: 4,
                    completedTasks: 1,
                  ),
                  Seedling(
                    id: 5,
                    title: 'Item 5',
                    totalTasks: 10,
                    completedTasks: 7,
                  ),
                  Seedling(
                    id: 6,
                    title: 'Item 6',
                    totalTasks: 6,
                    completedTasks: 6,
                  ),
                  Seedling(
                    id: 7,
                    title: 'Item 7',
                    totalTasks: 15,
                    completedTasks: 5,
                  ),
                  Seedling(
                    id: 8,
                    title: 'Item 8',
                    totalTasks: 3,
                    completedTasks: 2,
                  ),
                  Seedling(
                    id: 9,
                    title: 'Item 9',
                    totalTasks: 7,
                    completedTasks: 4,
                  ),
                  Seedling(
                    id: 10,
                    title: 'Item 10',
                    totalTasks: 9,
                    completedTasks: 8,
                  ),
                  Seedling(
                    id: 11,
                    title: 'Item 11',
                    totalTasks: 5,
                    completedTasks: 1,
                  ),
                  Seedling(
                    id: 12,
                    title: 'Item 12',
                    totalTasks: 11,
                    completedTasks: 6,
                  ),
                  Seedling(
                    id: 13,
                    title: 'Item 13',
                    totalTasks: 4,
                    completedTasks: 3,
                  ),
                  Seedling(
                    id: 14,
                    title: 'Item 14',
                    totalTasks: 8,
                    completedTasks: 5,
                  ),
                  Seedling(
                    id: 15,
                    title: 'Item 15',
                    totalTasks: 6,
                    completedTasks: 2,
                  ),
                  Seedling(
                    id: 16,
                    title: 'Item 16',
                    totalTasks: 13,
                    completedTasks: 9,
                  ),
                  Seedling(
                    id: 17,
                    title: 'Item 17',
                    totalTasks: 7,
                    completedTasks: 3,
                  ),
                  Seedling(
                    id: 18,
                    title: 'Item 18',
                    totalTasks: 5,
                    completedTasks: 4,
                  ),
                  Seedling(
                    id: 19,
                    title: 'Item 19',
                    totalTasks: 10,
                    completedTasks: 6,
                  ),
                  Seedling(
                    id: 20,
                    title: 'Item 20',
                    totalTasks: 8,
                    completedTasks: 7,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
