import 'package:bloodbank/Color/Colors.dart';
import 'package:flutter/material.dart';

class cbutton extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const cbutton({super.key, required this.name, required this.onTap});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
        decoration: BoxDecoration(
            color: MyColors.primaryColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all()),
        child: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
