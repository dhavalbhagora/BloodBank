import 'package:bloodbank/Color/Colors.dart';
import 'package:bloodbank/Database/dbHelper.dart';
import 'package:bloodbank/Home.dart';
import 'package:bloodbank/Screens/user_login.dart';
import 'package:bloodbank/Wait.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  DatabaseHelper myDBhelper = DatabaseHelper.instance;
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController Fname = TextEditingController();
  TextEditingController Lname = TextEditingController();
//  TextEditingController city = TextEditingController();
  TextEditingController Mobile = TextEditingController();
  TextEditingController Pass = TextEditingController();
  TextEditingController Cmpass = TextEditingController();
  //TextEditingController F = TextEditingController();
  String? _selectedCity;
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
          'Instand Blood',
          style: TextStyle(fontWeight: FontWeight.bold),
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
                        controller: Mobile,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: MyColors.primaryColor,
                          ),
                          hintText: "Enter Your Phone number",
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
                        validator: (value) {
                          // Check if the length of the value is 10 digits
                          if (value!.isEmpty) {
                            return '*Please enter your Mobile Number';
                          } else if (!RegExp(
                                  r'^\d{10}$|^\d{3}[-.\s]?\d{3}[-.\s]?\d{4}$')
                              .hasMatch(value)) {
                            return 'enter valid number';
                          } else if (value.length != 10) {
                            return 'enter 10 digit';
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
                      ElevatedButton(
                        onPressed: () async {
                          if (formGlobalKey.currentState!.validate()) {
                            var sharedpref =
                                await SharedPreferences.getInstance();
                            sharedpref.setBool(
                                SplashScreenState.KEYLOGIN2, true);
                            insert();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          }
                          ;
                        },
                        child: Text('Register'),
                        style: ElevatedButton.styleFrom(
                            foregroundColor: MyColors.primaryColor,
                            backgroundColor: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to LoginPage
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScereen()));
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

  void insert() async {
    Map<String, dynamic> row = {
      myDBhelper.columnName: Fname.text,
      myDBhelper.columnLName: Lname.text,
      myDBhelper.columnPhone: Mobile.text,
      myDBhelper.columnpass: Cmpass.text
    };

    print('insert stRT');

    final id = await myDBhelper.insertUSer(row);
    print('inserted row id: $id');
  }
}
