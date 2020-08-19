import 'dart:async';
import 'package:connectfirebase/models/setup.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:connectfirebase/pages/screen_setup.dart';
 
class ListViewNote extends StatefulWidget {
  @override
  _ListViewNoteState createState() => new _ListViewNoteState();
}
 
final notesReference = FirebaseDatabase.instance.reference().child('notes');
 
class _ListViewNoteState extends State<ListViewNote> {
  List<Setup> items;
  StreamSubscription<Event> _onNoteAddedSubscription;
  StreamSubscription<Event> _onNoteChangedSubscription;
 
  @override
  void initState() {
    super.initState();
 
    items = new List();
 
    _onNoteAddedSubscription = notesReference.onChildAdded.listen(_onNoteAdded);
    _onNoteChangedSubscription = notesReference.onChildChanged.listen(_onNoteUpdated);
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
                      // subtitle: Text(
                      //   '${items[position].light}',
                      //   style: new TextStyle(
                      //     fontSize: 18.0,
                      //   ),
                      // ),
                      leading: Column(
                        children: <Widget>[
                          IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => _deleteNote(context, items[position], position)),
                        ],
                      ),
                      onTap: () => _navigateToNote(context, items[position]),
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
    var oldNoteValue = items.singleWhere((note) => note.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldNoteValue)] = new Setup.fromSnapshot(event.snapshot);
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
 
  void _createNewNote(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(Setup(null, '', '','',''))),
    );
  }
}