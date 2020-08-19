import 'package:firebase_database/firebase_database.dart';
 
class Setup {
  String _id;
  String _title;
  String _light;
  String _fan;
  String _water;
  
 
  Setup(this._id, this._title, this._light,this._fan,this._water);
 
  Setup.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._light = obj['light'];
    this._fan = obj['fan'];
    this._water = obj['water'];
  }
 
  String get id => _id;
  String get title => _title;
  String get light => _light;
  String get fan => _fan;
  String get water => _water;
 
  Setup.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _title = snapshot.value['title'];
    _light = snapshot.value['light'];
    _fan   = snapshot.value['fan'];
    _water = snapshot.value['water'];
  }
}