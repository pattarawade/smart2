import 'package:connectfirebase/models/settingmodel.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SettingPage extends StatefulWidget {
  final Setting setting;
  SettingPage(this.setting);

  @override
  _SettingPageState createState() => _SettingPageState();
}

final notesReference =
    FirebaseDatabase.instance.reference().child('notes/setting');
final format = DateFormat("HH:mm");

class _SettingPageState extends State<SettingPage> {
  TextEditingController _titleController;
  TextEditingController _lightControllerOn;
  TextEditingController _lightControllerOff;
  TextEditingController _humidity;
  TextEditingController _temperature;
  @override
  void initState() {
    _titleController = new TextEditingController();
    _lightControllerOn = new TextEditingController();
    _lightControllerOff = new TextEditingController();
    _humidity = new TextEditingController();
    _temperature = new TextEditingController();
    super.initState();
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
                border: OutlineInputBorder(), labelText: 'Turn off the light'),
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
            Padding(padding: new EdgeInsets.all(10.0)),
            TextFormField(
              controller: _humidity,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Humidity'),
            ),
            Padding(padding: new EdgeInsets.all(10.0)),
            TextFormField(
              controller: _temperature,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Temperature'),
            ),
            Padding(padding: new EdgeInsets.all(10.0)),
            OutlineButton(
              borderSide: BorderSide(width: 1.0, style: BorderStyle.solid),
              child: Text('Update'),
              onPressed: () {
                notesReference.child(widget.setting.id).set({
                  'title': _titleController.text,
                  'lightOn': _lightControllerOn.text,
                  'lightOff': _lightControllerOff.text,
                  'humidity': _humidity.text,
                  'temperature': _temperature.text,
                }).then((_) {
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
