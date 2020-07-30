import 'package:firebase_database/firebase_database.dart';

class Item {

  String key;
  String name;
  String description;
  DateTime dateTime;
  DateTime dateTime2;
  DateTime dateTime3;
  double price;

  Item();

  Item.fromCode(name, description, dateTime,dateTime2,dateTime3, price) :
    this.name = name,
    this.description = description,
    this.dateTime = dateTime,
    this.dateTime2 = dateTime2,
    this.dateTime3 = dateTime3,
    this.price = price;
    //  DateTime.toUtc().millisecondsSinceEpoch
  Item.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,

    name = snapshot.value['name'],
    description = snapshot.value['description'],
  //  dateTime =  snapshot.value['dateTime'],
  //   dateTime2 = snapshot.value['dateTime2'],

    dateTime = new DateTime.fromMillisecondsSinceEpoch(snapshot.value['dateTime']),
    dateTime2 = new DateTime.fromMillisecondsSinceEpoch(snapshot.value['dateTime2']),
    dateTime3 = snapshot.value['dateTime3'],
    price = snapshot.value['price'].toDouble();

  toJson() {
    return {
      "name" : name,
      "description" : description,
      "dateTime" : dateTime.toUtc().millisecondsSinceEpoch,
      "dateTime2" : dateTime2.toUtc().millisecondsSinceEpoch,
"dateTime3" :dateTime3,
      // "dateTime" : dateTime,
      // "dateTime2" : dateTime2,
      "price": price,
    };
  }

}