import 'package:bloodbank/Color/Colors.dart';
import 'package:bloodbank/Screens/Admin_firstScreen.dart';
import 'package:bloodbank/Screens/admin_profile.dart';
import 'package:bloodbank/Screens/donner_list.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int myindex = 0;
  List<Widget> Widgetlist = [
    AdminFirstscreen(),
    DonnerList(),
    DonnerReq(),
  ];
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Widgetlist[myindex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            myindex = index;
          });
        },
        currentIndex: myindex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: MyColors.primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Search',
              backgroundColor: MyColors.primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.request_page),
              label: 'Request',
              backgroundColor: MyColors.primaryColor),
        ],
      ),
    );
  }
}
