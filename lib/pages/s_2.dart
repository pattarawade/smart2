import 'package:flutter/material.dart';
import 'package:connectfirebase/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:connectfirebase/models/s2.dart';
// import 'package:flutter_login_demo/models/todo.dart';
import 'dart:async';

class S2 extends StatefulWidget {
  S2({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
 
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _TestpageState();  
}

class _TestpageState extends State<S2> {
  List<Item> _todoList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();

  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  Query _todoQuery;

  bool buttonState = true;
  void _buttonChange() {
    setState(() {
      buttonState = !buttonState;
    });
  }

//  final DatabaseReference itemRef = FirebaseDatabase.instance.reference().child("item");

  @override
  void initState() {
    super.initState();
      readData();
    _todoList = new List();
    _todoQuery = _database
        .reference()
        .child("item")
        .orderByChild("userId")
        .equalTo(widget.userId);
    _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(onEntryAdded);
    _onTodoChangedSubscription = _todoQuery.onChildChanged.listen(onEntryChanged);
  }

  @override
  void dispose() {

    _onTodoAddedSubscription.cancel();
    _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event) {
    var oldEntry = _todoList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _todoList[_todoList.indexOf(oldEntry)] =
          Item.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _todoList.add(Item.fromSnapshot(event.snapshot));
    });
  }

  // signOut() async {
  //   try {
  //     await widget.auth.signOut();
  //     widget.logoutCallback();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // addNewTodo(String todoItem) {
  //   if (todoItem.length > 0) {
  //     // Item todo = new Item(todoItem.toString(),todoItem.toString(), widget.userId,false);
  //      Item todo = new Item(widget.userId,todoItem.toString(),todoItem.toString(),false);
  //     _database.reference().child("item2").push().set(todo.toJson());
  //     // createpump();  


  //   }
  // }


  updateTodo(Item todo) {
    //Toggle completed
    todo.completed = !todo.completed;
    if (todo != null) {
      _database.reference().child("item").child(todo.key).set(todo.toJson());
      //  updatepump();
    
    }
  }
  void readData() async {
    //  print('readData Work!!!');
      DatabaseReference databaseReference = 
      _database.reference().child('item'); 
      await databaseReference.once().then((DataSnapshot dataSnapshop) {
      //print('Data ==> ${dataSnapshop.value}');

      //  Map<dynamic, dynamic> values = dataSnapshop.value;
      //  values. forEach((key,values){
      //   // print(values [ 'name']);
      //   String a= values [ 'name'];
      //   print(a);
      //    }); 
      Map<dynamic, dynamic> s = dataSnapshop.value;
       s. forEach((key,s){
        // print(values [ 'name']);
        bool w= s [ 'completed'];
        print(w);
        if(w==true){
            print("1");

           }
         }); 

       });
  }

  updateTodo2(Item todo) {
    //Toggle completed
    // todo.completed = !todo.completed;
    // if (todo != null) {
      // _database.reference().child("item").child(todo.key).set(todo.toJson());
       _database.reference().child("item").child(todo.key).equalTo("fales").once();

      // _database.orderByChild("age").equalTo("4").once();
      //  updatepump();
    // }
  }
  check(Item t){
  bool completed=t.completed;
  print(completed);
  }

  void checkbool(Item todo){
    String key=todo.key;
    String name =todo.name;
    String description=todo.description;
    DateTime dateTime = todo.dateTime ;
    DateTime time = todo.dateTime2 ;
    DateTime dateTime2 = todo.dateTime2 ;
    double price =todo.price;
    bool completed=todo.completed;

    DateTime dateTimenow = new DateTime.now();
      //  DateTime time = new DateTime.now();
    // String userId=todo.userId;
      var newHour = 1;
      time = time.toLocal();
      time = new DateTime(time.year, time.month, time.day, newHour, time.minute, time.second, time.millisecond, time.microsecond);
      print(time);
      print("//////////////////////////////////////////////////////////////////////////////////");
      print(key);
      print(name);
      print(description);
      print(dateTime);
      print(dateTime2);
      print(price);
      print(completed);

      print(dateTimenow);


  }

  deleteTodo(String todoId, int index) {
    _database.reference().child("item").child(todoId).remove().then((_) {
      print("Delete $todoId successful");
      setState(() {
        _todoList.removeAt(index);
      });
    });
  }
  
  // showAddTodoDialog(BuildContext context) async {
  //   _textEditingController.clear();
  //   await showDialog<String>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           content: new Row(
  //             children: <Widget>[

  //               new Expanded(
  //                   child: new TextField(
  //                 controller: _textEditingController,
  //                 autofocus: true,
  //                 decoration: new InputDecoration(
  //                   labelText: 'Add new todo',
  //                 ),
  //               ))
     
  //             ],
  //           ),

  //           actions: <Widget>[
  //             new FlatButton(
  //                 child: const Text('Cancel'),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 }),
                  
  //             new FlatButton(
  //                 child: const Text('Save'),
  //                 onPressed: () {
  //                   // addNewTodo(_textEditingController.text.toString());
  //                   Navigator.pop(context);
  //                 })
  //           ],
  //         );
  //       });
  // }

   

 



  Widget showTodoList() {
      DatabaseReference databaseReference = 
      _database.reference().child('item'); 
      

    if (_todoList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _todoList.length,
          itemBuilder: (BuildContext context, int index) {
            String todoId = _todoList[index].key;

            String name = _todoList[index].name;
            // String description = _todoList[index].description;
            bool completed = _todoList[index].completed;
            // String userId = _todoList[index].userId;

            return Dismissible(

              key: Key(todoId),
      
              background: Container(color: Colors.red),
              onDismissed: (direction) async {
                deleteTodo(todoId, index);
              },

              child: ListTile(
                title: Text(
                  name,
                  style: TextStyle(fontSize: 20.0),
                ),
                trailing: 
                 IconButton(
                    icon: (completed)
                        ? Icon(
                            Icons.brightness_2 ,
                            color: Colors.yellow[300],
                            size: 30.0,
                          )
                        : Icon(Icons.brightness_2, color: Colors.black, size: 30.0),
                    onPressed: () {
                       databaseReference.once().then((DataSnapshot dataSnapshop) {
                          Map<dynamic, dynamic> s = dataSnapshop.value;
                          s. forEach((key,s){
                            // print(values [ 'name']);
                            bool w= s [ 'completed'];
                            print(w);
                            // if(w==true){
                            //     print("1");
                            //   }
                            
                      if (w ==true) {
                                // updateTodo(_todoList[index]);
                                // checkbool(_todoList[index]);
                                // if(completed==true){
                                // updateTodo(_todoList[index]);
                                // checkbool(_todoList[index]);
                                // }
                               
                                print("*******มีค่า trueอยู่ *********");
                               }
                        if(w==false){
                            print("*******มีค่า false อยู่ *********");
                        }

                        
                            }); 
                          
                          });


                      
                        // updateTodo(_todoList[index]);
                        // checkbool(_todoList[index]);
                      
                      // check(_todoList[index]);

                    }),
                    
              ),
            );

          });
    } else {
      return Center(
          child: Text(
        "Welcome. Your list is empty",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30.0),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
     
        // body: showTodoList(),
          body: showTodoList(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //   // update();

        //   },
        //   // tooltip: 'Increment',
        //   // child: Icon(Icons.add),
        // )
        
        );
  }
}
