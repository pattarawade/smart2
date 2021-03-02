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

  
    int off=0;
    int on=1;
    
    bool switchControl = false;
    var textHolder = 'Switch is OFF light';

    bool switchControl2 = false ;
    var textHolder2 = 'Switch is OFF fan';

    bool switchControl3 = false;
    var textHolder3 = 'Switch is OFF pump';

    bool a ;

    final databaseReference = FirebaseDatabase.instance.reference();
//  final DatabaseReference itemRef = FirebaseDatabase.instance.reference().child("item");

  @override
  void initState() {
    super.initState();
      readData();
    _todoList = new List();
    _todoQuery = _database
        .reference()
        .child("readdata")
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
      _database.reference().child('readdata'); 
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
      time = new DateTime(time.year, time.month, time.day, time.hour, time.minute, time.second, time.millisecond, time.microsecond);
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
 void getData(){
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

  void createlight(){
    databaseReference.child("data/control_light_update").set({
      // 'title': 'Mastering EJB',
      'light':off  //off
    });   
  }

  void updatelight(){
    databaseReference.child('data/control_light_update').update({
      'light':on  //on 1
    });

  }
   void create_fan(){

    databaseReference.child("data/control_fan_update").set({
      // 'title': 'Mastering EJB',
      'fan':off  //off
    });   
  }
  void update_fan(){
    databaseReference.child('data/control_fan_update').update({
      'fan':on  //on 1
    });

  }
  void createpump(){
    databaseReference.child("data/control_pump_update").set({
      'pump':off  //off
    });   
  }
  void updatepump(){
    databaseReference.child('data/control_pump_update').update({
      'pump':on  //on 1
    });

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
      _database.reference().child('readdata'); 
      

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
                        ? Icon(Icons.power_settings_new ,color: Colors.green,size: 30.0,)
                        : Icon(Icons.power_settings_new, color: Colors.red, size: 30.0),
                    onPressed: () {
                       databaseReference.child('readdata').once().then((DataSnapshot dataSnapshop) {
                          Map<dynamic, dynamic> s = dataSnapshop.value;
                          s. forEach((key,s){
                            print(s['completed']);
                            // bool w= s [ 'completed'];
                             ///bool w= true;
                            //  if(s [ 'completed']== 'false'){
                            //     w= false;
                            //  }
                            //print(w);
                            
                          if (s == 'false') {
                                 //checkbool(_todoList[index]);
                                 updateTodo(_todoList[index]);
                                print("*******มีค่า trueอยู่ *********");
                               }

                          else{
                                // checkbool(_todoList[index]);
                                updateTodo(_todoList[index]);
                            print("*******มีค่า false อยู่ *********");
                        }         
                            }); 
                          
                          }
                          );                

                    }),
                    
              ),
            );

          });
    } else {
      return Center(
          child: Text(
        "Loading...'",
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
