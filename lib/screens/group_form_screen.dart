import 'package:flutter/material.dart';
import 'package:leafy/models/challenges.dart';
import 'package:leafy/models/tasks.dart';
import 'package:leafy/repositories/challenges.dart';
import 'package:leafy/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'dart:math';

class GroupForm extends StatefulWidget {
  final Challenge? challenge;
  const GroupForm({super.key, this.challenge});

  @override
  State<GroupForm> createState() => _GroupFormState();
}

class _GroupFormState extends State<GroupForm> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final taskController = TextEditingController();
  List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    if (widget.challenge != null) {
      titleController.text = widget.challenge!.title;
      tasks = widget.challenge!.tasks.map((task) => task.title).toList();
    }
  }

  Task preserveTaskStatus(String task) {
    final old = widget.challenge!.tasks.firstWhereOrNull(
      (t) => t.title == task,
    );
    if (old != null) {
      return Task(title: old.title, status: old.status);
    }
    return Task(title: task, status: TaskStatus.pending);
  }

  void addTask(String task) {
    if (task.isNotEmpty) {
      setState(() {
        tasks.add(task);
      });

      taskController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final challengesRepository = Provider.of<ChallengesRepository>(context);

    void saveChallenge() {
      if (formKey.currentState!.validate()) {
        if (widget.challenge != null) {
          challengesRepository.updateChallenge(
            widget.challenge!,
            Challenge(
              title: titleController.text,
              tasks: tasks.map(preserveTaskStatus).toList(),
              flowerType: widget.challenge!.flowerType,
            ),
          );
        } else {
          final challengeTasks = tasks.map(
            (task) => Task(title: task, status: TaskStatus.pending),
          );

          // Randomly assign a flower type to the each new challenge
          final random = Random();
          final flowerLength = FlowerType.values.length;
          final flowerType = FlowerType.values[random.nextInt(flowerLength)];

          challengesRepository.addChallenge(
            Challenge(
              title: titleController.text,
              tasks: challengeTasks.toList(),
              flowerType: flowerType,
            ),
          );
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  widget.challenge != null
                      ? 'Challenge updated successfully! 🎉'
                      : 'Challenge created successfully! 🌟',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      }
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  '🌿 Leafy',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Challenge title',
                        hintText: 'e.g., Cleaning the House 🧹',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(
                          Icons.stars,
                          color: Colors.green,
                        ),
                      ),
                      validator: (value) {
                        return (value == null || value.isEmpty)
                            ? 'Challenge title is required'
                            : null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: const [
                    Icon(Icons.task_alt, color: Colors.greenAccent),
                    SizedBox(width: 8),
                    Text(
                      'Tasks:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child:
                      tasks.isEmpty
                          ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.assignment,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'No tasks yet!\nAdd some tasks below 👇',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )
                          : ListView.builder(
                            padding: const EdgeInsets.only(top: 8),
                            itemCount: tasks.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.eco_rounded,
                                    color: Colors.green,
                                  ),
                                  title: Text(
                                    tasks[index],
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.blueGrey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        tasks.removeAt(index);
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                ),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: taskController,
                            decoration: InputDecoration(
                              labelText: 'New Task',
                              hintText: 'Enter task description',
                              prefixIcon: const Icon(Icons.add_task),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onSubmitted: (task) {
                              addTask(task);
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: Colors.green,
                            size: 32,
                          ),
                          onPressed: () {
                            addTask(taskController.text);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                      shadowColor: Colors.greenAccent,
                    ),
                    onPressed: () {
                      saveChallenge();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          widget.challenge != null
                              ? Icons.local_florist
                              : Icons.eco,
                          size: 28,
                        ),
                        const SizedBox(width: 20),

                        Text(
                          widget.challenge != null
                              ? 'Grow Challenge!'
                              : 'Plant Challenge!',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Icon(
                          widget.challenge != null
                              ? Icons.eco
                              : Icons.local_florist,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
