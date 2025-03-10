import 'package:flutter/material.dart';
import 'package:leafy/models/challenges.dart';
import 'package:leafy/models/tasks.dart';
import 'package:leafy/repositories/challenges.dart';
import 'package:leafy/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

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
            ),
          );
        } else {
          final challengeTasks = tasks.map(
            (task) => Task(title: task, status: TaskStatus.pending),
          );

          challengesRepository.addChallenge(
            Challenge(
              title: titleController.text,
              tasks: challengeTasks.toList(),
            ),
          );
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.challenge != null
                  ? 'Challenge updated successfully'
                  : 'Challenge created successfully',
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.challenge != null ? 'Edit Challenge' : 'Create New Challenge',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Challenge Title',
                  hintText: 'e.g., Cleaning the House',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Challenge title is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Tasks:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(tasks[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            tasks.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: taskController,
                        decoration: const InputDecoration(
                          labelText: 'New Task',
                          hintText: 'Enter task description',
                        ),
                        onSubmitted: (task) {
                          addTask(task);
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        addTask(taskController.text);
                      },
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: Text(
                  widget.challenge != null
                      ? 'Update Challenge'
                      : 'Save Challenge',
                ),
                onPressed: () {
                  saveChallenge();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
