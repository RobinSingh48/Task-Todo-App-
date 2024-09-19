import 'package:flutter/material.dart';
import 'package:todo/content/mytextfield.dart';
import 'package:todo/database/data.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TodoManager user = TodoManager();
  List<String> userTask = [];
  List<bool> taskCompletionStatus = [];
  TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getTask();
  }

  void getTask() async {
    userTask = await user.getTodos();
    taskCompletionStatus = await user.getTaskCompletionStatus();
    setState(() {});
  }

  void openDialog({int? index}) {
    if (index != null) {
      taskController.text = "Update Task";
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey.shade800,
        content: Mytextfield(controller: taskController),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.grey.shade600),
            ),
            onPressed: () async {
              if (taskController.text.isNotEmpty) {
                if (index == null) {
                  await user.addTodo(taskController.text);
                } else {
                  await user.updateTodo(index, taskController.text);
                }
                taskController.clear();

                Navigator.pop(context);
                getTask();
              }
            },
            child: Text(
              "Done",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[350],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void deleteTask(int index) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey.shade800,
        title: Text(
          "Delete Task",
          style: TextStyle(color: Colors.grey.shade200),
        ),
        content: Text(
          "Are you Sure to Delete this?",
          style: TextStyle(color: Colors.grey.shade200),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                    color: Colors.grey.shade300, fontWeight: FontWeight.bold),
              )),
          TextButton(
              onPressed: () async {
                await user.deleteTodo(index);
                getTask();
                Navigator.pop(context);
              },
              child: Text(
                "Delete",
                style: TextStyle(
                    color: Colors.grey.shade300, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }

  void toggleTaskCompletionStatus(int index) async {
    taskCompletionStatus[index] = !taskCompletionStatus[index];
    await user.updateTaskCompletionStatus(index, taskCompletionStatus[index]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        elevation: 0,
        title: Text(
          'T A S K',
          style: TextStyle(
            color: Colors.grey[350],
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade800,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade700,
        onPressed: () {
          openDialog();
        },
        child: Icon(
          Icons.add,
          color: Colors.grey[350],
          size: 35,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: userTask.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: Checkbox(
                        activeColor: Colors.black38,
                        value: taskCompletionStatus[index],
                        onChanged: (value) {
                          toggleTaskCompletionStatus(index);
                        },
                      ),
                      title: Text(
                        userTask[index],
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.w600,
                            decoration: taskCompletionStatus[index]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      trailing: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            child: const Icon(Icons.edit_note),
                            onTap: () => openDialog(index: index),
                          ),
                          GestureDetector(
                            child: const Icon(Icons.delete),
                            onTap: () {
                              deleteTask(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
