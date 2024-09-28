import 'package:bloodbank/Color/Colors.dart';
import 'package:bloodbank/Database/dbHelper.dart';
import 'package:bloodbank/LoginScreen/Admin_register.dart';
import 'package:bloodbank/Screens/admin_home.dart';
import 'package:bloodbank/Wait.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController _pass1 = TextEditingController();
  TextEditingController _email = TextEditingController();
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
        title: Text('login'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 200),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: formGlobalKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.mail, color: MyColors.primaryColor),
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
                        controller: _email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email';
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
                          String email = _email.text.toString();
                          String pass = _pass1.text.toString();
                          final com = await myDbHelper.getAdmin(email, pass);
                          var sharedpref =
                              await SharedPreferences.getInstance();
                          sharedpref.setBool(SplashScreenState.KEYLOGIN, true);
                          if (com != null) {
                            //User found

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminHomePage()));
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
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to LoginPage
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminRegister()));
                        },
                        child: Text(
                          'Dont have account? Sing up',
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
}
