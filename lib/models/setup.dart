import 'package:firebase_database/firebase_database.dart';
import 'dart:ffi';

class Setup {
  String _id;
  String _title;
  String _lightOn;
  String _lightOff;
  Double _soilmoistureOn;
  Double _soilmoistureOff;
  Double _temperatureOn;
  Double _temperatureOff;
  bool _completed ;

Setup(this._id, this._title, this._lightOn, this._lightOff,this._soilmoistureOn,
      this._soilmoistureOff,this._temperatureOn,this._temperatureOff,this._completed);
  Setup.map(dynamic obj) {
    this._id = obj['id']; 
    this._title = obj['title'];
    this._lightOn = obj['lightOn'];
    this._lightOff = obj['lightOff'];
    this._soilmoistureOn = obj['soilmoistureOn'];
    this._soilmoistureOff = obj['soilmoistureOff'];
    this._temperatureOn = obj['temperatureOn'];
    this._temperatureOff = obj['temperatureOff'];
    this._completed = obj['completed'];
  }

  String get id => _id;
  String get title => _title;
  String get lightOn => _lightOff;
  String get lightOff => _lightOn;
  Double get soilmoistureOn => _soilmoistureOn;
  Double get soilmoistureOff => _soilmoistureOff;
  Double get temperatureOn => _temperatureOn;
  Double get temperatureOff => _temperatureOff;
  bool   get completed => _completed;

  Setup.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _title = snapshot.value['title'];
    _lightOn = snapshot.value['lightOn'];
    _lightOff = snapshot.value['lightOff'];
    _soilmoistureOn = snapshot.value['soilmoistureOn'];
    _soilmoistureOff = snapshot.value['soilmoistureOff'];
    _temperatureOn = snapshot.value['temperatureOn'];
    _temperatureOff = snapshot.value['temperatureOff'];
    _completed = snapshot.value["completed"];

    toJson() {
      return {
        "_id" : snapshot.key,
        "_title": _title,
        "_light0": _lightOn,
        "_light1": _lightOff,
        "_soilmoistureOn": _soilmoistureOn,
        "_soilmoistureOff": _soilmoistureOff,
        "_temperatureOn":_temperatureOn,
        "_temperatureOff":_temperatureOff,
        "_completed": completed,
      };
    }
  }
} 


