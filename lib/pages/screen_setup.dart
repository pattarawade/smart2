import 'dart:ffi';

import 'package:connectfirebase/models/setup.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class NoteScreen extends StatefulWidget {
  final Setup note;
  NoteScreen(this.note);

  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}

final notesReference = FirebaseDatabase.instance.reference().child('notes');
final format = DateFormat("HH:mm");

class _NoteScreenState extends State<NoteScreen> {
  TextEditingController _titleController;
  TextEditingController _lightControllerOn;
  TextEditingController _fanControllerOn;
  TextEditingController _waterController1;
  TextEditingController _lightControllerOff;
  TextEditingController _fanControllerOff;
  TextEditingController _waterController2;
  // ignore: unused_field
  bool _completedController = false;

  @override
  void initState() {
    super.initState();
    _titleController = new TextEditingController(text: widget.note.title);
    _lightControllerOn = new TextEditingController(text: widget.note.light0);
    _fanControllerOn = new TextEditingController(text: widget.note.fan0);
    _waterController1 = new TextEditingController(text: widget.note.water0);
    _lightControllerOff = new TextEditingController(text: widget.note.light1);
    _fanControllerOff = new TextEditingController(text: widget.note.fan1);
    _waterController2 = new TextEditingController(text: widget.note.water1);
  }

  Widget eiei() {
    return Text('-');
  }

  Widget ligthTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150.0,
          child: DateTimeField(
            format: format,
            controller: _lightControllerOn,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Turn on the light'),
            onShowPicker: (context, currentValue) async {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.convert(time);
            },
          ),
        ),
        Padding(padding: new EdgeInsets.all(5.0)),
        eiei(),
        Padding(padding: new EdgeInsets.all(5.0)),
        Container(
          width: 150.0,
          child: DateTimeField(
            format: format,
            controller: _lightControllerOff,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Turn off the ligth'),
            onShowPicker: (context, currentValue) async {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.convert(time);
            },
          ),
        ),
      ],
    );
  }

  Widget fanTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150.0,
          child: DateTimeField(
            format: format,
            controller: _fanControllerOn,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Turn on the fan'),
            onShowPicker: (context, currentValue) async {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.convert(time);
            },
          ),
        ),
        Padding(padding: new EdgeInsets.all(5.0)),
        eiei(),
        Padding(padding: new EdgeInsets.all(5.0)),
        Container(
          width: 150.0,
          child: DateTimeField(
            format: format,
            controller: _fanControllerOff,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Turn off the fan'),
            onShowPicker: (context, currentValue) async {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.convert(time);
            },
          ),
        ),
      ],
    );
  }

  Widget waterTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150.0,
          child: DateTimeField(
            format: format,
            controller: _waterController1,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Water 1st'),
            onShowPicker: (context, currentValue) async {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.convert(time);
            },
          ),
        ),
        Padding(padding: new EdgeInsets.all(5.0)),
        eiei(),
        Padding(padding: new EdgeInsets.all(5.0)),
        Container(
          width: 150.0,
          child: DateTimeField(
            format: format,
            controller: _waterController2,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Water 2nd'),
            onShowPicker: (context, currentValue) async {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.convert(time);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setting')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Title'),
            ),
            Padding(padding: new EdgeInsets.all(10.0)),
          

            // TextField(
            //   controller: _lightController,
            //   decoration: InputDecoration(
            //       border: OutlineInputBorder(), labelText: 'light'),
            // ),
            // DropDownField(
            //   controller: _lightController,
            //   onValueChanged: (dynamic value) {
            //     dataTime = value;
            //   },
            //   value: dataTime,
            //   required: false,
            //   hintText: 'Set time',
            //   labelText: 'Time',
            //   items: ,
            // ),
            ligthTime(),
            Padding(padding: new EdgeInsets.all(5.0)),
            Padding(padding: new EdgeInsets.all(5.0)),

            fanTime(),
            Padding(padding: new EdgeInsets.all(5.0)),
            Padding(padding: new EdgeInsets.all(5.0)),

            waterTime(),
            Padding(padding: new EdgeInsets.all(5.0)),
            Padding(padding: new EdgeInsets.all(5.0)),

            OutlineButton(
              borderSide: BorderSide(width: 1.0, style: BorderStyle.solid),
              child: (widget.note.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (widget.note.id != null) {
                  notesReference.child(widget.note.id).set({
                    'title': _titleController.text,
                    'lightOn': _lightControllerOn.text,
                    'fanOn': _fanControllerOn.text,
                    'water1': _waterController1.text,
                    'lightOff': _lightControllerOff.text,
                    'fanOff': _fanControllerOff.text,
                    'water2': _waterController2.text,
                    'completed':_completedController,

                  }).then((_) {
                    Navigator.pop(context);
                  });
                } else {
                  notesReference.push().set({
                    'title': _titleController.text,
                    'lightOn': _lightControllerOn.text,
                    'fanOn': _fanControllerOn.text,
                    'water1': _waterController1.text,
                    'lightOff': _lightControllerOff.text,
                    'fanOff': _fanControllerOff.text,
                    'water2': _waterController2.text,
                    'completed':_completedController,
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
