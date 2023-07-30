import 'package:get/get.dart';
import 'package:todo_case/utils/constants.dart';

class Todo {
  String id;
  String title;
  RxBool isCompleted;

  Todo({
    required this.id,
    required this.title,
    bool isCompleted = false,
  }) : isCompleted = RxBool(isCompleted);

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json[Constants.id],
      title: json[Constants.title],
      isCompleted: json[Constants.isCompleted],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      Constants.id: id,
      Constants.title: title,
      Constants.isCompleted: isCompleted.value,
    };
  }
}
