import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrscan/styles/app_colors.dart';

import '../../main.dart';

class ScannerPage extends StatefulWidget {
  ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final MobileScannerController mobileScannerController =
      MobileScannerController();

  BannerAd? belowScannerBanner;
  @override
  void initState() {
    belowScannerBanner = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-8262174744018997/3415600822',
        listener: BannerAdListener(
          onAdFailedToLoad: (ad, error) {
            print(error);
          },
        ),
        request: AdRequest());
    belowScannerBanner!.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(
      ad: belowScannerBanner!,
    );

    final Container adContainer = Container(
      child: adWidget,
      width: belowScannerBanner!.size.width.toDouble(),
      height: belowScannerBanner!.size.height.toDouble(),
    );
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: AppColors.transparent),
        title: Text(
          'Scan',
          style: soraMedium.copyWith(fontSize: 20, color: AppColors.white),
        ),
        elevation: 0,
        backgroundColor: AppColors.primary,
      ),
      body: LayoutBuilder(builder: (context, size) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: InkWell(
                    child: ValueListenableBuilder(
                      valueListenable: mobileScannerController.torchState,
                      builder: (context, state, child) {
                        switch (state) {
                          case TorchState.off:
                            return Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/flash_off.svg',
                                  height: 24,
                                  // ignore: deprecated_member_use
                                  color: AppColors.dark,
                                ).marginOnly(bottom: 8),
                                Text(
                                  'Flash Off',
                                  style: soraBold.copyWith(
                                      fontSize: 12, color: AppColors.dark),
                                )
                              ],
                            );
                          case TorchState.on:
                            return Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/flash_on.svg',
                                  height: 24,
                                  // ignore: deprecated_member_use
                                  color: AppColors.dark,
                                ).marginOnly(bottom: 8),
                                Text(
                                  'Flash On',
                                  style: soraBold.copyWith(
                                      fontSize: 12, color: AppColors.dark),
                                )
                              ],
                            );
                        }
                      },
                    ),
                    onTap: () => mobileScannerController.toggleTorch(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: InkWell(
                      child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/image.svg',
                        height: 24,
                      ).marginOnly(bottom: 8),
                      Text(
                        'Image SCan',
                        style: soraBold.copyWith(
                            fontSize: 12, color: AppColors.dark),
                      )
                    ],
                  )),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: size.maxWidth - 40,
                    width: size.maxWidth - 40,
                    child: MobileScanner(
                      controller: mobileScannerController,
                      allowDuplicates: true,
                      onDetect: (barcode, args) async {
                        if (barcode.rawValue != null) {
                          // final String code = barcode.rawValue!;
                          // mobileScannerController.stop();

                          final now = DateTime.now();
                          // Get.to(
                          //     () => QrDetailsPage(
                          //           codeFormat: barcode.format.name,
                          //           result: barcode.rawValue!,
                          //           type: barcode.type.name,
                          //           dateTime: now,
                          //         ),
                          //     transition: Transition.rightToLeft);
                          await myDatabase.transaction((txn) async {
                            await txn.rawInsert(
                                "INSERT INTO AllScans(scannedOn,codeFormat,result,type) VALUES ( '${now.millisecondsSinceEpoch.toString()}', '${barcode.format.name.toString()}','${barcode.rawValue.toString()}','${barcode.type.name.toString()}' )");
                          });
                        }
                      },
                    )),
              ],
            ),
            adContainer
          ],
        );
      }),
    );
  }
}
