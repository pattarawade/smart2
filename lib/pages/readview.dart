import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:connectfirebase/pages/myData.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  List<myData> allData = [];

  @override
  // ignore: must_call_super
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('readdata').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allData.clear();
      for (var key in keys) {
     myData d = new myData(
          data[key]['id'],
          data[key]['Soil'],
          data[key]['hum'],
          data[key]['lux'],
          data[key]['temp'],
          data[key]['water'],
        );
        allData.add(d);
      }
      setState(() {
        print('Length : ${allData.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
          child: allData.length == 0
              ? new Text(' No Data')
              : new ListView.builder(
                  itemCount: allData.length,
                  itemBuilder: (_, index) {
                    return UI(
                      allData[index].id,
                      allData[index].Soil,
                      allData[index].hum,
                      allData[index].lux,
                      allData[index].temp,
                      allData[index].water,
                    );
                  },
                )),
    );
  }

  // ignore: non_constant_identifier_names
  Widget UI(String id ,Double Soil, Double hum, Double lux, Double temp, Double water) {
    return new Card(
      elevation: 10.0,
      child: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('Soil : $id'),
            new Text('Hum : $Soil'),
            new Text('Soil : $hum'),
            new Text('Hum : $lux'),
            new Text('Soil : $temp'),
            new Text('Hum : $water'),
          ],
        ),
      ),
    );
  }
}
