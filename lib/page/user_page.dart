import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        //drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('User Profile'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
      );
}
