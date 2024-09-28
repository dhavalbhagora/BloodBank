import 'package:bloodbank/Color/Colors.dart';
import 'package:bloodbank/Database/dbHelper.dart';
import 'package:bloodbank/Home.dart';
import 'package:bloodbank/LoginScreen/User_register.dart';
import 'package:bloodbank/Wait.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScereen extends StatefulWidget {
  const LoginScereen({super.key});

  @override
  State<LoginScereen> createState() => _LoginScereenState();
}

class _LoginScereenState extends State<LoginScereen> {
  TextEditingController _pass1 = TextEditingController();
  TextEditingController _phone1 = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  DatabaseHelper myDbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> allData = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Login'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 200),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                    key: formGlobalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.phone, color: MyColors.primaryColor),
                            hintText: "Enter Your phone number ",
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
                          controller: _phone1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.lock, color: MyColors.primaryColor),
                            hintText: "Enter your Password ",
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
                          controller: _pass1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'pass';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            String phone = _phone1.text.toString();
                            String pass = _pass1.text.toString();
                            final com = await myDbHelper.getUser(phone, pass);
                            if (com != null) {
                              //User found
                              var sharedpref =
                                  await SharedPreferences.getInstance();
                              sharedpref.setBool(
                                  SplashScreenState.KEYLOGIN2, true);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Login Successful")),
                              );
                            } else {
                              // User not found
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("Invalid Phone or Password")),
                              );
                            }
                          },
                          child: Text('Submit'),
                          style: ElevatedButton.styleFrom(
                              foregroundColor: MyColors.primaryColor,
                              backgroundColor: MyColors.white),
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
                                    builder: (context) => UserRegister()));
                          },
                          child: Text(
                            'Dont have Account,Singup ',
                            style: TextStyle(color: MyColors.primaryColor),
                          ),
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
}
