import 'dart:io';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscan/view/home.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

late Database myDatabase;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var databasesPath = await getDatabasesPath();

  myDatabase = await openDatabase(
    '$databasesPath/allScans.db',
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE AllScans (id INTEGER PRIMARY KEY,scannedOn varchar2 NOT NULL,codeFormat varchar NOT NULL, result varchar2 NOT NULL,type varchar2 NOT NULL)');
    },
  );

  FacebookAudienceNetwork.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Scanner',
      home: QrHomePage(),
    );
  }
}

Future<void> openUrl({required Uri url}) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
