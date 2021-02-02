import 'package:firebase_database/firebase_database.dart';
import 'dart:ffi';

class Setup {
  String _id;
  String _title;
   String _light0;
  String _light1;
  Double _soilmoisture;
  Double _temperature;
  bool _completed ;

Setup(this._id, this._title, this._light0, this._light1,this._soilmoisture,
      this._temperature,this._completed);
  Setup.map(dynamic obj) {
    this._id = obj['id']; 
    this._title = obj['title'];
    this._light0 = obj['lightOn'];
    this._light0 = obj['lightOff'];
    this._soilmoisture = obj['soilmoisture'];
    this._temperature = obj['temperature'];
    this._completed = obj['completed'];
  }

  String get id => _id;
  String get title => _title;
  String get light0 => _light0;
  String get light1 => _light1;
  Double get soilmoisture => _soilmoisture;
  Double get temperature => _temperature;
  bool   get completed => _completed;

  Setup.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _title = snapshot.value['title'];
    _light0 = snapshot.value['lightOn'];
    _light1 = snapshot.value['lightOff'];
    _soilmoisture = snapshot.value['soilmoisture'];
    _temperature = snapshot.value['temperature'];
    _completed = snapshot.value["completed"];

    toJson() {
      return {
        "_id" : snapshot.key,
        "_title": _title,
        "_light0": _light0,
        "_light1": _light1,
        "_humidity": _soilmoisture,
        "_temperature":_temperature,
        "_completed": completed,
      };
    }
  }
} 
