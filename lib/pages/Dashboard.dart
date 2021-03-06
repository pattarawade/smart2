import 'dart:async';
import 'dart:ffi';
import 'package:connectfirebase/models/settingmodel.dart';

import 'package:connectfirebase/pages/screen_setup.dart';
import 'package:connectfirebase/pages/setting_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
  final titleSet = TextEditingController();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

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
  Animation<double> luxAnimation;

  List<Setting> items;
  StreamSubscription<Event> _onNoteChangedSubscription;

  int off = 0;
  int on = 1;

  _DashboardInit(
      double temp, double humid, double soil, double water, double lux) {
    progressController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000)); //5s

    tempAnimation =
        Tween<double>(begin: -20, end: temp).animate(progressController)
          ..addListener(() {
            setState(() {
              // print(tempAnimation.value);
            });
            // return tempAnimation.value;
          });

    humidityAnimation =
        Tween<double>(begin: 0, end: humid).animate(progressController)
          ..addListener(() {
            setState(() {});
          });

    soilAnimation =
        Tween<double>(begin: 0, end: soil).animate(progressController)
          ..addListener(() {
            setState(() {});
          });

    waterAnimation =
        Tween<double>(begin: 0, end: water).animate(progressController)
          ..addListener(() {
            setState(() {});
          });
    luxAnimation = Tween<double>(begin: 0, end: lux).animate(progressController)
      ..addListener(() {
        setState(() {});
      });

    progressController.forward();
  }

  @override
  void initState() {
    items = new List();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) {
      print("onDidReceiveLocalNotification called.");
    });
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
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
      double temp = snapshot.value['Temperature'] + 0.0;
      double humidity = snapshot.value['Humidity'] + 0.0;
      double soil = snapshot.value['Soilmoisture'] + 0.0;
      double water = snapshot.value['waterlevel'] + 0.0;
      double lux = snapshot.value['lux'] + 0.0;

      if (water <= 40.0) {
        scheduleNotification();
      }

      isLoading = true;
      _DashboardInit(temp, humidity, soil, water, lux);
    });
    titleSet.addListener(_printLatestValue);

    super.initState();
  }

  _printLatestValue() {
    print("Second text field: ${myController.text}");
  }

  void create_fanpum() {
    databaseReference.child("data/control_fanpum_update").set({
      'fan_pum': off //off
    });
  }

  void update_fanpum() {
    databaseReference.child('data/control_fanpum_update').update({
      'fan_pum': on //on 1
    });
  }

  Future<void> scheduleNotification() async {
    var scheduleNotificationDateTime = DateTime.now();
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 1',
      'CHANNEL_NAME 1',
      "CHANNEL_DESCRIPTION 1",
      icon: 'app_icon',
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
      enableLights: true,
      color: const Color.fromARGB(255, 255, 0, 0),
      ledColor: const Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500,
      importance: Importance.Max,
      priority: Priority.High,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails(
      sound: 'my_sound.aiff',
    );
    var platformChannelSpecifics = NotificationDetails(
      androidChannelSpecifics,
      iosChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.schedule(
      0,
      '<b>Water Level<b>',
      'Low Water',
      scheduleNotificationDateTime,
      platformChannelSpecifics,
    );
  }

  @override
  void dispose() {
    _disposed = true;
    myController.dispose();
    // databaseReference.dispose();
    super.dispose();
    // _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return test();
  }

  @override
  Widget test() {
    return Scaffold(
      body: SingleChildScrollView(
          child: ConstrainedBox(
        constraints: BoxConstraints(),
        child: isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Container(
                      width: 350,
                      height: 15,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Container(
                          width: 180,
                          height: 230,
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
                                      CircleProgress(tempAnimation.value, true),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Temperature',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${tempAnimation.value.toDouble().toStringAsFixed(1)}',
                                            style: TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '°C',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
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
                        child: Container(
                          width: 180,
                          height: 230,
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
                                  foregroundPainter: CircleProgress(
                                      humidityAnimation.value, false),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Humidity',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${humidityAnimation.value.toDouble().toStringAsFixed(1)}',
                                            style: TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '%',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Container(
                          width: 180,
                          height: 230,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Soilmoisture',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${soilAnimation.value.toDouble().toStringAsFixed(1)}',
                                            style: TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '°C',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
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
                        child: Container(
                          width: 180,
                          height: 230,
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
                                  foregroundPainter: CircleProgress(
                                      humidityAnimation.value, false),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Light value',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${luxAnimation.value.toInt()}',
                                            style: TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'lux',
                                            style: TextStyle(
                                                fontSize:18,
                                                fontWeight: FontWeight.bold),
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
                    ],
                  ),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                    //   Container(
                    // child: Container(
                    //   width: 15,
                    //   height: 230,
                    // ),
                 // ),
                 Container(
                        child: Container(
                          width: 360,
                          height: 230,
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
                                  foregroundPainter: CircleProgress(
                                      waterAnimation.value, false),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Water Level',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${waterAnimation.value.toInt()}',
                                            style: TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '%',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
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
                      
                    ],
                  ),
                  Center(),
                ],
              )
            : Text(
                'Loading...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                ),
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
