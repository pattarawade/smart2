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
    TextEditingController _lightControllerOff;
    TextEditingController _soilmoistureOn;
    TextEditingController _soilmoistureOff;
    TextEditingController _temperatureOn;
    TextEditingController _temperatureOff;
    bool _completedController = false;

   @override
   void initState() {
     super.initState();
      _titleController = new TextEditingController(text: widget.note.title);
      _lightControllerOn = new TextEditingController(text: widget.note.lightOn);
      _lightControllerOff = new TextEditingController(text: widget.note.lightOff);
      _soilmoistureOn = new TextEditingController();
      _soilmoistureOff = new TextEditingController();
      _temperatureOn = new TextEditingController();
      _temperatureOff = new TextEditingController();
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
             ligthTime(),
             Padding(padding: new EdgeInsets.all(5.0)),
             Padding(padding: new EdgeInsets.all(5.0)),
  
             TextFormField(
              controller: _soilmoistureOn,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Soilmoisturemin'),
            ),
            Padding(padding: new EdgeInsets.all(10.0)),
            TextFormField(
              controller: _soilmoistureOff,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Soilmoisturemax'),
            ),
            Padding(padding: new EdgeInsets.all(10.0)),
             
           TextFormField(
              controller: _temperatureOn,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Temperaturemin'),
            ),
            Padding(padding: new EdgeInsets.all(10.0)),
            TextFormField(
              controller: _temperatureOff,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Temperaturemax'),
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
             

             OutlineButton(
               borderSide: BorderSide(width: 1.0, style: BorderStyle.solid),
               child: (widget.note.id != null) ? Text('Update') : Text('Add'),
               onPressed: () {
                 if (widget.note.id != null) {
                   notesReference.child(widget.note.id).set({
                     'title': _titleController.text,
                     'lightOn': _lightControllerOn.text,
                     'lightOff': _lightControllerOff.text,
                     'soilmoistureOn': _soilmoistureOn,
                     'soilmoistureOff': _soilmoistureOff,
                     'temperatureOn': _temperatureOn, 
                     'temperatureOff': _temperatureOff, 
                     'completed':_completedController,
                    

                   }).then((_) {
                     Navigator.pop(context);
                });
            } 
                 else {
                   notesReference.push().set({
                     'title': _titleController.text,
                     'lightOn': _lightControllerOn.text,
                     'lightOff': _lightControllerOff.text,
                     'soilmoistureOn': _soilmoistureOn,
                     'soilmoistureOff': _soilmoistureOff,
                     'temperatureOn': _temperatureOn, 
                     'temperatureOff': _temperatureOff, 
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
