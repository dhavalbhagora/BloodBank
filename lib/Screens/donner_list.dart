import 'package:bloodbank/Color/Colors.dart';
import 'package:bloodbank/Database/dbHelper.dart';
import 'package:bloodbank/LoginScreen/login1.dart';
import 'package:bloodbank/Wait.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonnerList extends StatefulWidget {
  const DonnerList({super.key});

  @override
  State<DonnerList> createState() => _DonnerListState();
}

class _DonnerListState extends State<DonnerList> {
  DatabaseHelper myDBhelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> allBlooddone = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _query();
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
        title: Text('Donner List'),
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
                    trailing: Row(
                      mainAxisSize: MainAxisSize
                          .min, // To make the Row take minimal space
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: MyColors.primaryColor,
                          ),
                          onPressed: () {
                            // Handle edit icon press
                            _showEditDialog(item);
                            print('Edit pressed');
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // Handle delete icon press
                            _deleteItem(item['_idD']);
                            print('Delete pressed');
                          },
                        ),
                      ],
                    ),
                    // trailing: IconButton(
                    //   icon: Icon(Icons.edit, color: MyColors.primaryColor),
                    //   onPressed: () {
                    //     _showEditDialog(item); // Show edit dialog
                    //   },
                    // ),
                    subtitle: Text(
                      '\nBankName : \n${item['bank']} \nContact No: \n${item['Mobile']}\nCity :\n${item['cityU']} ',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
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
    final allRows = await myDBhelper.queryAllbloodlist();
    print('query all rows:');
    allRows.forEach(print);
    allBlooddone = allRows;
    setState(() {});
  }

  void _showEditDialog(Map<String, dynamic> item) {
    // Create controllers with existing values
    TextEditingController fNameu = TextEditingController(text: item['fnameU']);
    TextEditingController LNameu = TextEditingController(text: item['lnameU']);
    TextEditingController blood_group =
        TextEditingController(text: item['blood_group'].toString());
    TextEditingController bank =
        TextEditingController(text: item['bank'].toString());
    TextEditingController number =
        TextEditingController(text: item['Mobile'].toString());
    TextEditingController city =
        TextEditingController(text: item['cityU'].toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Edit Product",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: MyColors.primaryColor, // Dark blue color for title
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(fNameu, 'first  Name', Icons.person),
                SizedBox(height: 10),
                _buildTextField(LNameu, 'LastName', Icons.person),
                SizedBox(height: 10),
                _buildTextField(blood_group, 'Blood Group ', Icons.bloodtype),
                SizedBox(height: 10),
                _buildTextField(
                  bank,
                  'Bloodbank',
                  Icons.home,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  number,
                  'Number',
                  Icons.phone,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  city,
                  'City',
                  Icons.location_city,
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: TextStyle(
                    color: Colors.black), // Match with the theme color
              ),
            ),
            ElevatedButton(
              onPressed: () {
                updateDonner(
                  id: item['_idD'],
                  fname: fNameu.text,
                  lname: LNameu.text,
                  bloodgroup: blood_group.text,
                  bank: bank.text,
                  city: city.text,
                  number: number.text,
                );
              },
              child: Text(
                "Update",
                style: TextStyle(color: MyColors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.primaryColor, // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, IconData icon,
      {TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,

        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        prefixIcon: Icon(icon, color: MyColors.primaryColor), // Icon color
      ),
      keyboardType: keyboardType,
    );
  }

  void updateDonner({
    required int id,
    required String fname,
    required String lname,
    required String bloodgroup,
    required String bank,
    required String city,
    required String number,
  }) async {
    // Update product in database
    await myDBhelper.updateDonner({
      '_idD': id,
      'fNameu': fname,
      'lNameu': lname,
      'blood_group': bloodgroup,
      'bank': bank,
      'Mobile': number,
      'cityU': city,
    });

    // Refresh the list after update
    _query();
    Navigator.of(context).pop(); // Close the dialog box
  }

  Future<void> _deleteItem(int idD) async {
    await myDBhelper.deleteByIddonner(idD);
    _query(); // Reload data after deleting
    setState(() {
      _query();
    });
  }
}
