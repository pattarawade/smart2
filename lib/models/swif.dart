import 'package:firebase_database/firebase_database.dart';

class Switch1 {
  String key;
  String subject;
  String subject2;
  
  bool completed;
  // bool completed2;
  // bool completed3;
  String userId;

  Switch1(this.subject,this.subject2, this.userId, this.completed);

  Switch1.fromSnapshot(DataSnapshot snapshot) :
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