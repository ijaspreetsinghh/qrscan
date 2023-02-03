import 'dart:io';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qrscan/view/home.dart';
import 'package:url_launcher/url_launcher.dart';

late GetStorage storageBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();
  // storageBox = GetStorage();
  FacebookAudienceNetwork.init(
      // testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional
      // iOSAdvertiserTrackingEnabled: true //default false
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
