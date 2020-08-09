import 'package:connectfirebase/pages/b.dart';
import 'package:connectfirebase/pages/onoff.dart';
import 'package:flutter/material.dart';
import 'package:connectfirebase/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';


import 'package:connectfirebase/models/todo.dart';
import 'dart:async';

import 'package:connectfirebase/pages/drawer_main.dart';
import 'package:connectfirebase/pages/Dashboard.dart';


import 'package:connectfirebase/pages/SwitchWidget.dart';

import 'package:connectfirebase/pages/switch_t.dart';

import 'package:connectfirebase/pages/camera.dart';
import 'package:connectfirebase/pages/s_2.dart';
import 'package:connectfirebase/pages/s3.dart';
import 'package:connectfirebase/pages/sread.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> _todoList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  Query _todoQuery;

   Widget myWidget = Dashboard();

  // Method
  Widget myDivider() {
    return Divider(
      height: 5.0,
      color: Colors.blue[800],
    );
  }

  //bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();
  
  }
      
  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

Widget logout() {
    return ListTile(
      leading: Icon(
        Icons.account_box,
        size: 36.0,
        color: Colors.orange,
      ),
      title: Text(
        'Logout ',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = signOut();
          Navigator.of(context).pop();
        });
      },
    );
  }
Widget menuDashboard() {
    return ListTile(
      leading: Icon(
        Icons.assessment,
        size: 36.0,
        color: Colors.teal,
      ),
      title: Text('Realtime Value',style: TextStyle(fontSize: 18.0,fontFamily: 'YanoneKaffeesatz-VariableFont_wght',),
      ),
      onTap: () {
        setState(() {
          myWidget = Dashboard();
          Navigator.of(context).pop();
        });
      },
    );
  }

  //  Widget menua1() {
  //   return ListTile(
  //     leading: Icon(
  //       Icons.camera_alt,
  //       size: 36.0,
  //       color: Colors.pink[500],
  //     ),
  //     title: Text(
  //       'value box',
  //       style: TextStyle(fontSize: 18.0),
  //     ),
  //     onTap: () {
  //       setState(() {
  //         myWidget = Dashboard();
  //         Navigator.of(context).pop();
  //       });
  //     },
  //   );
  // }

 Widget menub() {
    return ListTile(
      leading: Icon(
        Icons.camera_alt,
        size: 36.0,
        color: Colors.pink[500],
      ),
      title: Text(
        'add data',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = Testpage();
          Navigator.of(context).pop();
        });
      },
    );
  }
  
  Widget menub1() {
    return ListTile(
      leading: Icon(
        Icons.phonelink_setup,
        size: 36.0,
        color: Colors.teal,
      ),
      title: Text(
        'Control',style: TextStyle(fontSize: 18.0,),
      ),
      onTap: () {
        setState(() {
          myWidget = SwitchWidget();
          Navigator.of(context).pop();
        });
      },
    );
  }
   
 
  
  Widget menuonoff() {
    return ListTile(
      leading: Icon(
        Icons.camera_alt,
        size: 36.0,
        color: Colors.pink[500],
      ),
      title: Text(
        'onoff1',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = OnOff();
          Navigator.of(context).pop();
        });
      },
    );
  }
  
  Widget menutime() {
    return ListTile(
      leading: Icon(
        Icons.settings,
        size: 36.0,
        color: Colors.teal,
      ),
      title: Text('Setting Datetime',style: TextStyle(fontSize: 18.0,),
      ),
      onTap: () {
        setState(() {
          myWidget = Setcontrol();
          Navigator.of(context).pop();
        });
      },
    );
  }
    Widget menucamera() {
    return ListTile(
      leading: Icon(
        Icons.ondemand_video,
        size: 36.0,
        color: Colors.teal,
      ),
      title: Text('Monitor',style: TextStyle(fontSize: 18.0,),
      ),
      onTap: () {
        setState(() {
          myWidget = Camera();
          Navigator.of(context).pop();
        });
      },
    );
  }
  
  Widget a() {
    return ListTile(
      leading: Icon(
        Icons.camera_alt,
        size: 36.0,
        color: Colors.pink[500],
      ),
      title: Text(
        'add data5',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = Testpage5();
          Navigator.of(context).pop();
        });
      },
    );
  }
   Widget s2() {
    return ListTile(
      leading: Icon(
        Icons.camera_alt,
        size: 36.0,
        color: Colors.teal,
      ),
      title: Text(
        's2',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = S2();
          Navigator.of(context).pop();
        });
      },
    );
  }
  
   Widget s3() {
    return ListTile(
      leading: Icon(
        Icons.camera_alt,
        size: 36.0,
        color: Colors.teal,
      ),
      title: Text(
        'desdd',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = Dashboard3();
          Navigator.of(context).pop();
        });
      },
    );
  }
  
  
    Widget headMenu() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.white, Colors.blue[100]],
          radius: 1.5,
          center: Alignment.center,
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 75.0,
            height: 75.0,
            child: Image.asset('images/logo.png'),
          ),
          Text(
            'Smart App',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
            ),
          ),
        //  Text('Login by $nameString')
        ],
      ),
    );
  }



  
  Widget showDrawerMenu() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          headMenu(),
          //menuShowProduct(),
          //myDivider(),
          //menuShowMap(),
          //myDivider(),
          menuDashboard(),
          myDivider(),

          // menua1(),
          // myDivider(),

          //menub(),
          //myDivider(),
          
          menub1(),
          myDivider(),

          menutime(),
          myDivider(),
           
          //menuonoff(),
          //myDivider(),

          menucamera(),
         myDivider(),
          
         // a(),
          //myDivider(),
          
          s2(),
          myDivider(),

           s3(),
          myDivider(),

          //menuQRcode(),
         // myDivider(),
         // logout(),
        ],
      ),
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Center(child: new Text('Smart App',textAlign: TextAlign.center,
              style: new TextStyle(fontSize: 25.0, color: Colors.white,))),
          actions: <Widget>[
           new FlatButton(
               child: Icon(Icons.exit_to_app,color: Colors.white,),
               onPressed: signOut)
          ],
        ),

      body: myWidget,
      drawer: showDrawerMenu(),

        
        );
  }
}





