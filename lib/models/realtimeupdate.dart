import 'package:firebase_database/firebase_database.dart';

// class Realtimedta {
//   String key;

//   String humidity, temperature ,soil,userId ;

//   Realtimedta(this.userId,this.humidity, this.temperature ,this.soil);

//   Realtimedta.fromSnapshot(DataSnapshot snapshot) :
//     key = snapshot.key,
//     userId = snapshot.value["userId"],
//     humidity = snapshot.value["Humidity"],
    // temperature = snapshot.value["Temperature"],
//     soil = snapshot.value["Soilmoisture"];  

//   toJson() {
//     return {
//       "userId": userId,
//       "Humidity": humidity,
//       "Temperature": temperature,
//       "Soilmoisture": soil,
//     };
//   }
// }


class DHT {
  final double temp;
  final double humidity;
  final double heatIndex;

  DHT({this.temp, this.humidity, this.heatIndex});

  factory DHT.fromJson(Map<dynamic, dynamic> json) {
    double parser(dynamic source) {
      try {
        return double.parse(source.toString());
      } on FormatException {
        return -1;
      }
    }

    return DHT(
        temp: parser(json['Temperature']),
        humidity: parser(json['Humidity']),
        heatIndex: parser(json['Soilmoisture']));
  }
}