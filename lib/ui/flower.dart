import 'package:flutter/material.dart';
import 'package:leafy/models/challenges.dart';
import 'package:leafy/utils/levels.dart';

class Flower extends StatelessWidget {
  final Challenge challenge;
  final double width;
  final double height;

  const Flower({
    super.key,
    required this.challenge,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/image/${challenge.flowerType.name}/${challengeLevel(challenge)}.png',
          ),
        ),
      ),
    );
  }
}
