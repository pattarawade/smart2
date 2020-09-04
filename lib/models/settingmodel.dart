import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';

class Setting {
  String id;
  String title;
  String lightOn;
  String lightOff;
  Double soilmoisture;
  Double temperature;

  Setting(this.id, this.title, this.lightOn, this.lightOff, this.soilmoisture,
      this.temperature);
  Setting.map(dynamic obj) {
    this.id = obj['id'];
    this.title = obj['title'];
    this.lightOn = obj['lightOn'];
    this.lightOff = obj['lightOff'];
    this.soilmoisture = obj['soilmoisture'];
    this.temperature = obj['temperature'];
  }

  String get _id => id;
  String get _title => title;
  String get _lightOn => lightOn;
  String get _lightOff => lightOff;
  Double get _soilmoisture => soilmoisture;
  Double get _temperature => temperature;

  Setting.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.key;
    title = snapshot.value['title'];
    lightOn = snapshot.value['lightOn'];
    lightOff = snapshot.value['lightOff'];
    soilmoisture = snapshot.value['soilmoisture'];
    temperature = snapshot.value['temperature'];

    toJson() {
      return {
        "title": title,
        "lightOn": lightOn,
        "lightOff": lightOff,
        "humidity": soilmoisture,
        "temperature": temperature,
      };
    }
  }
}
