import 'package:flutter/material.dart';
import 'package:navigation_drawer_example/Models/reservation_model.dart';
import 'package:navigation_drawer_example/Services/reservation_service.dart';
import 'package:navigation_drawer_example/Services/room_service.dart';
import 'package:navigation_drawer_example/main_screen.dart';
import 'package:navigation_drawer_example/widget/custom_alert.dart';
import 'package:navigation_drawer_example/widget/custom_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:intl/intl.dart';

class ResrvationPage extends StatefulWidget {
  @override
  _ResrvationPageState createState() => _ResrvationPageState();
}

class _ResrvationPageState extends State<ResrvationPage> {
  StudyRoomService _roomService = StudyRoomService();
  ReservationService _reservationService = ReservationService();
  DateTime _date = DateTime.now();
  late String _purpose = "";
  late int _studentId = 0;
  late int _studentCount = 0;
  late int _studyroomId = 0;
  String _slot = "0";
  late String dat="";
  int slt = 0;

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2021, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {});
    }
  }

  @override
  void initState() {
    dat = DateFormat('y-M-d').format(_date);
    super.initState();
  }

  Future<Reservation> readyIssueToUpload() async {
    Reservation thisReservation;
    
    print(dat);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("uid")!;
    _studentId = int.parse(userId);
    thisReservation = Reservation(
        slt, _studentCount, dat, _studentId, _studyroomId, _purpose);
    print(_studentId);
    print(_studyroomId);
    return thisReservation;
  }

  Future _addNewReservation() async {
    try {
      CustomLoading.showLoadingDialog(
        context: context,
        message: "Placing your Reservation...",
      );
      Reservation myReservation = await readyIssueToUpload();
      print(myReservation);
      _reservationService.addReservtion(myReservation).then((response) {
        print("athule");
        print(response);
        if (response.statusCode == 201) {
          CustomLoading.closeLoading(context: context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => MainScreen(),
            ),
            (route) => false,
          );
        } else {
          CustomLoading.closeLoading(context: context);
          CustomAlert.alertDialogBuilder(
            context: context,
            title: "Error",
            message: "error code: ${response.statusCode}",
            action: "Ok",
          );
        }
      });
    } catch (e) {
      CustomLoading.closeLoading(context: context);
      CustomAlert.alertDialogBuilder(
        context: context,
        title: "Error",
        message: "error code: $e",
        action: "Ok",
      );
    }
  }

  // Future<List<StudyRoom>> getRooms() async {
  //   try {
  //     List<StudyRoom> room =
  //         await _roomService.getAvailableRooms(_fromTime, _toTime, _dt);
  //     print(_fromTime);
  //     print(_toTime);
  //     print(room);
  //     return room;
  //   } catch (e) {
  //     throw Exception("$e");
  //   }
  // }

  Future<bool> Exist(int id) async {
    try {
      bool res = await _roomService.getRoomById(id);
      return res;
    } catch (e) {
      throw Exception("$e");
    }
  }

  void _addReservation() {
    if (dat != null &&
        slt != null &&
        _studentCount != null &&
        _studentId != null &&
        _studyroomId != null) {
      _addNewReservation();
    } else {
      CustomAlert.alertDialogBuilder(
        context: context,
        title: "Error",
        message: "Some inputs are empty please try again",
        action: "ok",
      );
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
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            DropdownButton(
                              value: _slot,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                              dropdownColor: Colors.white,
                              items: <DropdownMenuItem<String>>[
                                new DropdownMenuItem(
                                  child: new Text('Morning'),
                                  value: "0",
                                ),
                                new DropdownMenuItem(
                                  child: new Text('Evening'),
                                  value: "1",
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _slot = value.toString();
                                  slt = int.parse(_slot);
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
                        decoration: const InputDecoration(
                          icon: Icon(Icons.room),
                          labelText: 'Study Room Number *',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) async {
                          if (value != null) {
                            int _id = int.parse(value);
                            bool res = await Exist(_id);
                            if (!res) {
                              CustomAlert.alertDialogBuilder(
                                context: context,
                                title: "Error",
                                message: "Invalid Study Room Number",
                                action: "ok",
                              );
                            } else {
                              print(dat);
                              bool available = await _roomService
                                  .checkAvailable(slt, dat, _id);
                              if (available) {
                                CustomAlert.alertDialogBuilder(
                                  context: context,
                                  title: "Error",
                                  message:
                                      "Study Room has already booked by someone else!",
                                  action: "ok",
                                );
                              } else {
                                _studyroomId = _id;
                                print(_studyroomId);
                              }
                            }
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Please Neter the value";
                          } else if (value.length < 10) {
                            return "Please enter valid input";
                          }
                        }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.people_alt),
                          labelText: 'Student Count *',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value != null) {
                            _studentCount = int.parse(value);
                            if (_studentCount == 0) {
                              CustomAlert.alertDialogBuilder(
                                context: context,
                                title: "Error",
                                message:
                                    "Please enter student count more than 0!",
                                action: "ok",
                              );
                            }
                          } else {
                            CustomAlert.alertDialogBuilder(
                              context: context,
                              title: "Error",
                              message: "You must enter the Student Count!",
                              action: "ok",
                            );
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Please Neter the value";
                          } else if (value.length < 10) {
                            return "Please enter valid input";
                          }
                        }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.note),
                          labelText: 'Purpose *',
                        ),
                        maxLength: 50,
                        onChanged: (value) {
                          if (value == null) {
                            CustomAlert.alertDialogBuilder(
                              context: context,
                              title: "Error",
                              message: "Please Enter the Purpose!",
                              action: "ok",
                            );
                          } else {
                            _purpose = value;
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Please Neter the value";
                          } else if (value.length < 10) {
                            return "Please enter valid input";
                          }
                        }),
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
                        onPressed: () {
                          _addReservation();
                        },
                        child: Text("Submit"),
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
