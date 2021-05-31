import 'dart:convert';

Reservation reservationFromJson(String str) => Reservation.fromJson(json.decode(str));

String reservationToJson(Reservation data) => json.encode(data.toJson());

class Reservation{

  int slot;
 int studentCount;
 String reservationDate;
 int userId;
 int sID;
 String purpose;


  Reservation(
    this.slot,
      this.studentCount,
      this.reservationDate,
      this.userId,
      this.sID,
      this.purpose,
  );

  factory Reservation.fromJson(Map<String, dynamic> json)=> Reservation(
  json["Slot"],
   json["studentCount"],
   json["reservationDate"],
   json["userId"],
   json["sid"],
   json["purpose"],
  );

   Map<String, dynamic> toJson() =>{
     "Slot":slot,
     "studentCount":studentCount,
     "reservationDate":reservationDate,
     "userId":userId,
     "sid":sID,
     "purpose":purpose
   };
}