import 'package:connectfirebase/models/setup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
 
class NoteScreen extends StatefulWidget {
  final Setup note;
  NoteScreen(this.note);
 
  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}
 
final notesReference = FirebaseDatabase.instance.reference().child('notes');
 
class _NoteScreenState extends State<NoteScreen> {
  TextEditingController _titleController;
  TextEditingController _lightController;
  TextEditingController _fanController;
  TextEditingController _waterController;

 
  @override
  void initState() {
    super.initState();
 
    _titleController = new TextEditingController(text: widget.note.title);
    _lightController = new TextEditingController(text: widget.note.light);
    _fanController   = new TextEditingController(text: widget.note.fan);
    _waterController = new TextEditingController(text: widget.note.water);
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[

            TextFormField(
              controller: _titleController,
              decoration: InputDecoration( border: OutlineInputBorder(),labelText: 'Title'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),

            TextField(
              controller: _lightController,
              decoration: InputDecoration(border: OutlineInputBorder(),labelText: 'light'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),

            TextField(
              controller: _fanController,
              decoration: InputDecoration(border: OutlineInputBorder(),labelText: 'fan'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),

            TextField(
              controller: _waterController,
              decoration: InputDecoration(border: OutlineInputBorder(),labelText: 'water'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),

            // DropdownButton(
            // hint: Text('-'), // Not necessary for Option 1
            // value: _selectedLocation,
            // onChanged: (newValue) {
            //   setState(() {
            //     _selectedLocation = newValue;
            //   });
            // },
            // items: _locations.map((location) {
            //   return DropdownMenuItem(
            //     child: new Text(location),
            //     value: location,
            //   );
            // }).toList(), ),

            Padding(padding: new EdgeInsets.all(5.0)),
            
            OutlineButton(
              borderSide: BorderSide( width: 1.0, style: BorderStyle.solid),
              child: (widget.note.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (widget.note.id != null) {
                  notesReference.child(widget.note.id).set({
                    'title': _titleController.text,
                    'light': _lightController.text,
                    'fan'  : _fanController.text,
                    'water': _waterController.text
                  }).then((_) {
                    Navigator.pop(context);
                  });
                } else {
                  notesReference.push().set({
                    'title': _titleController.text,
                    'light': _lightController.text,
                    'fan'  : _fanController.text,
                    'water': _waterController.text,
                  }).then((_) {
                    Navigator.pop(context);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}