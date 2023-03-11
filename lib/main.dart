import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qrscan/view/home/home.dart';

import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

late Database myDatabase;
BannerAd resultBanner = BannerAd(
    size: AdSize.fullBanner,
    adUnitId: 'ca-app-pub-8262174744018997/5170431975',
    listener: BannerAdListener(),
    request: AdRequest());

BannerAd historyBanner = BannerAd(
    size: AdSize.fullBanner,
    adUnitId: 'ca-app-pub-8262174744018997/2244336999',
    listener: BannerAdListener(),
    request: AdRequest());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  var databasesPath = await getDatabasesPath();

  myDatabase = await openDatabase(
    '$databasesPath/allScans.db',
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE AllScans (id INTEGER PRIMARY KEY,dateTime varchar2 NOT NULL,codeFormat varchar NOT NULL, result varchar2 NOT NULL,colorHxDVal varchar2 NOT NULL)');
    },
  );

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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Code',
      home: HomePage(),
    );
  }
}

Future<void> openUrl({required Uri url}) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
