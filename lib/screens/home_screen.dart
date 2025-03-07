import 'package:flutter/material.dart';

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
                  onPressed: () {},
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
                  Card(child: Text('Item 1')),
                  Card(child: Text('Item 2')),
                  Card(child: Text('Item 3')),
                  Card(child: Text('Item 4')),
                  Card(child: Text('Item 5')),
                  Card(child: Text('Item 6')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
