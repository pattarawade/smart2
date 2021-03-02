import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Circle.dart';

class Dashboards extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboards>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;

  final databaseReference = FirebaseDatabase.instance.reference();

  AnimationController progressController;
  Animation<double> tempAnimation;
  Animation<double> humAnimation;

  @override
  void initState() {
    super.initState();

    databaseReference
        .child('data')
        .once()
        .then((DataSnapshot snapshot) {
       double temp = snapshot.value['Temperature'] + 0.0;
       double hum = snapshot.value['Humidity'] + 0.0;

      isLoading = true;
      _DashboardInit(temp, hum);
    });
  }

  // ignore: non_constant_identifier_names
  _DashboardInit(double temp, double hum) {
    progressController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000)); //5s

    tempAnimation =
        Tween<double>(begin: -50, end: temp).animate(progressController)
          ..addListener(() {
            setState(() {});
          });

    humAnimation =
        Tween<double>(begin: 0, end: hum).animate(progressController)
          ..addListener(() {
            setState(() {});
          });

    progressController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: isLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CustomPaint(
                      
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Temperature'),
                              Text(
                                '${tempAnimation.value.toInt()}',
                                style: TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '°C',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    CustomPaint(
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Humidity'),
                              Text(
                                '${humAnimation.value.toInt()}',
                                style: TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '%',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Text(
                  'Loading...',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
    );
  }


  Future<Null> handleSignOut() async {
    this.setState(() {
      isLoading = true;
    });
    
    this.setState(() {
      isLoading = false;
    });

  }
}
