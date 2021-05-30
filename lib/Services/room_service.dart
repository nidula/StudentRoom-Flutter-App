import 'dart:convert';
import 'package:navigation_drawer_example/Models/reservation_model.dart';
import 'package:navigation_drawer_example/Models/room_model.dart';
import 'package:navigation_drawer_example/Services/reservation_service.dart';
// ignore: import_of_legacy_library_into_null_safe
import "package:scoped_model/scoped_model.dart" show Model;

import 'package:http/http.dart' as http;

class StudyRoomService extends Model {
  List<StudyRoom> parseStudyRoom(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<StudyRoom>((json) => StudyRoom.fromJson(json)).toList();
  }

  Future<List<StudyRoom>> getAllRooms() async {
    try {
      String url =
          "https://hivi-99-ocelotapigateway-r2vpq.ondigitalocean.app/Rooms";
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

  Future<List<StudyRoom>> getAvailableRooms(DateTime fTime, DateTime tTime, DateTime date) async {
    try {
      String url =
          "https://hivi-99-ocelotapigateway-r2vpq.ondigitalocean.app/Rooms/GetBookingsByTime/$fTime/$tTime/$date";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<StudyRoom> studyRoomList = parseStudyRoom(response.body);
        if (studyRoomList.isNotEmpty) {
          return studyRoomList;
        } else {
          return studyRoomList;
        }
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (error) {
      throw Exception('$error');
    }
  }
}
