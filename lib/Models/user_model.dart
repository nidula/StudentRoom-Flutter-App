import 'dart:convert';

Users issueFromJson(String str) => Users.fromJson(json.decode(str));

String issueToJson(Users data) => json.encode(data.toJson());

class Users{

 late int uId;
 late String fName;
 late String lName;
 late int contact;
 late String address;
 late String batch;
 late String degree;
 late String password;
 late int type;

  Users(
    this.uId,
    this.fName,
    this.lName,
    this.contact,
    this.address,
    this.batch,
    this.degree,
    this.password,
    this.type
  );


  factory Users.fromJson(Map<String, dynamic> json)=> Users(
   json["uId"],
   json["f_name"],
   json["l_name"],
   json["contact"],
   json["address"],
   json["batch"],
   json["degree"],
   json["password"],
   json["type"]
  );

   Map<String, dynamic> toJson() =>{
     "uId": uId,
     "f_name":fName,
     "l_name":lName,
     "contact":contact,
     "address":address,
     "batch":batch,
     "degree":degree,
     "password":password,
     "type":type,
   };
}