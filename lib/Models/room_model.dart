import 'dart:convert';

StudyRoom issueFromJson(String str) => StudyRoom.fromJson(json.decode(str));

String issueToJson(StudyRoom data) => json.encode(data.toJson());


class StudyRoom{

late int sId;
late int floor;
late int capacity;
late int options;
late String location;

StudyRoom(
  this.sId,
  this.floor,
  this.capacity,
  this.options,
  this.location,
);

factory StudyRoom.fromJson(Map<String, dynamic> json)=> StudyRoom(
   json["sId"],
   json["floor"],
   json["capacity"],
   json["options"],
   json["location"],
  );

   Map<String, dynamic> toJson() =>{
     "sId": sId,
     "floor":floor,
     "capacity":capacity,
     "options":options,
     "location":location,
   };

}