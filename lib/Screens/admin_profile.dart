import 'package:bloodbank/Color/Colors.dart';
import 'package:bloodbank/Database/dbHelper.dart';
import 'package:bloodbank/LoginScreen/login1.dart';
import 'package:bloodbank/Wait.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonnerReq extends StatefulWidget {
  const DonnerReq({super.key});

  @override
  State<DonnerReq> createState() => _DonnerReqState();
}

class _DonnerReqState extends State<DonnerReq> {
  DatabaseHelper myDBhelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> allBlooddone = [];

  List<bool> selected = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _query();
    selected = List<bool>.filled(allBlooddone.length, false);
  }

  void _onIconPressed(int index) {
    setState(() {
      // Toggle the icon color by updating the 'selected' status
      selected[index] = !selected[index];
    });
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
                sharedpref.setBool(SplashScreenState.KEYLOGIN, false);
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
        title: Text('Donner Request'),
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
      backgroundColor: MyColors.white,
      body: ListView.builder(
          itemCount: allBlooddone.length,
          itemBuilder: (context, index) {
            var item = allBlooddone[index];

            return Container(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "Donner Name: ${item['nameR']}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              _deleteItem(item['_idR']);
                            },
                            icon: Icon(Icons.done, color: Colors.red)),
                      ],
                    ),
                    subtitle: Text(
                      '\nContact : ${item['PhoneR']}\nBankName : ${item['Bank']} \nCity: ${item['CityR']}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                  )
                ],
              ),
            );
          }),
    );
  }

  void _query() async {
    final allRows = await myDBhelper.queryAllDonnerreq();
    print('query all rows:');
    allRows.forEach(print);
    allBlooddone = allRows;
    setState(() {});
  }

  Future<void> _deleteItem(int idR) async {
    await myDBhelper.deleteById(idR);
    _query(); // Reload data after deleting
    setState(() {
      _query();
    });
  }
}
