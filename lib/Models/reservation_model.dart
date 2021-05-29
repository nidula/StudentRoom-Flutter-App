import 'dart:convert';

Reservation issueFromJson(String str) => Reservation.fromJson(json.decode(str));

String issueToJson(Reservation data) => json.encode(data.toJson());

class Reservation{

 int bid;
 DateTime fromTime;
 DateTime toTime;
 int studentCount;
 DateTime reservationDate;
 int userId;
 int sID;
 String purpose;

  Reservation(
      this.bid,
      this.fromTime,
      this.toTime,
      this.reservationDate,
      this.sID,
      this.studentCount,
      this.purpose,
      this.userId, 
  );

  factory Reservation.fromJson(Map<String, dynamic> json)=> Reservation(
   json["bId"],
   json["fromTime"],
   json["toTime"],
   json["reservationDate"],
   json["sid"],
   json["studentCount"],
   json["purpose"],
   json["userId"]
  );

   Map<String, dynamic> toJson() =>{
     "bId": bid,
     "FromTime":fromTime,
     "ToTime":toTime,
     "StudentCount":studentCount,
     "ReservationDate":reservationDate,
     "UserId":userId,
     "sid":sID,
     "Purpose":purpose
   };



}