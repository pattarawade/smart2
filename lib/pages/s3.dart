import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:connectfirebase/models/s2.dart';
// import 'package:flutter_firebase/myData.dart';

class ShowDataPage extends StatefulWidget {
  @override
  _ShowDataPageState createState() => _ShowDataPageState();
}

class _ShowDataPageState extends State<ShowDataPage> {
  List<Item> allData = [];
 String key;
  String name;
  String s;
  String description;
  DateTime dateTime;
  DateTime dateTime2;
  double price;
  bool completed;
  String userId;
  @override
  void initState() {
    
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('item').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      // var data = snap.value;
      allData.clear();
      for (var key in keys) {
        Item d = new Item(
            key = snap.key,
            userId = snap.value["userId"],
            name = snap.value['name'],
            description = snap.value['description'],
            dateTime = new DateTime.fromMillisecondsSinceEpoch(snap.value['dateTime']),
            // dateTime2 = new DateTime.fromMillisecondsSinceEpoch(snap.value['dateTime2']),
            price = snap.value['price'].toDouble(),
            completed = snap.value["completed"],
          // data[key]['name'],
          // data[key]['message'],
          // data[key]['profession'],
        );
         s=d.description;
         print(s);
            print("//////////////////////////////////////////////////////");
        allData.add(d);
      }
      setState(() {
        print('Length : ${allData.length}');
        print(name);
        print(description);
        print(description);
        print(price);
        print(completed);
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Firebase Data'),
      ),
      
      body: new Container(
          child: allData.length == 0
              ? new Text(' No Data is Available')
              : new ListView.builder(
                  itemCount: allData.length,
                  itemBuilder: (_, index) {
                    
                    // return UI(
                    //   allData[index].name,
                    //   allData[index].description,
                    //   allData[index].dateTime,
                    // );
                  },
                )),
    );
  }
  // Widget UI(String userId,String name, String description,String dateTime,String dateTime2, String price,String completed){
  // // Widget UI(String name, String profession, String message) {
  //   return new Card(
  //     elevation: 10.0,
  //     child: new Container(
  //       padding: new EdgeInsets.all(20.0),
  //       child: new Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[


  //           new Text('Name : $name',style: Theme.of(context).textTheme.title,),
  //           new Text('Profession : $profession'),
  //           new Text('Message : $message'),
  //         ],
  //       ),
  //     ),
  //   );
  // }


}
