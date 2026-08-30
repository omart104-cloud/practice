import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _taskController = TextEditingController();
  final List<Map<String, dynamic>> _tasks = [];

  void _addTask() {
    if (_taskController.text
        .trim()
        .isEmpty) {
      return;
    }
    setState(() {
      _tasks.add({'title': _taskController.text, 'isDone': false});
      _taskController.clear();
    });
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index]['isDone'] = !_tasks[index]['isDone'];
    });
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Day 2: Interactive Tasks"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Enter task name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                ElevatedButton(onPressed: _addTask,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text('Add'),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Expanded(child: _tasks.isEmpty
                ? Center(child: Text('No Tasks yet. Add one above'))
                : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                          value: task['isDone'],
                          onChanged: (_) => _toggleTask(index),
                      ),
                      title: Text(
                        task['title'],
                        style: TextStyle(
                          decoration: task['isDone']
                              ? TextDecoration.lineThrough
                              :TextDecoration.none
                        ),
                      ),
                    ),
                  );
                }))
          ],
        ),
      ),
    );
  }
}
