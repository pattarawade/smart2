import 'dart:async';
import 'package:connectfirebase/models/setup.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:connectfirebase/pages/screen_setup.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ListViewNote extends StatefulWidget {
  @override
  _ListViewNoteState createState() => new _ListViewNoteState();
}

final notesReference = FirebaseDatabase.instance.reference().child('notes');

class _ListViewNoteState extends State<ListViewNote> {
  List<Setup> items;
  StreamSubscription<Event> _onNoteAddedSubscription;
  StreamSubscription<Event> _onNoteChangedSubscription;

  bool _completedController;

  @override
  void initState() {
    super.initState();

    items = new List();

    _onNoteAddedSubscription = notesReference.onChildAdded.listen(_onNoteAdded);
    _onNoteChangedSubscription =
        notesReference.onChildChanged.listen(_onNoteUpdated);
  }

  @override
  void dispose() {
    _onNoteAddedSubscription.cancel();
    _onNoteChangedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
            itemCount: items.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder: (context, position) {
              return Column(
                children: <Widget>[
                  Divider(height: 5.0),
                  ListTile(
                    title: Text(
                      '${items[position].title}',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      '${items[position].completed}',
                      style: new TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    // leading: Column(
                    //   children: <Widget>[
                    //     IconButton(
                    //         icon: const Icon(Icons.remove_circle_outline),
                    //         onPressed: () => _deleteNote(
                    //             context, items[position], position)),
                    //   ],
                    // ),
                    onTap: () => _navigateToNote(context, items[position]),
                    trailing: FlutterSwitch(
                      showOnOff: true,
                      height: 30.0,
                      width: 60.0,
                      padding: 6.0,
                      toggleSize: 20.0,
                      borderRadius: 15.0,
                      value: items[position].completed,
                      activeColor: Colors.green,
                      activeText: 'ON',
                      inactiveColor: Colors.red,
                      inactiveText: 'OFF',
                      valueFontSize: 10.0,
                      onToggle: (value) {
                        _completedController = value;
                        switch (_completedController) {
                          case true:
                            {
                              update_fanOn(context, items[position], position);
                            }

                            break;
                          default:
                            update_fanoff(context, items[position], position);

                        }
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
        onPressed: () => _createNewNote(context),
      ),
    );
  }

  void _onNoteAdded(Event event) {
    setState(() {
      items.add(new Setup.fromSnapshot(event.snapshot));
    });
  }

  void _onNoteUpdated(Event event) {
    var oldNoteValue =
        items.singleWhere((note) => note.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldNoteValue)] =
          new Setup.fromSnapshot(event.snapshot);
    });
  }

  void _deleteNote(BuildContext context, Setup note, int position) async {
    await notesReference.child(note.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToNote(BuildContext context, Setup note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(note)),
    );
  }

  void update_fanOn(BuildContext context, Setup note, int position) async {
    await notesReference.child(note.id).update({
      'completed': true, //on 1
    });
  }

  void update_fanoff(BuildContext context, Setup note, int position) async {
    await notesReference.child(note.id).update({
      'completed': false, //off
    });
  }

  void _createNewNote(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NoteScreen(Setup(
                null,
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                false,
              ))),
    );
  }
}
