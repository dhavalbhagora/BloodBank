import 'package:bloodbank/Color/Colors.dart';
import 'package:bloodbank/LoginScreen/Admin_login.dart';
import 'package:bloodbank/Screens/user_login.dart';
import 'package:flutter/material.dart';

class Login_option extends StatefulWidget {
  const Login_option({super.key});

  @override
  State<Login_option> createState() => _Login_optionState();
}

class _Login_optionState extends State<Login_option> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Chose Your Login',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: MyColors.primaryColor,
        foregroundColor: MyColors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminLogin()));
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 100, // Circle size
                    backgroundImage: AssetImage('assets/Admin.png'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Admin',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: MyColors.primaryColor),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: MyColors.primaryColor,
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScereen()));
                    //    Navigator.pushReplacement(context, MaterialPageRoute(builder: ));
                  },
                  child: CircleAvatar(
                    radius: 100, // Circle size
                    backgroundImage: AssetImage('assets/User.jpg'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'User/Donner',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: MyColors.primaryColor),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
