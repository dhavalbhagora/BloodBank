import 'package:bloodbank/Color/Colors.dart';
import 'package:bloodbank/Database/dbHelper.dart';
import 'package:bloodbank/LoginScreen/Admin_login.dart';
import 'package:bloodbank/Screens/admin_home.dart';
import 'package:bloodbank/Wait.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminRegister extends StatefulWidget {
  const AdminRegister({super.key});

  @override
  State<AdminRegister> createState() => _AdminRegisterState();
}

class _AdminRegisterState extends State<AdminRegister> {
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController Fname = TextEditingController();
  TextEditingController Lname = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Pass = TextEditingController();
  TextEditingController Cmpass = TextEditingController();
  //TextEditingController F = TextEditingController();
  String currentCity = "";
  String? _selectedCity;
  DatabaseHelper myDBhelper = DatabaseHelper.instance;
  final List<String> _cities = [
    'Ahmedabad',
    'Mehasana',
    'Jamnagar',
    'Rajkot',
    'Baroda',
    'Surat'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Registration',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: MyColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
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
                            hintText: "Enter Your First Name",
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            ;
                            if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value!)) {
                              return 'Please enter only text';
                            }
                            ;
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                          controller: Lname,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: MyColors.primaryColor,
                            ),
                            hintText: "Enter Your Second Name",
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            ;
                            if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value!)) {
                              return 'Please enter only text';
                            }
                            ;
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: Email,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: MyColors.primaryColor,
                          ),
                          hintText: "Enter Your Email",
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
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*Please enter your Email';
                          }
                          if (!RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                              .hasMatch(value)) {
                            return 'Enter in valid format';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: Pass,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: MyColors.primaryColor,
                          ),
                          hintText: "Enter Your Password",
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*Please enter your Password';
                          } else if (!RegExp(
                                  r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
                              .hasMatch(value)) {
                            return 'enter a strong pass';
                          }
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: Cmpass,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.lock, color: MyColors.primaryColor),
                          hintText: "Confirm your Password ",
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
                        validator: (value) {
                          if (Cmpass.text != Pass.text) {
                            return '*password not match';
                          }
                          ;
                          if (value!.isEmpty) {
                            return '*Please enter your Password again';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
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
                      ElevatedButton(
                        onPressed: () async {
                          var sharedpref =
                              await SharedPreferences.getInstance();
                          sharedpref.setBool(SplashScreenState.KEYLOGIN, true);
                          if (formGlobalKey.currentState!.validate()) {
                            insertAdmin();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminHomePage()));
                          }
                          ;
                        },
                        child: Text('Register'),
                        style: ElevatedButton.styleFrom(
                            foregroundColor: MyColors.primaryColor,
                            backgroundColor: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to LoginPage
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminLogin()));
                        },
                        child: Text(
                          'Already have an account? Log in',
                          style: TextStyle(color: MyColors.primaryColor),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void insertAdmin() async {
    Map<String, dynamic> row = {
      myDBhelper.columnfNameA: Fname.text,
      myDBhelper.columnLNameA: Lname.text,
      myDBhelper.columnEmailA: Email.text,
      myDBhelper.columnpassA: Cmpass.text,
      myDBhelper.columncityA: _selectedCity
    };

    print('insert stRT');

    final id = await myDBhelper.insertAdmin(row);
    print('inserted row id: $id');
  }
}
