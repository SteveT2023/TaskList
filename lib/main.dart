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
  bool isCompleted;

  Task(this.taskName, {this.isCompleted = false});
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = [];

  void _addTask(String taskName) {
    setState(() {
      _tasks.add(Task(taskName));
    });
  }

  void _taskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
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
              value: task.isCompleted,
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
        onPressed: () {_addTask('New Task');},
        child: const Icon(Icons.add),
      ),
    );
  }
}
