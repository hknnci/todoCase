import 'package:todo_case/utils/constants.dart';

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json[Constants.id],
      email: json[Constants.email],
      firstName: json[Constants.firstName],
      lastName: json[Constants.lastName],
      avatar: json[Constants.avatar],
    );
  }
}
