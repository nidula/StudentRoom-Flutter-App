import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReservationCard extends StatefulWidget {
  @override
  _ReservationCardState createState() => _ReservationCardState();
}

class _ReservationCardState extends State<ReservationCard> {
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
            height: MediaQuery.of(context).size.height*0.1,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 2.0,right: 2.0, bottom: 5.0),
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
                            width: MediaQuery.of(context).size.width*0.5,
                            child: Row(
                              children: [
                                  Icon(
                        Icons.location_on,
                        color: Colors.greenAccent,
                        ),
                        SizedBox(width: 10.0,),
                        Text("SOC"), 
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
                                Icons.event_available_sharp,
                                color: Colors.greenAccent,
                              ),
                              SizedBox(width: 10.0,),
                              Text("5", style: TextStyle(color: Colors.black),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: Row(
                              children: [
                                  Icon(Icons.follow_the_signs_sharp, color: Colors.greenAccent,),
                      SizedBox( width: 10.0,),
                      Text("2nd floor"),
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
                               Icon(Icons.access_time_sharp, color: Colors.greenAccent,),
                              SizedBox(width: 10.0,),
                              Text("Evning", style: TextStyle(color: Colors.black),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      
                      SizedBox(width: MediaQuery.of(context).size.width*0.34,),
                     
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