# todo_case

This is a todo application that allows users to manage their tasks and view a list of users. The app uses the Reqres.in API to simulate user authentication and retrieve a list of users.

# Features

**Login**
- Users can log in using the Reqres.in fake API. ( "email": "eve.holt@reqres.in", "password": "cityslicka")
- The app securely stores the login token using flutter_secure_storage to persist the login state.
- If the user has previously logged in, the app will directly navigate to the home screen on subsequent app launches.

**User List**
- The app fetches a list of users from the Reqres.in API using http package and displays them in a list view.
- Users can pull down the list to trigger a refresh the user list.

**Todo List**
- Users can add, update, and delete tasks to the todo list.

# Technologies Used

- Flutter
- GetX
- http
- flutter_secure_storage
- uuid

# Getting Started

- Clone the project => `git clone https://github.com/user/todolist-app.git`
- Navigate to the project folder => `cd todolist-app`
- Install dependencies => `flutter pub get`
- Run the app => `flutter run`

## License

This project is licensed under the MIT License. For more information, see the LICENSE file.
