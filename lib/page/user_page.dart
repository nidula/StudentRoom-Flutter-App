import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('User Profile'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
       body: Column(
         children: [
           Row(
             children: [
               Column(
                 children: [
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
               SizedBox(
                width: 10.0,
              ),
              Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "user.name",
                          style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "user.nic,",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "user.area",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                )
             ],
           ),
           SizedBox(
             height: MediaQuery.of(context).size.height*0.05,
           ),
           Text("Reservations", style: TextStyle(
             fontSize: 18.0,
             fontWeight: FontWeight.bold
           ),),
           SizedBox(
             height: MediaQuery.of(context).size.height*0.05,
           ),
          
         ],
       ),
      );
  }
}
