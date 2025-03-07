import 'package:flutter/material.dart';

class GroupForm extends StatefulWidget {
  const GroupForm({super.key});

  @override
  State<GroupForm> createState() => _GroupFormState();
}

class _GroupFormState extends State<GroupForm> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final taskController = TextEditingController();
  List<String> tasks = [];

  @override
  Widget build(BuildContext context) {
    debugPrint('tasks: $tasks');

    void addTask(String task) {
      if (task.isNotEmpty) {
        setState(() {
          tasks.add(task);
        });

        taskController.clear();
      }
    }

    void saveChallenge() {
      if (formKey.currentState!.validate()) {
        debugPrint('title: ${titleController.text}');
        debugPrint('tasks: $tasks');
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Create New Challenge')),
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
                child: const Text('Save Challenge'),
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
