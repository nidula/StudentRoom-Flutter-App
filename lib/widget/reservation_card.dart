import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation_drawer_example/Models/room_model.dart';

class ReservationCard extends StatefulWidget {
  final StudyRoom room;
  final String tim;
  const ReservationCard({
    required this.room,
    required this.tim,
  });
  @override
  _ReservationCardState createState() => _ReservationCardState();
}

class _ReservationCardState extends State<ReservationCard> {
  late StudyRoom _room;
  late String location;
  late String floor;
  late String capacity;
  late String _time;

  void ConvertString() {
    int fl = _room.floor;
    int ca = _room.capacity;

    location = _room.location;
    floor =  fl.toString();
    capacity = ca.toString();
    
    print(location);
    print(floor);
    print(capacity);
  }

  @override
  void initState() {
    _room = widget.room;
    _time = widget.tim;
    ConvertString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            padding: EdgeInsets.all(
              10.0,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 2.0, right: 2.0, bottom: 5.0),
            //padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(color: Colors.green[50], boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
                offset: Offset(0, 0.3),
                color: Colors.black38,
              )
            ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.greenAccent,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              SizedBox(

                                child: Text(
                                  location,
                                  style: TextStyle(color: Colors.black),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.people,
                                color: Colors.greenAccent,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              SizedBox(

                                child: Text(
                                  capacity,
                                  style: TextStyle(color: Colors.black),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Row(
                            children: [
                              Icon(
                                Icons.follow_the_signs_sharp,
                                color: Colors.greenAccent,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: Text(
                                  floor,
                                  style: TextStyle(color: Colors.black),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time_sharp,
                                color: Colors.greenAccent,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              SizedBox(
                                child: Text(
                                  _time,
                                  style: TextStyle(color: Colors.black),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.34,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
