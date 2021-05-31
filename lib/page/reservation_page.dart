import 'package:flutter/material.dart';
import 'package:navigation_drawer_example/Models/room_model.dart';
import 'package:navigation_drawer_example/Services/room_service.dart';

class ResrvationPage extends StatefulWidget {
  @override
  _ResrvationPageState createState() => _ResrvationPageState();
}

class _ResrvationPageState extends State<ResrvationPage> {
  DateTime _date = DateTime.now();
  StudyRoomService _roomService = StudyRoomService();
  late String purpose;
  late int studentId;
  late int studentCount;
  late int studyroomId;
  String _slot = "Morning";

  List<String> _states = ["Choose a state"];
  List<String> _lgas = ["Choose .."];
String _selectedState = "Choose a state";

  late DateTime fromTime =
      new DateTime(_date.year, _date.month, _date.day, 9, 00, 00);
  late DateTime toTime =
      new DateTime(_date.year, _date.month, _date.day, 12, 30, 00);
  late DateTime dt = new DateTime(_date.year, _date.month, _date.day, 00, 00, 00);

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2021, 6),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future<List<StudyRoom>> getRooms() async {
    try {
      List<StudyRoom> room =
          await _roomService.getAvailableRooms(fromTime, toTime, dt);
      print(fromTime);
      print(toTime);
      print(room);
      return room;
    } catch (e) {
      throw Exception("$e");
    }
  }


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Recervation'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        DropdownButton(
                          value: _slot,
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                          dropdownColor: Colors.white,
                          items: <DropdownMenuItem<String>>[
                            new DropdownMenuItem(
                              child: new Text('Morning'),
                              value: "Morning",
                            ),
                            new DropdownMenuItem(
                              child: new Text('Evening'),
                              value: "Evening",
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _slot = value.toString();
                              if (_slot == "Morning") {
                                fromTime =
                                    new DateTime(_date.year, _date.month, _date.day, 9, 00, 00);
                                toTime =
                                    new DateTime(_date.year, _date.month, _date.day, 12, 30, 00);
                                    // getRooms();
                              } else {
                                fromTime =
                                    new DateTime(_date.year, _date.month, _date.day, 13, 00, 00);
                                toTime =
                                    new DateTime(_date.year, _date.month, _date.day, 16, 30, 00);
                                    // getRooms();
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Column(
                      children: [
                        DropdownButton(
                          value: _slot,
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                          dropdownColor: Colors.white,
                          items: <DropdownMenuItem<String>>[
                            new DropdownMenuItem(
                              child: new Text('1'),
                              value: "Morning",
                            ),
                            new DropdownMenuItem(
                              child: new Text('2'),
                              value: "Evening",
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _slot = value.toString();
                              if (_slot == "Morning") {
                                fromTime =
                                    new DateTime(_date.year, _date.month, _date.day, 9, 00, 00);
                                toTime =
                                    new DateTime(_date.year, _date.month, _date.day, 12, 30, 00);
                                   
                              } else {
                                fromTime =
                                    new DateTime(_date.year, _date.month, _date.day, 13, 00, 00);
                                toTime =
                                    new DateTime(_date.year, _date.month, _date.day, 16, 30, 00);
                                    
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.black87,
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                    primary: Colors.greenAccent,
                                  ),
                                  onPressed: _selectDate,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Pick the date"),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Icon(Icons.arrow_drop_down)
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                TextFormField(
                  initialValue: 'Using for......',
                  maxLength: 50,
                  validator: (value) {
                    if (value == null) {
                      return "Please Neter the value";
                    } else if (value.length < 10) {
                      return "Please enter valid input";
                    }
                  },
                  decoration: InputDecoration(
                    helperText: 'Purpose',
                    suffixIcon: Icon(
                      Icons.error,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      primary: Colors.greenAccent[400],
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {},
                    child: Text("Submit"),
                  ),
                )
              ],
            )),
      ),
    );
  }
  
}
