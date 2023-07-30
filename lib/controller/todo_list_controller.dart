import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:todo_case/utils/model/todo.dart';
import 'package:uuid/uuid.dart';

class TodoListController extends GetxController {
  final todos = <Todo>[].obs;
  final storage = const FlutterSecureStorage();
  final todosKey = 'todos_key';

  @override
  void onInit() {
    super.onInit();
    getTodos();
  }

  Future<void> getTodos() async {
    try {
      final todoList = await storage.read(key: todosKey);
      if (todoList != null && todoList.isNotEmpty) {
        final List<dynamic> decodedList = json.decode(todoList);
        todos.value = decodedList.map((todoJson) => Todo.fromJson(todoJson)).toList();
      }
    } catch (e) {
      print('Exception while getting todos: $e');
    }
  }

  Future<void> saveTodos() async {
    try {
      final todoList = todos.map((todo) => todo.toJson()).toList();
      await storage.write(key: todosKey, value: json.encode(todoList));
    } catch (e) {
      print('Exception while saving todos: $e');
    }
  }

  void addTodo(String title) {
    final todo = Todo(id: const Uuid().v4(), title: title);
    todos.add(todo);
    saveTodos();
  }

  void toggleTodoStatus(Todo todo) {
    todo.isCompleted.value = !todo.isCompleted.value;
    saveTodos();
  }

  void deleteTodo(Todo todo) {
    todos.remove(todo);
    saveTodos();
  }
}
