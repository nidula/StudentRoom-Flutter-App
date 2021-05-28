import 'package:flutter/material.dart';
import 'package:navigation_drawer_example/widget/reservation_card.dart';

class AvailableRoomsPage extends StatefulWidget {
  @override
  _AvailableRoomsPageState createState() => _AvailableRoomsPageState();
}

class _AvailableRoomsPageState extends State<AvailableRoomsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Available Study Rooms'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: ListView(
  padding: const EdgeInsets.all(8),
  children: <Widget>[
    ReservationCard(),
    ReservationCard(),
    ReservationCard(),
  ],
),
      );
  }
}

