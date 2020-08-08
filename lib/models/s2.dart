import 'package:firebase_database/firebase_database.dart';


class Item {

  String key;
  String name;
  String description;
  DateTime dateTime;
  DateTime dateTime2;
  double price;
  bool completed;
  String userId;

  // Item();

  // Item.fromCode(userId,name, description, dateTime,dateTime2, price,completed):
  //   this.userId =userId,
  //   this.name = name,
  //   this.description = description,
  //   this.dateTime = dateTime,
  //   this.dateTime2 = dateTime2,
  //   // this.dateTime3 = dateTime3,
  //   this.price = price,
  //   this.completed = completed;

  Item(this.userId,this.name, this.description,this.dateTime,this.dateTime2, this.price,this.completed);

  // Item(this.userId,this.name, this.description,this.completed);
  Item.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    userId = snapshot.value["userId"],
    name = snapshot.value['name'],
    description = snapshot.value['description'],
    dateTime = new DateTime.fromMillisecondsSinceEpoch(snapshot.value['dateTime']),
    dateTime2 = new DateTime.fromMillisecondsSinceEpoch(snapshot.value['dateTime2']),
    price = snapshot.value['price'].toDouble(),
    completed = snapshot.value["completed"];

  toJson() {
    return {
      "userId": userId,
      "name" : name,
      "description" : description,
      "dateTime" : dateTime.toUtc().millisecondsSinceEpoch,
      "dateTime2" : dateTime2.toUtc().millisecondsSinceEpoch,
      "price": price,
      "completed": completed,
    };
  }

}