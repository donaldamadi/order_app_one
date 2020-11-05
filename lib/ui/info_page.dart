import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../about.dart';
import 'package:date_time_picker/date_time_picker.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 10);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool showSpinner = false;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  String orderDate = DateTime.now().toString().substring(0, 16);
  String name, location, number, dateOne, dateTwo, fromDate, toDate;
  
  final firestore = FirebaseFirestore.instance;
  final formatThree = DateFormat("dd-MM-yyyy - HH:mm");
  DateTime date;
  TimeOfDay time;
  List<String> listOfSize = ['75cl', '2L', '5L'];
  List<String> listOfQuantity = ['1', '2', '3', '4'];
  String selectedIndexCategory = '75cl', selectedIndexQuantity = '1';

  dynamic buttonPress(BuildContext context) async {
    if (formKey.currentState.validate()) {
      setState(() {
        showSpinner = true;
      });
      await firestore.collection('orders').add({
        'name': name,
        'location': location,
        'number': number,
        'dateOne': fromDate,
        'dateTwo': toDate,
        'size': selectedIndexCategory,
        'quantity': selectedIndexQuantity,
        'ordered at': orderDate,
      }).catchError((e) {
        print(e.toString());
      });

      setState(() {
        showSpinner = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => InfoPage()));
    }
  }

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
                  iconSize: 30,
                  tooltip: "ReadMe",
                  color: Colors.white.withOpacity(controller.value),
                  onPressed: () {
                    aboutBubble(context);
                  }),
            ],
          )
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 17.0, left: 20.0, right: 20.0),
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      icon: Icon(Icons.house),
                      hintText: "Hostel and room Number",
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
                        style: TextStyle(fontSize: 14, color: Colors.blueGrey),
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
                                        fontSize: 14, color: Colors.blueGrey))),
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
                        style: TextStyle(fontSize: 14, color: Colors.blueGrey),
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
                                        fontSize: 14, color: Colors.blueGrey))),
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
                  DateTimePicker(
                    type: DateTimePickerType.dateTime,
                    initialValue: '',
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    dateLabelText: 'Date and time',
                    onChanged: (val) {
                      dateOne = val;
                      fromDate = dateOne.substring(0, 16);
                    },
                  ),
                  SizedBox(height: 14),
                  Text("To", style: TextStyle(fontSize: 16)),
                  DateTimePicker(
                    type: DateTimePickerType.dateTime,
                    initialValue: '',
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    onChanged: (val) {
                      dateTwo = val;
                      toDate = dateTwo.substring(0, 16);
                    },
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    height: 60.0,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      elevation: 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ORDER',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Icon(Icons.check, size: 18),
                        ],
                      ),
                      onPressed: () async {
                        buttonPress(context);
                      },
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
