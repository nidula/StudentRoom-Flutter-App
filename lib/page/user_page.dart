import 'package:flutter/material.dart';
import 'package:navigation_drawer_example/Models/room_model.dart';
import 'package:navigation_drawer_example/Models/user_model.dart';
import 'package:navigation_drawer_example/Services/room_service.dart';
import 'package:navigation_drawer_example/Services/user_service.dart';
import 'package:navigation_drawer_example/widget/room_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserService _userService = UserService();
  StudyRoomService _roomService = StudyRoomService();
  late List<StudyRoom> _rooms;
  Future<String?> getUid() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString("uid");
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<Users> getUser() async {
    try {
      String uid = (await getUid())!;
      int id = int.parse(uid);
      Users user = await _userService.getUserById(id);
      return user;
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<List<StudyRoom>> getRoomsForUser() async {
    try {
      String uid = (await getUid())!;
      int id = int.parse(uid);
      List<StudyRoom> reservationList = await _roomService.getRoomsByUser(id);
      return reservationList;
    } catch (e) {
      throw Exception("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
       body: Column(
         children: [
           Row(
             children: [
               SizedBox(
                width: 110,
                height: 110,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(65),
                      child: Container(
                        color: Colors.black,
                        width: 110,
                        height: 110,
                      ),
                    ),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.network(
                          "https://images.pexels.com/photos/2078265/pexels-photo-2078265.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260",
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
               FutureBuilder(
                 future: getUser(),
                 builder: (BuildContext context, AsyncSnapshot snapshot){
                   if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Can not load...",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    Users user = snapshot.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          user.fName,
                          style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          user.batch,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          user.degree,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    );
                  }
                   return Text(
                    "Loading...",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  );
                 }),
               SizedBox(
                width: 10.0,
              ),
             ],
           ),
           SizedBox(
             height: MediaQuery.of(context).size.height*0.05,
           ),
           Text("Your Reservations History", style: TextStyle(
             fontSize: 18.0,
             fontWeight: FontWeight.bold
           ),),
           SizedBox(
             height: MediaQuery.of(context).size.height*0.05,
           ),
          FutureBuilder<List<StudyRoom>>(
            future: getRoomsForUser(),
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
                        return RoomCard(room: st);
                      }
                      );
                  }
                  else {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "You have no reservations",
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
