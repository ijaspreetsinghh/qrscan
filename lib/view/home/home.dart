import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qrscan/styles/app_colors.dart';
import 'package:qrscan/view/create/create.dart';
import 'package:qrscan/view/history/history.dart';
import 'package:qrscan/view/scan/scan.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final RxInt currentIndex = 0.obs;

  final pages = [
    CreateQrCode(),
    ScannerPage(),
    HistoryPage(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Obx(() => AnimatedSwitcher(
              duration: Duration(
                milliseconds: 250,
              ),
              child: pages[currentIndex.value],
            )),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.lightBg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: LayoutBuilder(builder: (context, rowSize) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: rowSize.maxWidth / 3,
                  child: InkWell(
                    onTap: () {
                      currentIndex.value = 0;
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() => SvgPicture.asset(
                              'assets/images/create.svg',
                              // ignore: deprecated_member_use
                              color: currentIndex.value == 0
                                  ? AppColors.primary
                                  : AppColors.dark,
                              height: 18,
                            )).marginOnly(bottom: 4),
                        Obx(() => Text(
                              'Create',
                              style: soraBold.copyWith(
                                  fontSize: 11,
                                  color: currentIndex.value == 0
                                      ? AppColors.primary
                                      : AppColors.dark),
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: rowSize.maxWidth / 3,
                  child: InkWell(
                    onTap: () {
                      currentIndex.value = 1;
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() => SvgPicture.asset(
                              'assets/images/scan.svg',
                              // ignore: deprecated_member_use
                              color: currentIndex.value == 1
                                  ? AppColors.primary
                                  : AppColors.dark,
                              height: 18,
                            )).marginOnly(bottom: 4),
                        Obx(() => Text(
                              'Scan',
                              style: soraBold.copyWith(
                                  fontSize: 11,
                                  color: currentIndex.value == 1
                                      ? AppColors.primary
                                      : AppColors.dark),
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: rowSize.maxWidth / 3,
                  child: InkWell(
                    onTap: () {
                      currentIndex.value = 2;
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() => SvgPicture.asset(
                              'assets/images/history.svg',
                              // ignore: deprecated_member_use
                              color: currentIndex.value == 2
                                  ? AppColors.primary
                                  : AppColors.dark,
                              height: 18,
                            )).marginOnly(bottom: 4),
                        Obx(() => Text(
                              'History',
                              style: soraBold.copyWith(
                                  fontSize: 11,
                                  color: currentIndex.value == 2
                                      ? AppColors.primary
                                      : AppColors.dark),
                            ))
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   width: rowSize.maxWidth / 4,
                //   child: InkWell(
                //     onTap: () {
                //       currentIndex.value = 3;
                //     },
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Obx(() => SvgPicture.asset(
                //               'assets/images/setting.svg',

                //               // ignore: deprecated_member_use
                //               color: currentIndex.value == 3
                //                   ? AppColors.primary
                //                   : AppColors.dark,
                //               height: 18,
                //             )).marginOnly(bottom: 4),
                //         Obx(() => Text(
                //               'Settings',
                //               style: soraBold.copyWith(
                //                   fontSize: 11,
                //                   color: currentIndex.value == 3
                //                       ? AppColors.primary
                //                       : AppColors.dark),
                //             ))
                //       ],
                //     ),
                //   ),
                // ),
              ],
            );
          }),
        ).marginOnly(bottom: 16, right: 16, left: 16));
  }
}
