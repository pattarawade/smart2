import 'package:flutter/material.dart';
import 'package:connectfirebase/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:connectfirebase/models/swif.dart';
// import 'package:flutter_login_demo/models/todo.dart';
import 'dart:async';

class Testpage5 extends StatefulWidget {
  Testpage5({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _TestpageState();
}

class _TestpageState extends State<Testpage5> {
  List<Switch1> _todoList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  Query _todoQuery;

  final databaseReference = FirebaseDatabase.instance.reference();
  int on=1;
  int off=0;

  //bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();

    //_checkEmailVerification();

    _todoList = new List();
    _todoQuery = _database
        .reference()
        .child("todo1")
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
          Switch1.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _todoList.add(Switch1.fromSnapshot(event.snapshot));
    });
  }

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  addNewTodo(String todoItem) {
    if (todoItem.length > 0) {
      Switch1 todo = new Switch1(todoItem.toString(),todoItem.toString(), widget.userId,false);
      _database.reference().child("todo1").push().set(todo.toJson());
      // createpump();  


    }
  }


  updateTodo(Switch1 todo) {
    //Toggle completed
    todo.completed = !todo.completed;
    if (todo != null) {
      _database.reference().child("todo1").child(todo.key).set(todo.toJson());
      //  updatepump();
    
    }
  }


  deleteTodo(String todoId, int index) {
    _database.reference().child("todo1").child(todoId).remove().then((_) {
      print("Delete $todoId successful");
      setState(() {
        _todoList.removeAt(index);
      });
    });
  }
  
  showAddTodoDialog(BuildContext context) async {
    _textEditingController.clear();
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Row(
              children: <Widget>[

                new Expanded(
                    child: new TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  decoration: new InputDecoration(
                    labelText: 'Add new todo',
                  ),
                ))
     
              ],
            ),

            actions: <Widget>[
              new FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
                  
              new FlatButton(
                  child: const Text('Save'),
                  onPressed: () {
                    addNewTodo(_textEditingController.text.toString());
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }



  Widget showTodoList() {
    if (_todoList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _todoList.length,
          itemBuilder: (BuildContext context, int index) {
            String todoId = _todoList[index].key;
            String subject = _todoList[index].subject;
            // String subject2 = _todoList[index].subject2;
            bool completed = _todoList[index].completed;
            String userId = _todoList[index].userId;
            return Dismissible(
              key: Key(todoId),
              background: Container(color: Colors.red),
              onDismissed: (direction) async {
                deleteTodo(todoId, index);
              },

              child: ListTile(
                title: Text(
                  subject,
                  style: TextStyle(fontSize: 20.0),
                ),
                trailing: IconButton(
                    icon: (completed)
                        ? Icon(
                            Icons.brightness_2 ,
                            color: Colors.yellow[300],
                            size: 30.0,
                          )
                        : Icon(Icons.brightness_2, color: Colors.black, size: 30.0),
                    onPressed: () {
                      updateTodo(_todoList[index]);
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
     
        body: showTodoList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddTodoDialog(context);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }
}
