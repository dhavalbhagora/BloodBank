import 'package:bloodbank/Color/Colors.dart';
import 'package:bloodbank/Mainhome.dart';
import 'package:bloodbank/Profile.dart';
import 'package:bloodbank/Search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int myindex = 0;
  List<Widget> Widgetlist = [
    MainHomePage(),
    Search(),
    Profile(),
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
              icon: Icon(Icons.search),
              label: 'Search',
              backgroundColor: MyColors.primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.plus_one),
              label: 'RRequest',
              backgroundColor: MyColors.primaryColor),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to perform when button is pressed

          FlutterPhoneDirectCaller.callNumber('8320788920');
          // You can also use Navigator or any other functionality
        },
        child: Icon(
          Icons.emergency_sharp,
          color: MyColors.white,
        ), // Icon inside the button
        backgroundColor: MyColors.primaryColor,
        tooltip: 'Add Item', // Tooltip when long pressing the FAB
      ),
    );
  }
}
