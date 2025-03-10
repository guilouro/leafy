import 'package:flutter/material.dart';
import 'package:leafy/ui/seedling.dart';
import 'package:leafy/screens/group_form_screen.dart';
import 'package:leafy/repositories/challenges.dart';
import 'package:provider/provider.dart';

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
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<ChallengesRepository>(
                      context,
                      listen: false,
                    ).clearChallenges();
                  },
                  child: const Text('Clear All Challenges'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<ChallengesRepository>(
                builder: (context, challengesRepository, child) {
                  return GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    children:
                        challengesRepository.listChallenges.reversed
                            .map((challenge) => Seedling(challenge: challenge))
                            .toList(),
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
