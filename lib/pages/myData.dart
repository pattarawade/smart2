import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';

class myData {
  String id;
  Double Soil;
  Double hum;
  Double lux;
  Double temp;
  Double water;

 myData(this.id,this.Soil,this.hum,this.lux,this.temp,this.water);

  // Read.map(dynamic obj) {
  //   this.id = obj['id'];
  //   this.description1 = obj['Soil'];
  //   this.description2 = obj['hum'];
  //   this.description3 = obj['lux'];
  //   this.description4 = obj['temp'];
  //   this.description5 = obj['water'];
  // }

  // Read.fromSnapshot(DataSnapshot snapshot) {
  //   id = snapshot.key;
  //   description1 = snapshot.value['Soil'];
  //   description2 = snapshot.value['hum'];
  //   description3 = snapshot.value['lux'];
  //   description4 = snapshot.value['temp'];
  //   description5 = snapshot.value['water'];
  // }
  // toJson() {
  //   return {
  //     "Soil": description1,
  //     "hum": description2,
  //     "lux": description3,
  //     "temp": description4,
  //     "water": description5,
  //   };
  // }
}