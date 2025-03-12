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
      child: Column(
        children: [
          Expanded(
            child: Flower(
              challenge: challenge,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .1),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Text(
              challenge.title.length > 6
                  ? '${challenge.title.substring(0, 6)}...'
                  : challenge.title,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
