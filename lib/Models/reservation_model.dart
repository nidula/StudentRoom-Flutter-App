import 'dart:convert';

Reservation reservationFromJson(String str) => Reservation.fromJson(json.decode(str));

String reservationToJson(Reservation data) => json.encode(data.toJson());

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
      this.studentCount,
      this.reservationDate,
      this.userId,
      this.sID,
      this.purpose,
  );

  factory Reservation.fromJson(Map<String, dynamic> json)=> Reservation(
   json["bId"],
   json["fromTime"],
   json["toTime"],
   json["studentCount"],
   json["reservationDate"],
   json["userId"],
   json["sid"],
   json["purpose"],
  );

   Map<String, dynamic> toJson() =>{
     "bId": bid,
     "fromTime":fromTime,
     "toTime":toTime,
     "studentCount":studentCount,
     "reservationDate":reservationDate,
     "userId":userId,
     "sid":sID,
     "purpose":purpose
   };
}