import 'dart:convert';
import 'dart:io';
import 'package:navigation_drawer_example/Models/reservation_model.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';

import 'package:http/http.dart' as http;

class ReservationService extends Model{
   List<Reservation> parseReservation(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Reservation>((json) => Reservation.fromJson(json)).toList();
  }

   Future<http.Response> addReservtion(Reservation reservation) async {
    String url = "http://hivi-99-ocelotapigateway-r2vpq.ondigitalocean.app/Books";

    final http.Response response = await http.post(Uri.parse(url),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: reservationToJson(reservation));
    return response;
  }

  Future<List<Reservation>> getReservtionsByTime(DateTime ftime,DateTime tTime,DateTime date) async {
    try {
      String url = "https://hivi-99-ocelotapigateway-r2vpq.ondigitalocean.app/Books/GetBookingsByTime/$ftime/$tTime/$date";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<Reservation> studyRoomList = parseReservation(response.body);
        if (studyRoomList.isNotEmpty) {
          return studyRoomList;
        } else {
          return studyRoomList = [];
        }
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (error) {
      throw Exception('$error');
    }
  }
  
}