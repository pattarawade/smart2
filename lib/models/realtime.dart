import 'package:firebase_database/firebase_database.dart';

class Realtimedta {
  String key;
  String humidity, temperature ,soil,userId ;

  Realtimedta(this.userId,this.humidity, this.temperature ,this.soil);

  Realtimedta.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    userId = snapshot.value["userId"],
    humidity = snapshot.value["Humidity"],
    temperature = snapshot.value["Temperature"],
    soil = snapshot.value["Soilmoisture"];  

  toJson() {
    return {
       "userId": userId,
      "Humidity": humidity,
      "Temperature": temperature,
      "Soilmoisture": soil,
    };
  }
}