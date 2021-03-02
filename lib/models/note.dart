import 'package:firebase_database/firebase_database.dart';

class WeightEntry {

  String id;
  double Soil;
  double hum;
  double lux;
  double temp;
  double water;

WeightEntry(this.id,this.Soil,this.hum,this.lux,this.temp,this.water);

WeightEntry.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.key,
        Soil = snapshot.value["Soil"].toDouble(),
        hum = snapshot.value["hum"].toDouble(),
        lux = snapshot.value["lux"].toDouble(),
        temp = snapshot.value["temp"].toDouble(),
        water = snapshot.value["water"].toDouble();

  get weight => null;

  toJson() {
    return {
      "Soil": Soil,
      "hum": hum,
      "lux": lux,
      "temp": temp,
      "water": water,
    };
  }
}