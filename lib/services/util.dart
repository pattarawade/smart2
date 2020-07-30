import 'dart:convert';

import '../models/Item.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class Util {

  final DatabaseReference itemRef = FirebaseDatabase.instance.reference();

  addDummyDate() {
    final List<Item> items = <Item>[
      // new Item.fromCode("Item 1", "Description 1", new DateTime.now(), new DateTime.now(),111.toDouble()),
      // new Item.fromCode("Item 2", "Description 2", new DateTime.now(), new DateTime.now(), 222.toDouble()),
      // new Item.fromCode("Item 3", "Description 3", new DateTime.now(), new DateTime.now(), 333.toDouble()),
      // new Item.fromCode("Item 4", "Description 4", new DateTime.now(), 444.toDouble()),
    ];
// DateTime.now().toUtc().millisecondsSinceEpoch;
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:ss:mm');
  final String formatted = formatter.format(now);
    for (var item in items) {
      itemRef.child("item").push().set({
        'name': item.name,
        'description': item.description,
        'dateTime': item.dateTime,
        'dateTime3': formatted,
        //  'dateTime': item.dateTime.toUtc().millisecondsSinceEpoch,
        //  'dateTime2': item.dateTime2.toUtc().millisecondsSinceEpoch,
        // 'dateTime': item.dateTime,
        // 'dateTime2': item.dateTime2,
        'price': item.price,
      });
    }
  }





}