import 'package:firebase_database/firebase_database.dart';

class Todo {
  String key;
  String subject;
  String subject2;
  bool completed;
  String userId;

  Todo(this.subject, this.userId, this.completed);

  Todo.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    userId = snapshot.value["userId"],
    subject = snapshot.value["subject"],
    subject2 = snapshot.value["subject2"],
    completed = snapshot.value["completed"];

  toJson() {
    return {
      "userId": userId,
      "subject": subject,
      "subject2": subject2,
      "completed": completed,
    };
  }
}