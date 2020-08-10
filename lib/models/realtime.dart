import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';

class Realtimedta {
  String key;
  String humidity, temperature ,soil,userId ;
  Double water;

  Realtimedta(this.userId,this.humidity, this.temperature ,this.soil,this.water);

  Realtimedta.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    userId = snapshot.value["userId"],
    humidity = snapshot.value["Humidity"],
    temperature = snapshot.value["Temperature"],
    soil = snapshot.value["Soilmoisture"],  
    water = snapshot.value['waterlevel'];

  toJson() {
    return {
      "userId": userId,
      "Humidity": humidity,
      "Temperature": temperature,
      "Soilmoisture": soil,
    };
  }
}