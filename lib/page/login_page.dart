import 'package:flutter/material.dart';
import 'package:navigation_drawer_example/Services/user_service.dart';
import 'package:navigation_drawer_example/main_screen.dart';
import 'package:navigation_drawer_example/widget/custom_alert.dart';
import 'package:navigation_drawer_example/widget/custom_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'availableRoomPage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late BuildContext showLoadingDialogContext;
  UserService _userService = new UserService();

  String _pw = "";
  String _id = "";
  int d = 0;

  void _submitForm() async {
    if (_pw != "" && _id != "") {
      CustomLoading.showLoadingDialog(
        context: context,
        message: "Loging...",
      );
      await _loginAccount();
    } else {
      CustomAlert.alertDialogBuilder(
        context: context,
        title: "Error",
        message: "Some input fields are empty..!",
        action: "Ok",
      );
    }
  }

  late FocusNode _passwordFocusNode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              
              SizedBox(
                height: MediaQuery.of(context).size.height / 3.2,
              ),
              TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Student ID Card Number *',
                  ),
                  maxLength: 9,
                  onChanged: (value){
                    _id = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Please Enter the value";
                    } else if (value.length < 9) {
                      return "Please enter valid input";
                    }
                  }),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.vpn_key_rounded),
                    labelText: 'Password *',
                  ),
                  maxLength: 50,
                  obscureText: true,
                  onChanged: (value){
                    _pw=value;
                  },
                  
                  validator: (value) {
                    if (value == null) {
                      return "Please Neter the value";
                    } else if (value.length < 10) {
                      return "Please enter valid input";
                    }
                  }),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    primary: Colors.greenAccent[400],
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                      _submitForm();
                  },
                  child: Text("Submit"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ],
      ),
    );
  }

    Future _loginAccount() async {
    try {
      int userId = await _userService.loginUser(_id,_pw);
      String uid = userId.toString();
      if (userId != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("uid", uid);
        prefs.setBool("access", true);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => MainScreen(),
          ),
          (route) => false,
        );
      } else {
        CustomLoading.closeLoading(context: context);
        CustomAlert.alertDialogBuilder(
          context: context,
          title: "Error",
          message: "Invalid Credentials!",
          action: "Ok",
        );
      }
    } catch (e) {
      CustomAlert.alertDialogBuilder(
        context: context,
        title: "Error",
        message: "$e",
        action: "Ok",
      );
    }
  }
}
