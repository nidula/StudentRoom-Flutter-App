import 'package:flutter/material.dart';
import 'package:navigation_drawer_example/page/reservation_page.dart';
import 'package:navigation_drawer_example/page/availableRoomPage.dart';
import 'package:navigation_drawer_example/page/user_page.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentpage;

  late AvailableRoomsPage homePage;
  late UserPage userPage;
  late ResrvationPage reservationPage;

  @override
  void initState() {
    super.initState();
    homePage = AvailableRoomsPage();
    userPage = UserPage();
    reservationPage = ResrvationPage();

    pages = [homePage, reservationPage, userPage];

    currentpage = homePage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white54,
        backgroundColor: Colors.green,
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
            currentpage = pages[index];
          });
        },
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: "reservation",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "Profile",
          )
        ],
      ),
      body: currentpage,
    );
  }
}

