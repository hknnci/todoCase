import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_case/controller/todo_list_controller.dart';

class TodoListScreen extends GetView<TodoListController> {
  final TextEditingController titleController = TextEditingController();

  TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.todos.length,
                itemBuilder: (context, index) {
                  final todo = controller.todos[index];
                  return ListTile(
                    title: Text(todo.title),
                    leading: Obx(
                      () => Checkbox(
                        value: todo.isCompleted.value,
                        onChanged: (value) => controller.toggleTodoStatus(todo),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => controller.deleteTodo(todo),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(hintText: 'Yapılacak İş'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final title = titleController.text.trim();
                    if (title.isNotEmpty) {
                      controller.addTodo(title);
                      titleController.clear();
                    } else {
                      Get.snackbar("Uyarı", "Yapılacak iş alanı boş olamaz!", backgroundColor: Colors.amber);
                    }
                  },
                  child: const Text('Ekle'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
