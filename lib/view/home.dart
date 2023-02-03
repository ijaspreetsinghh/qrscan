import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qrscan/styles/app_colors.dart';
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
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: const Size(10, 20),
              child: TabBar(
                indicatorColor: AppColors.white,
                tabs: [
                  Text(
                    'Scan',
                    style: nunitoTextStyle.copyWith(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'History',
                    style: nunitoTextStyle.copyWith(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                indicatorSize: TabBarIndicatorSize.tab,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              ),
            ),
          ),
          backgroundColor: AppColors.primary,
          body: TabBarView(
            children: [QrScanner(), Container()],
          )),
    );
  }
}
