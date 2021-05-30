import 'package:flutter/material.dart';
import 'package:navigation_drawer_example/Models/reservation_model.dart';
import 'package:navigation_drawer_example/Models/room_model.dart';
import 'package:navigation_drawer_example/Services/reservation_service.dart';
import 'package:navigation_drawer_example/Services/room_service.dart';
import 'package:navigation_drawer_example/widget/reservation_card.dart';

class AvailableRoomsPage extends StatefulWidget {
  @override
  _AvailableRoomsPageState createState() => _AvailableRoomsPageState();
}

class _AvailableRoomsPageState extends State<AvailableRoomsPage> {
  ReservationService rs = new ReservationService();
  StudyRoomService _roomService = StudyRoomService();
  late List<StudyRoom> _rooms;
  String _slot = "Morning";
  DateTime date = DateTime.now();
  
  late DateTime fromTime=new DateTime(date.year, date.month, date.day, 9, 00, 00);
  late DateTime toTime=new DateTime(date.year, date.month, date.day, 12, 30, 00);
  late DateTime dt = new DateTime(date.year, date.month, date.day, 00, 00, 00);
  


Future<List<StudyRoom>> getRooms() async {
    try {
    List<StudyRoom> room =  await _roomService.getAvailableRooms(fromTime, toTime, dt);
    print(fromTime);
    print(toTime);
    print(room);
    print(date);
     return room;
    } catch (e) {
      throw Exception("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Available Study Rooms'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                                    new DateTime(date.year, date.month, date.day, 9, 00, 00);
                                toTime =
                                    new DateTime(date.year, date.month, date.day, 12, 30, 00);
                                    getRooms();
                              } else {
                                fromTime =
                                    new DateTime(date.year, date.month, date.day, 13, 00, 00);
                                toTime =
                                    new DateTime(date.year, date.month, date.day, 16, 30, 00);
                                    getRooms();
                              }
                            });
                          },
                        ),
                ],
              )
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.02,),
          FutureBuilder<List<StudyRoom>>(
            future: getRooms(),
            builder: (context,snapshot){
              if(snapshot.hasError)
              {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "something went wrong",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }
              if(snapshot.connectionState == ConnectionState.done)
              {
                if(snapshot.hasData)
                {
                  _rooms = snapshot.data!;
                  if(_rooms.isNotEmpty)
                  {
                    return ListView.builder(
                      physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _rooms.length,
                      itemBuilder: (context, index)
                      {
                        StudyRoom st = _rooms[index];
                        return ReservationCard(room: st,);
                      }
                      );
                  }
                  else {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "No Rooms available on selected time slot",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }
                }
              }
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            },
            ),
        ],
      ),
    );
  }
}
