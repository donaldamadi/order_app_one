import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../about.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String orderDate = DateTime.now().toString();
  String name = '';
  String location = '';
  String number = '';
  String dateOne = '';
  String dateTwo = '';
  final firestore = Firestore.instance;
  final formatThree = DateFormat("dd-MM-yyyy - HH:mm");
  DateTime date;
  TimeOfDay time;
  List<String> listOfSize = ['2L', '4L'];
  List<String> listOfQuantity = [
    '1',
    '2',
    '3',
    '4'];
  String selectedIndexCategory = '2L', selectedIndexQuantity = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        automaticallyImplyLeading: false,
        actions: [
          Row(
            children: [
              IconButton(
                  icon: Icon(Icons.info_outline),
                  iconSize: 32,
                  tooltip: "ReadMe",
                  onPressed: () {
                    aboutBubble(context);
                  }),
            ],
          )
        ],
      ),
      body: isLoading
          ? Container(child: Center(child: CircularProgressIndicator()))
          : Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 17.0, left: 20.0, right: 20.0),
                child: ListView(
                  children: [
                    
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: "What do people call you",
                        labelText: "Name*",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.home),
                        hintText: "Hostel and room number",
                        labelText: "Location*",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        location = value;
                      },
                    ),
                    
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        icon: Icon(Icons.phone),
                        hintText: "A number I can call you with",
                        labelText: "Phone Number*",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        number = value;
                      },
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text('Size',
                          style: TextStyle(
                            fontSize: 16,
                          )),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        // DropdownButton which has it's value held in holderOne
                        child: DropdownButton(
                          isExpanded: true,
                          value: selectedIndexCategory,
                          style:
                              TextStyle(fontSize: 14, color: Colors.blueGrey),
                          icon: Icon(Icons.keyboard_arrow_down),
                          underline: Container(color: Colors.transparent),
                          onChanged: (newValueOne) {
                            setState(() {
                              selectedIndexCategory = newValueOne;
                            });
                          },
                          items: listOfSize.map((category) {
                            return DropdownMenuItem(
                              child: Container(
                                  margin: EdgeInsets.only(left: 4, right: 4),
                                  child: Text(category,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blueGrey))),
                              value: category,
                            );
                          }).toList(),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text('Quantity',
                          style: TextStyle(
                            fontSize: 16,
                          )),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        // DropdownButton which has it's value held in holderTwo
                        child: DropdownButton(
                          isExpanded: true,
                          value: selectedIndexQuantity,
                          style:
                              TextStyle(fontSize: 14, color: Colors.blueGrey),
                          icon: Icon(Icons.keyboard_arrow_down),
                          underline: Container(color: Colors.transparent),
                          onChanged: (newValueTwo) {
                            setState(() {
                              selectedIndexQuantity = newValueTwo;
                            });
                          },
                          items: listOfQuantity.map((category) {
                            return DropdownMenuItem(
                              child: Container(
                                  margin: EdgeInsets.only(left: 4, right: 4),
                                  child: Text(category,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blueGrey))),
                              value: category,
                            );
                          }).toList(),
                        )),
                    SizedBox(height: 11),
                    Text("What time will you be available?",
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 11),
                    Text("From", style: TextStyle(fontSize: 16)),
                    SizedBox(height: 2),
                    DateTimeField(
                      decoration: InputDecoration(labelText: "Date and time"),
                      format: formatThree,
                      onShowPicker: (context, currentValue) async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                      onChanged: (value) {
                        dateOne = value.toString();
                      },
                    ),
                    SizedBox(height: 14),
                    Text("To", style: TextStyle(fontSize: 16)),
                    // SizedBox(height: 5),
                    DateTimeField(
                      format: formatThree,
                      onShowPicker: (context, currentValue) async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                      onChanged: (value) {
                        dateTwo = value.toString();
                      },
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      height: 60.0,
                      width: 70,
                      child: RaisedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('ORDER',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Icon(Icons.check, size: 18),
                          ],
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            await firestore.collection('orders').add({
                              'name': name,
                              'location': location,
                              'number': number,
                              'dateOne': dateOne,
                              'dateTwo': dateTwo,
                              'size': selectedIndexCategory,
                              'quantity': selectedIndexQuantity,
                              'ordered at': orderDate,
                            }).catchError((e) {
                              print(e.toString());
                            });
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Row(
                                children: [
                                  Icon(Icons.thumb_up),
                                  SizedBox(width: 20),
                                  Expanded(child: Text('Order Taken!'))
                                ],
                              ),
                            ));
                            Future.delayed(const Duration(seconds: 3), () {
                              setState(() {
                                Navigator.of(context)
                                    .popAndPushNamed('/screen2');
                              });
                            });
                          }
                        },
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
