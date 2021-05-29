import 'dart:convert';
import 'package:navigation_drawer_example/Models/reservation_model.dart';
import 'package:navigation_drawer_example/Models/room_model.dart';
import 'package:navigation_drawer_example/Services/reservation_service.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:http/http.dart' as http;

class StudyRoomService extends Model{

  List<StudyRoom> parseStudyRoom(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<StudyRoom>((json) => StudyRoom.fromJson(json)).toList();
  }

  Future<List<StudyRoom>> getAllRooms() async {
    try {
      String url = "http://hivi-99-ocelotapigateway-r2vpq.ondigitalocean.app/Rooms";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<StudyRoom> studyRoomList = parseStudyRoom(response.body);
        if (studyRoomList.isNotEmpty) {
          return studyRoomList;
        } else {
          throw Exception('no Rooms');
        }
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (error) {
      throw Exception('$error');
    }
  }

  Future<List<StudyRoom>> getAvailableRooms(DateTime fTime,DateTime tTime, DateTime date) async {
    ReservationService rs = new ReservationService();
    try {
      List<StudyRoom> std = getAllRooms() as List<StudyRoom>;
      List<Reservation> res = rs.getReservtionsByTime(fTime, tTime, date) as List<Reservation>;
      
      int stdcount = std.length;
      int rescount = res.length;

      for(int i=0;i<stdcount;i++)
      {
        for(int d=0; d<rescount;d++)
        {
          int srid = std[i].sId;
          int rsid = res[d].sID;
          if(rsid== srid)
          {
            std.removeAt(i);
            break;
          }
        }
      }
      return std;
    } catch (error) {
      throw Exception('$error');
    }
  }

}