import 'package:firebase_database/firebase_database.dart';

class Setup {
  String _id;
  String _title;
  String _light0;
  String _light1;
  String _fan0;
  String _fan1;
  String _water0;
  String _water1;

  Setup(this._id, this._title, this._light0, this._light1, this._fan0,
      this._fan1, this._water0, this._water1);

  Setup.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._light0 = obj['lightOn'];
    this._light0 = obj['lightOff'];
    this._fan0 = obj['fanOn'];
    this._fan1 = obj['fanOff'];
    this._water0 = obj['water1'];
    this._water1 = obj['water2'];
  }

  String get id => _id;
  String get title => _title;
  String get light0 => _light0;
  String get light1 => _light1;
  String get fan0 => _fan0;
  String get fan1 => _fan1;
  String get water0 => _water0;
  String get water1 => _water1;

  Setup.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _title = snapshot.value['title'];
    _light0 = snapshot.value['lightOn'];
    _light1 = snapshot.value['lightOff'];
    _fan0 = snapshot.value['fanOn'];
    _fan1 = snapshot.value['fanOff'];
    _water0 = snapshot.value['water1'];
    _water1 = snapshot.value['water2'];
  }
}
