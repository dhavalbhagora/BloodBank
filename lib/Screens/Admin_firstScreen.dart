import 'package:bloodbank/Color/Colors.dart';
import 'package:bloodbank/Database/dbHelper.dart';
import 'package:bloodbank/LoginScreen/login1.dart';
import 'package:bloodbank/Wait.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminFirstscreen extends StatefulWidget {
  const AdminFirstscreen({super.key});

  @override
  State<AdminFirstscreen> createState() => _AdminFirstscreenState();
}

class _AdminFirstscreenState extends State<AdminFirstscreen> {
  DatabaseHelper myDBhelper = DatabaseHelper.instance;
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController Fname = TextEditingController();
  TextEditingController Lname = TextEditingController();
  TextEditingController City = TextEditingController();
  TextEditingController Mobile = TextEditingController();
  TextEditingController Gender = TextEditingController();
  TextEditingController Bloodgp = TextEditingController();
  TextEditingController Bank = TextEditingController();
  String? _selectedCity;
  String? _selectedBgroup;
  String? _selectedBloodbank;

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
    'Mehsana',
    'Jamnagar',
    'Rajkot',
    'Baroda',
    'Surat'
  ];
  final Map<String, List<String>> serviceCenters = {
    'Ahmedabad': [
      'Red Cross Blood Ahmedabad',
      'Alpha Blood bank',
      'Tata BloodBank NGO',
      'Government Blood Bank Ahmedabad'
    ],
    'Mehsana': ['Red Cross Rajkot', 'Government Blood Bank Rajkot'],
    'Jamnagar': ['City Blood Center ', 'Government BloodBank Jamnagar'],
    'Rajkot': ['Red Cross Blood Bank', 'Government Blood bank'],
    'Baroda': ['Government Blood Bank ', 'Maharajah Sayajirao BloodBank'],
    'Surat': ['Red Cross BloodBank', 'City center Blood Bank'],
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
        title: Text('Instand Blood Admin Side'),
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Enter Donners Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                    key: formGlobalKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: Fname,
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
                          controller: Lname,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: MyColors.primaryColor,
                            ),
                            hintText: "Enter Donner Last Name",
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
                          controller: Mobile,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone_android,
                              color: MyColors.primaryColor,
                            ),
                            hintText: "Enter Donner Number",
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
                          keyboardType: TextInputType.number,
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
                          onPressed: () async {
                            var sharedpref =
                                await SharedPreferences.getInstance();
                            sharedpref.setBool(
                                SplashScreenState.KEYLOGIN, true);
                            if (formGlobalKey.currentState!.validate()) {
                              insertDonner();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Blood Donner Add")),
                              );
                            }
                            ;
                          },
                          child: Text('Add Donner'),
                          style: ElevatedButton.styleFrom(
                              foregroundColor: MyColors.primaryColor,
                              backgroundColor: Colors.white),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> insertDonner() async {
    Map<String, dynamic> row = {
      myDBhelper.columnNameD: Fname.text,
      myDBhelper.columnLNameD: Lname.text,
      myDBhelper.columnMobileD: Mobile.text,
      myDBhelper.columncityD: _selectedCity,
      myDBhelper.columnbloodgroupD: _selectedBgroup,
      myDBhelper.columnbloodbankD: _selectedBloodbank
    };

    print('insert stRT');

    final id = await myDBhelper.insertDonner(row);
    print('inserted row id: $id');
  }
}
