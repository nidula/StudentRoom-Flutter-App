import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  String _slot = "0";
  DateTime date = DateTime.now();
  
  
  


Future<List<StudyRoom>> getRooms() async {
    try {
      String _date = DateFormat('y-d-M').format(date);
      int _slt = int.parse(_slot);
    List<StudyRoom> room =  await _roomService.getAvailableRooms(_slt, _date);
  
    print(room);
    //print(date);
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
                                    getRooms();
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
                        return ReservationCard(room: st,tim: _slot,);
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
