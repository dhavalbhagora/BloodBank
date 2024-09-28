import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final dbname = "flutter.db";
  static final dbversion = 1;
  late Database db;
  //table user
  final tablename_idU = "user";
  final columnId1 = '_idU';
  final columnName = 'fnameU';
  final columnLName = 'lnameU';
  final columnPhone = 'phone';
  final columnpass = 'PassU';

  //table admin
  final tablename_idA = "Admin";
  final columnIdA = '_idA';
  final columnfNameA = 'fnameA';
  final columnLNameA = 'lnameA';
  final columnEmailA = 'emailA';
  final columnpassA = 'PassA';
  final columncityA = 'cityA';

  //blood donner
  final tablename_idD = "Blood_Donner";
  final columnIdD = '_idD';
  final columnNameD = 'fnameU';
  final columnLNameD = 'lnameU';
  final columngenderD = 'Gender';
  final columnbloodgroupD = 'blood_group';
  final columnbloodbankD = 'bank';
  final columnMobileD = 'Mobile';
  final columncityD = 'cityU';

  //request table
  final tablename_idR = "Donner_req";
  final columnIdR = '_idR';
  final columnNameR = 'nameR';
  final columnPhoneR = 'PhoneR';
  final columnCityR = 'CityR';
  final columnBankR = 'Bank';
  Database? database1;
  DatabaseHelper._a();
  static final DatabaseHelper instance = DatabaseHelper._a();

  Future<Database> get database async => database1 ??= await _initDatabase();

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbname);
    return await openDatabase(path, version: dbversion, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    //user table
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $tablename_idU (
            $columnId1 INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL, 
            $columnLName TEXT NOT NULL, 
            $columnPhone TEXT NOT NULL, 
            $columnpass TEXT NOT NULL
            )
          ''');
//admin table
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $tablename_idA (
            $columnIdA INTEGER PRIMARY KEY,
            $columnfNameA TEXT NOT NULL, 
            $columnLNameA TEXT NOT NULL,
            $columnEmailA TEXT NOT NULL, 
            $columnpassA TEXT NOT NULL,
            $columncityA TEXT NOT NULL
            )
          ''');

    //blood donation group
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $tablename_idD (
            $columnIdD INTEGER PRIMARY KEY,
            $columnNameD TEXT NOT NULL, 
            $columnLNameD TEXT NOT NULL,
            $columncityD TEXT NOT NULL, 
            $columnMobileD TEXT NOT NULL,
            $columnbloodbankD TEXT NOT NULL, 
            $columnbloodgroupD TEXT NOT NULL 
            )
          ''');
    //donner req
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $tablename_idR (
            $columnIdR INTEGER PRIMARY KEY,
            $columnNameR TEXT NOT NULL, 
            $columnPhoneR TEXT NOT NULL,
            $columnCityR TEXT NOT NULL,
            $columnBankR TEXT NOT NULL 
            
            )
          ''');
  }

  Future<int> insertAdmin(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db.insert(tablename_idA, row);
  }

  Future<int> DonnerReq(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db.insert(tablename_idR, row);
  }

  Future<int> insertUSer(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db.insert(tablename_idU, row);
  }

  Future<int> insertDonner(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db.insert(tablename_idD, row);
  }

  Future<List<Map<String, dynamic>>> queryAllDonner() async {
    Database db = await instance.database;
    return await db.query(tablename_idU); //select * from category
  }

  Future<List<Map<String, dynamic>>> queryAllDonnerreq() async {
    Database db = await instance.database;
    return await db.query(tablename_idR); //select * from category
  }

  Future<List<Map<String, dynamic>>> queryAllDonnerSearch(
      String blood_group, String cityU) async {
    Database db = await instance.database;

    // Query with WHERE condition for bloodgroup and city
    return await db.query(
      tablename_idD, // Replace with your actual table name
      where: 'blood_group = ? AND cityU = ?', // WHERE condition
      whereArgs: [blood_group, cityU], // Values for the placeholders
    );
  }

  Future<List<Map<String, dynamic>>> queryAllbloodlist() async {
    Database db = await instance.database;
    return await db.query(tablename_idD); //select * from category
  }

  Future<Map<String, dynamic>?> getUser(String phone, String pass) async {
    var db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      "user",
      where: "phone = ? AND PassU = ?", // WHERE clause
      whereArgs: [phone, pass], // Arguments to prevent SQL injection
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null; // No user found
  }

  Future<Map<String, dynamic>?> getAdmin(String email, String pass) async {
    var db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      "Admin",
      where: "emailA = ? AND PassA = ?", // WHERE clause
      whereArgs: [email, pass], // Arguments to prevent SQL injection
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null; // No user found
  }

  Future<int> updateDonner(Map<String, dynamic> row) async {
    final db = await database;
    int id = row['_idD']; // Use the id to update the specific product
    return await db.update(
      tablename_idD, // Table name
      row,
      where: '$columnIdD = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteById(int idR) async {
    Database db = await instance.database;
    return await db.delete('Donner_req', where: '_idR = ?', whereArgs: [idR]);
  }

  Future<int> deleteByIddonner(int idD) async {
    Database db = await instance.database;
    return await db.delete('Blood_Donner', where: '_idD = ?', whereArgs: [idD]);
  }
}
