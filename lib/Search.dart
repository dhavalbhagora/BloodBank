import 'package:bloodbank/Color/Colors.dart';
import 'package:bloodbank/Database/dbHelper.dart';
import 'package:bloodbank/LoginScreen/login1.dart';
import 'package:bloodbank/Wait.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DatabaseHelper myDBhelper = DatabaseHelper.instance;
  String? _selectedCity;
  String? _selectedBgroup;
  final formGlobalKey = GlobalKey<FormState>();
  bool _isSearchClicked = false;
  final List<String> _Bgroup = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];
  final List<String> _cities = [
    'Ahmedabad',
    'Mehasana',
    'Jamnagar',
    'Rajkot',
    'Baroda',
    'Surat'
  ];
  bool _isListVisible = false;
  void _toggleList() {
    setState(() {
      _isListVisible = !_isListVisible;
    });
  }

  List<Map<String, dynamic>> allBlooddone = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Form(
          key: formGlobalKey,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: 380,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 13,
                    ),
                    Icon(
                      Icons.bloodtype,
                      color: MyColors.primaryColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    DropdownButton<String>(
                      hint: Text("Select Blood Group"),
                      value: _selectedBgroup,
                      items: _Bgroup.map((String bloodgroup) {
                        return DropdownMenuItem<String>(
                          value: bloodgroup,
                          child: Text(bloodgroup),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedBgroup = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                width: 380,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 13,
                    ),
                    Icon(
                      Icons.location_city,
                      color: MyColors.primaryColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    DropdownButton<String>(
                      hint: Text("Select a city"),
                      value: _selectedCity,
                      items: _cities.map((String city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCity = newValue;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  var bg = _selectedBgroup!.toString();
                  var ct = _selectedCity!.toString();
                  fetchDonors(bg, ct);

                  setState(() {
                    _isListVisible = !_isListVisible;
                  });
                },
                child: Text('Search'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primaryColor,
                    foregroundColor: MyColors.white),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              if (_isListVisible)
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
                                    '\nBankName : ${item['bank']} \nCity : ${item['cityU']} ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor: MyColors.primaryColor,
                                    child: Text(
                                      '${item['blood_group']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20),
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchDonors(String bloodgroup, String city) async {
    final dbHelper = DatabaseHelper.instance;
    final result = await dbHelper.queryAllDonnerSearch(bloodgroup, city);

    setState(() {
      allBlooddone = result; // Update the state with fetched data
    });
    setState(() {});
  }

  list() {
    return ListView.builder(
        itemCount: allBlooddone.length,
        itemBuilder: (context, index) {
          var item = allBlooddone[index];

          return Container(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    "Donner Name: ${item['fnameU']}  ${item['lnameU']}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: MyColors.primaryColor,
                    child: Text(
                      '${item['blood_group']}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                    minRadius: 20,
                    maxRadius: 30,
                  ),
                  subtitle: Text(
                    '\nBankName : ${item['bank']} \nContact No: ${item['Mobile']}\nCity : ${item['cityU']} ',
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
        });
  }
}
