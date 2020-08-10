import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:connectfirebase/models/realtime.dart';

import 'CircleProgress.dart';
// import 'main.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
  
}

class _DashboardState extends State<Dashboard>
  with SingleTickerProviderStateMixin {
  bool isLoading = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final myController = TextEditingController();

  final databaseReference = FirebaseDatabase.instance.reference();
  String heatIndexText;
  Timer _timer;
  bool a;
    
  bool _disposed = false;

  AnimationController progressController;
  Animation<double> tempAnimation;
  Animation<double> humidityAnimation;
  Animation<double> soilAnimation;
  Animation<double> waterAnimation;

  _DashboardInit(double temp,double humid,double soil,double water) {

    progressController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000)); //5s

    tempAnimation = Tween<double>(begin: -50, end: temp).animate(progressController)..addListener(() {  
      setState(() {

        // print(tempAnimation.value);  
        });
      // return tempAnimation.value;
        });

    humidityAnimation =Tween<double>(begin: 0, end: humid).animate(progressController)..addListener(() {  setState(() {});
         });

    soilAnimation =Tween<double>(begin: -50, end: soil).animate(progressController) ..addListener(() {setState(() {});
         });

    waterAnimation =
        Tween<double>(begin: 0, end: water).animate(progressController)
          ..addListener(() {
            setState(() {});
          });

    progressController.forward();
   
  }
   @override
  void initState() {
    // a = true;
   
    
    
     myController.addListener(_printLatestValue);
    // _timer = Timer.periodic(Duration(seconds: 10), (timer) {
    //     setState(() {});
    // });


    //  setState(() {});
    databaseReference
        .reference()
        .child('data')
        .once()
        .then((DataSnapshot snapshot) {
      double temp = snapshot.value['Temperature']+0.0;
      double humidity = snapshot.value['Humidity']+0.0;
      double soil = snapshot.value['Soilmoisture']+0.0;
      double water = snapshot.value['waterlevel']+0.0;
      
      isLoading = true;
      _DashboardInit(temp, humidity, soil, water);
      
    });
    super.initState();
  }

 _printLatestValue() {
    print("Second text field: ${myController.text}");
  }

   @override
  void dispose() {
 _disposed = true;
     myController.dispose ();
    // databaseReference.dispose();
    super.dispose();
    // _timer.cancel();
  }


  
  @override
  Widget build(BuildContext context) {
    return  test();
  }
  
  @override
  Widget test() {
    return Scaffold(
      

      body:

      SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
       
          child: isLoading
              ? Column(   
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
              child: Container(width: 350,height: 20,
              ),
            ),

            Container(
                 child: Container( width: 350,height: 240,
                 child: Card(
                  color: Colors.teal[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),  
                  ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CustomPaint(
                      foregroundPainter:
                          CircleProgress(tempAnimation.value, true),
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Temperature',
                                style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold,),),
                              Text(
                                '${tempAnimation.value.toDouble()}',
                                style: TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                              Text('°C',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                      
                      ],
                    ),
                  ),
                 ), 
              ),
              Container(
                 child: Container( width: 350,height: 240,
                 child: Card(
                  color: Colors.teal[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),  
                  ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                     CustomPaint(
                      foregroundPainter:
                      CircleProgress(humidityAnimation.value, false),
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Humidity',
                                style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold,),),
                              Text(
                                '${humidityAnimation.value.toDouble()}',
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
                   
                    ),
                      
                      ],
                    ),
                  ),
                 ), 
              ), 
              Container(
                 child: Container( width: 350,height: 240,
                 child: Card(
                  color: Colors.teal[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),  
                  ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CustomPaint(
                      foregroundPainter:
                          CircleProgress(soilAnimation.value, true),
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Soilmoisture',
                                style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold,),),
                              Text(
                                '${soilAnimation.value.toInt()}',
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
                      
                      ],
                    ),
                  ),
                 ), 
              ),
              Container(
                 child: Container( width: 350,height: 240,
                 child: Card(
                  color: Colors.teal[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),  
                  ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                     CustomPaint(
                      foregroundPainter:
                          CircleProgress(waterAnimation.value, true),
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Water Level',
                                style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold,),),
                              Text(
                                '${waterAnimation.value.toInt()}',
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
                    ),
                      
                      ],
                    ),
                  ),
                 ), 
              ),

            //         CustomPaint(
            //           foregroundPainter:
            //               CircleProgress(tempAnimation.value, true),
            //           child: Container(
            //             width: 200,
            //             height: 200,
            //             child: Center(
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: <Widget>[
            //                   Text('Temperature',
            //                     style: TextStyle(
            //                       fontSize: 20, fontWeight: FontWeight.bold,),),
            //                   Text(
            //                     '${tempAnimation.value.toInt()}',
            //                     style: TextStyle(
            //                         fontSize: 50, fontWeight: FontWeight.bold),
            //                   ),
            //                   Text('°C',
            //                     style: TextStyle(
            //                         fontSize: 20, fontWeight: FontWeight.bold),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),

            //         CustomPaint(
            //           foregroundPainter:
            //           CircleProgress(humidityAnimation.value, false),
            //           child: Container(
            //             width: 200,
            //             height: 200,
            //             child: Center(
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: <Widget>[
            //                   Text('Humidity',
            //                     style: TextStyle(
            //                       fontSize: 20, fontWeight: FontWeight.bold,),),
            //                   Text(
            //                     '${humidityAnimation.value.toInt()}',
            //                     style: TextStyle(
            //                         fontSize: 50, fontWeight: FontWeight.bold),
            //                   ),
            //                   Text(
            //                     '%',
            //                     style: TextStyle(
            //                         fontSize: 20, fontWeight: FontWeight.bold),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
                   
            //         ),

            //         CustomPaint(
            //           foregroundPainter:
            //               CircleProgress(soilAnimation.value, true),
            //           child: Container(
            //             width: 200,
            //             height: 200,
            //             child: Center(
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: <Widget>[
            //                   Text('Soilmoisture',
            //                     style: TextStyle(
            //                       fontSize: 20, fontWeight: FontWeight.bold,),),
            //                   Text(
            //                     '${soilAnimation.value.toInt()}',
            //                     style: TextStyle(
            //                         fontSize: 50, fontWeight: FontWeight.bold),
            //                   ),
            //                   Text(
            //                     '°C',
            //                     style: TextStyle(
            //                         fontSize: 20, fontWeight: FontWeight.bold),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),


            //  CustomPaint(
            //           foregroundPainter:
            //               CircleProgress(waterAnimation.value, true),
            //           child: Container(
            //             width: 200,
            //             height: 200,
            //             child: Center(
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: <Widget>[
            //                   Text('Water Level',
            //                     style: TextStyle(
            //                       fontSize: 20, fontWeight: FontWeight.bold,),),
            //                   Text(
            //                     '${waterAnimation.value.toInt()}',
            //                     style: TextStyle(
            //                         fontSize: 50, fontWeight: FontWeight.bold),
            //                   ),
            //                   Text(
            //                     '%',
            //                     style: TextStyle(
            //                         fontSize: 20, fontWeight: FontWeight.bold),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),

                Center(),
                  ],
                )
              : Text(
                  'Loading...',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
        )),
       
    );
  }

   
  handleLoginOutPopup() {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Login Out",
      desc: "Do you want to login out now?",
      buttons: [
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.teal,
        ),
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: handleSignOut,
          color: Colors.teal,
        )
      ],
    ).show();

  }






  Future<Null> handleSignOut() async {
    this.setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();

    this.setState(() {
      isLoading = false;
    });

    // Navigator.of(context).pushAndRemoveUntil(
        // MaterialPageRoute(builder: (context) => MyApp()),
        // (Route<dynamic> route) => false);
  }
}