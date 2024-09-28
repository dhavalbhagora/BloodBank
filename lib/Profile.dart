import 'package:bloodbank/Color/Colors.dart';
import 'package:bloodbank/Database/dbHelper.dart';
import 'package:bloodbank/LoginScreen/login1.dart';
import 'package:bloodbank/Wait.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DatabaseHelper myDBhelper = DatabaseHelper.instance;
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  String? _selectedBloodbank;
  String? _selectedCity;
  final List<String> _cities = [
    'Ahmedabad',
    'Mehasana',
    'Jamnagar',
    'Rajkot',
    'Baroda',
    'Surat'
  ];
  final Map<String, List<String>> serviceCenters = {
    'Ahmedabad': [
      'Red Cross BLood Ahmedabad',
      'Alpha Blood bank',
      'Tata BloodBank NGO',
      'Government Blood Bank Ahmedabad'
    ],
    'Mehsana': ['Red Cross Rajkot', 'Government Blood Bank Rajkot'],
    'Jamnagar': ['City Blood Center ', 'Government BloodBank Jamnagar'],
    'Rajkot': ['Red Cross Blood Bank', 'Government BloodBank'],
    'Baroda': ['Government Blood Bank ', 'Maharajah Sayajirao BloodBank'],
    'Surat': [
      'Red Cross BloodBank',
      'City center Blood Bank',
      'Indira blood Bank'
    ],
  };
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
        title: Text('Request for Donnation'),
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
        padding: EdgeInsets.only(top: 100, left: 10, right: 10),
        child: Form(
          key: formGlobalKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: MyColors.primaryColor,
                    ),
                    hintText: "Enter Donner First Name",
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                      color: MyColors.primaryColor,
                    ),
                    hintText: "Enter Phone NUmber",
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                        Icons.home,
                        color: MyColors.primaryColor,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      DropdownButton<String>(
                        hint: Text('Select a Service Center'),
                        value: _selectedBloodbank,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedBloodbank = newValue;
                          });
                        },
                        items: _selectedCity == null
                            ? []
                            : serviceCenters[_selectedCity]!
                                .map<DropdownMenuItem<String>>(
                                    (String serviceCenter) {
                                return DropdownMenuItem<String>(
                                  value: serviceCenter,
                                  child: Text(serviceCenter),
                                );
                              }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formGlobalKey.currentState!.validate()) {
                      DonnerReq1();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Request Sent For blood Danation")),
                      );
                    }
                    ;
                  },
                  child: Text(
                    'ADD REQUEST',
                    style: TextStyle(),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primaryColor,
                      foregroundColor: MyColors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> DonnerReq1() async {
    Map<String, dynamic> row = {
      myDBhelper.columnNameR: name.text,
      myDBhelper.columnCityR: _selectedCity,
      myDBhelper.columnPhoneR: phone.text,
      myDBhelper.columnBankR: _selectedBloodbank
    };
    print('insert stRT');
    final id = await myDBhelper.DonnerReq(row);
    print('inserted row id: $id');
  }
}
