import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qrscan/styles/app_colors.dart';
import 'package:qrscan/view/home/home.dart';

import 'package:sqflite/sqflite.dart';

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

Future<void> openUrl({required String url}) async {
  await FlutterWebBrowser.openWebPage(
    url: url,
    customTabsOptions: CustomTabsOptions(
        defaultColorSchemeParams: CustomTabsColorSchemeParams(
      toolbarColor: AppColors.primary,
      navigationBarColor: AppColors.transparent,
    )),
  );
}
