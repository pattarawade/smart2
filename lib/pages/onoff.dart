import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

class OnOff extends StatelessWidget {

  final databaseReference = FirebaseDatabase.instance.reference();


  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
        appBar: AppBar(
            title: Text('Firebase Connect'),
            ),
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  RaisedButton(
                      child: Text('Create Record0'),
                      onPressed: () {
                        createRecord();
                      },
                  ),

                  RaisedButton(
                      child: Text('View Record'),
                      onPressed: () {
                        getData();
                      },
                  ),

                  RaisedButton(
                      child: Text('Udate Record1'),
                      onPressed: () {
                        updateData();
                      },
                  ),


                  RaisedButton(
                      child: Text('Delete Record'),
                      onPressed: () {
                        // deleteData();
                      },
                  ),
                ],
            )
        ), //center
    );
  }
int a=0;
int u=1;

  void createRecord(){
    databaseReference.child("data/light_update").set({ 
      // 'title': 'Mastering EJB',
      'light':a  //off
    });


    // databaseReference.child("2").set({
    //   'title': 'Flutter in Action',
    //   'description': 'Complete Programming Guide to learn Flutter'
    // });

    
  }

  void getData(){
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }


  void updateData(){
    databaseReference.child('data/light_update').update({
      'light':u  //on 1
    });

  }

  // void deleteData(){
  //   databaseReference.child('1').remove();
  // }
}