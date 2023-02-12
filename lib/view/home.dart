import 'dart:ui';

import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:qrscan/styles/app_colors.dart';
import 'package:qrscan/view/history.dart';
import 'package:qrscan/view/scanner.dart';

class QrHomePage extends StatefulWidget {
  const QrHomePage({super.key});

  @override
  State<QrHomePage> createState() => _QrHomePageState();
}

class _QrHomePageState extends State<QrHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: AppColors.transparent,
              statusBarIconBrightness: Brightness.light,
            ),
            backgroundColor: AppColors.primary,
            centerTitle: true,
            title: Text(
              'QR App',
              style: nunitoTextStyle.copyWith(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => Get.to(() => History()),
                      icon: Icon(
                        Icons.history_rounded,
                        color: AppColors.white,
                        size: 24,
                      ))
                ],
              )
            ],
            elevation: 0,
          ),
          backgroundColor: AppColors.primary,
          body: QrScanner()),
    );
  }
}
