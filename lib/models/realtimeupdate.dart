import 'package:firebase_database/firebase_database.dart';

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