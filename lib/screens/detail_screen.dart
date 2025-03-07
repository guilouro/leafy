import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final int itemId;
  final String title;

  const DetailScreen({super.key, required this.itemId, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Item $itemId'),
            Text('Item $itemId'),
            Text('Item $itemId'),
          ],
        ),
      ),
    );
  }
}
