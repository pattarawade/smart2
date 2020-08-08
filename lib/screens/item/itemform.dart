import 'package:flutter/material.dart';

import '../../models/Item.dart';
import '../../component/datetime.dart';
import 'package:intl/intl.dart';

class ItemForm extends StatefulWidget {
  // static String pageTitle = "Item";
  final Item item;

  ItemForm.add(Item item) : item = item;

  ItemForm.edit(Item existingItem) : item = existingItem;

  @override
  State<StatefulWidget> createState() {
    return new ItemFormState(item);
  }
}

class ItemFormState extends State<ItemForm> {
  Item _item;
  
  DateTime _fromDate = new DateTime.now();
  // var  _fromDate = new DateTime.fromMicrosecondsSinceEpoch();
  // DateTime.now().toUtc().millisecondsSinceEpoch;
  TimeOfDay _fromTime = const TimeOfDay(hour: 00, minute: 00);


  DateTime _fromDate2 = new DateTime.now();
  TimeOfDay _fromTime2 = const TimeOfDay(hour: 00, minute: 00);

  
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  ItemFormState(Item item) {
    this._item = item;

    if (item.dateTime != null) {
      _fromDate = item.dateTime;
    }
  //   if (item.dateTime2 != null) {
  //     _fromDate2 = item.dateTime2;
  //   }
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  void _handleSubmitted(BuildContext context) {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      Navigator.of(context).pop(new Item.fromCode(
      _item.name, _item.description, _fromDate,_fromDate2, _item.price,false));
      showInSnackBar('Added new item.');
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        // appBar: new AppBar(
          // title: new Text("Item"),

          // actions: <Widget>[
          //   new IconButton(
          //       icon: const Icon(Icons.send),
          //       onPressed: () {
          //         _handleSubmitted(context);
          //       })
          // ],

        // ),
        body: new SafeArea(
            top: false,
            bottom: false,
            child: new Form(
              key: _formKey,
              child: new ListView(
               
                children: <Widget>[

                  new ListTile(
                    leading: const Icon(Icons.info),
                    title: new TextFormField(
                      initialValue: _item.name != null ? _item.name : '',
                      decoration: new InputDecoration(
                        hintText: "Name",
                      ),
                      onSaved: (val) => _item.name = val,
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.info),
                    title: new TextFormField(
                      initialValue:
                          _item.description != null ? _item.description : '',
                      decoration: new InputDecoration(
                        hintText: "Description",
                      ),
                      onSaved: (val) => _item.description = val,
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: new DateTimePicker(
                      selectedDate: _fromDate,
                      selectedTime: _fromTime,
                      selectDate: (DateTime date) {
                        setState(() {
                          // var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp);
                          _fromDate = date;
                        });
                      },
                      selectTime: (TimeOfDay time) {
                        setState(() {
                          _fromTime = time;
                        });
                      },
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: new DateTimePicker(
                      selectedDate: _fromDate2,
                      selectedTime: _fromTime2,
                    //  _fromDate2 = new DateTime.fromMicrosecondsSinceEpoch(timestamp);
                      selectDate: (DateTime date) {
                        setState(() {
                          // var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp);
                          _fromDate2 = date;
                        });
                      },
                      selectTime: (TimeOfDay time) {
                        setState(() {
                          _fromTime2 = time;
                        });
                      },
                    ),
                  ),

          //  new ListTile(
          //           leading: const Icon(Icons.info),
          //           title: new TextFormField(
          //             initialValue:
          //                 _item.dateTime3 != null ? _item.dateTime3 : '',
          //             decoration: new InputDecoration(
          //               hintText: "dateTime3",
          //             ),
          //             onSaved: (val) => _item.dateTime3 = val,
          //           ),
          //         ),

                  new ListTile(
                    leading: const Icon(Icons.info),
                    title: new TextFormField(
                      initialValue:
                          _item.price != null ? _item.price.toString() : '',
                      decoration: new InputDecoration(
                        hintText: "Price",
                      ),
                      onSaved: (val) => _item.price = double.parse(val),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  
                  new IconButton(
                    icon: const Icon(Icons.check_circle,size: 60.0,color: Colors.green),
                    onPressed: () {
                      _handleSubmitted(context);
                    }),

                    new IconButton(
                    icon: const Icon(Icons.check_circle,size: 60.0,color: Colors.red),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                  // new FlatButton(
                  // child: const Text('Cancel'),
                  // onPressed: () {
                  //   Navigator.pop(context);
                  // }), 
                  
                ],
              ),
            ))
            
            );
  }
}
