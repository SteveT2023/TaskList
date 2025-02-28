import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskListScreen(),
    );
  }
}

class Task {
  String taskName;
  bool taskCompleted;

  Task(this.taskName, {this.taskCompleted = false});
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  void _addTask(String taskName) {
    setState(() {
      _tasks.add(Task(taskName));
    });
  }

  void _taskCompletion(int index) {
    setState(() {
      _tasks[index].taskCompleted = !_tasks[index].taskCompleted;
    });
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _userAddTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter your task.'),
          content: TextField(
            controller: _taskController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _addTask(_taskController.text);
                _taskController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                _taskController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return ListTile (
            title: Text(
              task.taskName
            ),
            leading: Checkbox(
              value: task.taskCompleted,
              onChanged: (value) {_taskCompletion(index);}
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {_removeTask(index);},
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _userAddTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}