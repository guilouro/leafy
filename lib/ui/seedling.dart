import 'package:flutter/material.dart';
import 'package:leafy/models/challenges.dart';
import 'package:leafy/screens/detail_screen.dart';
import 'package:leafy/ui/flower.dart';

class Seedling extends StatelessWidget {
  final Challenge challenge;

  const Seedling({required this.challenge, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => DetailScreen(itemKey: challenge.key.toString()),
          ),
        );
      },
      child: Flower(
        challenge: challenge,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
