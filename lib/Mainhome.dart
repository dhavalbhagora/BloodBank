import 'package:bloodbank/Color/Colors.dart';
import 'package:bloodbank/Database/dbHelper.dart';
import 'package:bloodbank/LoginScreen/login1.dart';
import 'package:bloodbank/Wait.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  DatabaseHelper myDBhelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> allBlooddone = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _query();
  }

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Prevent closing the dialog by tapping outside
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            'Confirm',
            style: TextStyle(color: MyColors.primaryColor),
          ),
          content: Text('Are you sure for logout'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () async {
                var sharedpref = await SharedPreferences.getInstance();
                sharedpref.setBool(SplashScreenState.KEYLOGIN2, false);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Login_option()));

                /// Dismiss the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Action Confirmed')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of blood'),
        backgroundColor: MyColors.primaryColor,
        foregroundColor: MyColors.white,
        actions: [
          IconButton(
              onPressed: () async {
                _showConfirmationDialog(context);
                // var sharedpref = await SharedPreferences.getInstance();
                // sharedpref.setBool(SplashScreenState.KEYLOGIN, false);
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) => Login_option()));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(children: [
        Expanded(
            child: ListView.builder(
                itemCount: allBlooddone.length,
                itemBuilder: (context, index) {
                  var item = allBlooddone[index];

                  return Container(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                              "Bank :${item['bank']} \nCity :${item['cityU']} "),
                          leading: CircleAvatar(
                            backgroundColor: MyColors.primaryColor,
                            child: Text(
                              '${item['blood_group']}',
                              style: TextStyle(color: Colors.black),
                            ),
                            minRadius: 20,
                            maxRadius: 30,
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 1,
                        )
                      ],
                    ),
                  );
                }))
      ]),
    );
  }

  void _query() async {
    final allRows = await myDBhelper.queryAllbloodlist();
    print('query all rows:');
    allRows.forEach(print);
    allBlooddone = allRows;
    setState(() {});
  }
}
