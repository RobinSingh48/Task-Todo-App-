import 'package:shared_preferences/shared_preferences.dart';

class TodoManager {
  final String _todoKey = 'todos';
  final String _statusKey = 'status';

  // Fetch all todos
  Future<List<String>> getTodos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_todoKey) ?? [];
  }

  // Fetch all task completion statuses
  Future<List<bool>> getTaskCompletionStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> statusList = prefs.getStringList(_statusKey) ?? [];
    return statusList.map((status) => status == 'true').toList();
  }

  // Add a new todo
  Future<void> addTodo(String todo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todos = await getTodos();
    List<bool> statuses = await getTaskCompletionStatus();

    todos.add(todo);
    statuses.add(false); // default to incomplete task

    prefs.setStringList(_todoKey, todos);
    prefs.setStringList(
        _statusKey, statuses.map((status) => status.toString()).toList());
  }

  // Update an existing todo
  Future<void> updateTodo(int index, String newTodo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todos = await getTodos();

    if (index >= 0 && index < todos.length) {
      todos[index] = newTodo;
      prefs.setStringList(_todoKey, todos);
    }
  }

  // Update task completion status
  Future<void> updateTaskCompletionStatus(int index, bool status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<bool> statuses = await getTaskCompletionStatus();

    if (index >= 0 && index < statuses.length) {
      statuses[index] = status;
      prefs.setStringList(
          _statusKey, statuses.map((status) => status.toString()).toList());
    }
  }

  // Delete a todo
  Future<void> deleteTodo(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todos = await getTodos();
    List<bool> statuses = await getTaskCompletionStatus();

    if (index >= 0 && index < todos.length) {
      todos.removeAt(index);
      statuses.removeAt(index);

      prefs.setStringList(_todoKey, todos);
      prefs.setStringList(
          _statusKey, statuses.map((status) => status.toString()).toList());
    }
  }
}
