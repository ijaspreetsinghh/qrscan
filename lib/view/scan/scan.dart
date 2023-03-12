import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrscan/styles/app_colors.dart';
import 'package:qrscan/styles/overlays.dart';
import 'package:qrscan/view/history/qr_details.dart';

import '../../main.dart';

class ScannerPage extends StatefulWidget {
  ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage>
    with SingleTickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();

  MobileScannerController mobileScannerController = MobileScannerController(
    torchEnabled: false,
    facing: CameraFacing.back,
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  RxDouble zoomFactor = 0.0.obs;
  BannerAd? belowScannerBanner;
  @override
  void initState() {
    belowScannerBanner = BannerAd(
        size: AdSize.mediumRectangle,
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
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: AppColors.transparent),
        title: Text(
          'Scan',
          style: soraSemibold.copyWith(fontSize: 24, color: AppColors.dark),
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
      ),
      body: LayoutBuilder(builder: (context, size) {
        return ListView(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  style: soraSemibold.copyWith(
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
                                  style: soraSemibold.copyWith(
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
                      onTap: () async {
                        try {
                          final XFile? pickedFile = await _picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (pickedFile != null) {
                            final resp = await mobileScannerController
                                .analyzeImage(pickedFile.path);
                            if (!resp) {
                              showSnackbar(
                                  snackbarStatus: MySnackbarStatus.error,
                                  title: 'No code found',
                                  msg:
                                      'Please choose image with qr/barcode in it.',
                                  milliseconds: 3000);
                            }
                          }
                        } catch (e) {
                          showSnackbar(
                              snackbarStatus: MySnackbarStatus.error,
                              title: 'No code found',
                              msg: 'Please choose image with qr/barcode in it.',
                              milliseconds: 3000);
                        }
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/images/image.svg',
                            height: 24,
                            // ignore: deprecated_member_use
                            color: AppColors.dark,
                          ).marginOnly(bottom: 8),
                          Text(
                            'Image Scan',
                            style: soraSemibold.copyWith(
                                fontSize: 12, color: AppColors.dark),
                          )
                        ],
                      )),
                ),
              ],
            ).marginOnly(top: 20, bottom: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: size.maxWidth - 40,
                    width: size.maxWidth - 40,
                    child: MobileScanner(
                      controller: mobileScannerController,
                      onDetect: (barcode) async {
                        if (barcode.barcodes.first.rawValue != null) {
                          // final String code = barcode.rawValue!;

                          final now = DateTime.now();

                          await myDatabase.transaction((txn) async {
                            await txn.rawInsert(
                                "INSERT INTO AllScans(dateTime,codeFormat,result,colorHxDVal) VALUES ( '${now.toIso8601String()}', '${barcode.barcodes.first.format.name.toString()}','${barcode.barcodes.first.rawValue.toString()}','0xff7250f2' )");
                          });
                          Get.to(
                              () => QrDetails(
                                    format: barcode.barcodes.first.format.name
                                        .toString(),
                                    value: barcode.barcodes.first.rawValue
                                        .toString(),
                                    color: Color(0xff7250f2),
                                    dateTime: now,
                                    id: 0,
                                  ),
                              transition: Transition.rightToLeft);
                          mobileScannerController.start();
                        }
                      },
                    )),
              ],
            ),
            Row(
              children: [
                // ignore: deprecated_member_use
                SvgPicture.asset(
                  'assets/images/zoom_out.svg',
                  height: 20,
                  // ignore: deprecated_member_use
                  color: AppColors.dark,
                ),

                Expanded(
                  child: Obx(() => Slider(
                        value: zoomFactor.value,
                        activeColor: AppColors.primary,
                        onChanged: (value) {
                          zoomFactor.value = value;
                          mobileScannerController.setZoomScale(value);
                        },
                      )),
                ),
                SvgPicture.asset(
                  'assets/images/zoom_in.svg',
                  height: 20,
                  // ignore: deprecated_member_use
                  color: AppColors.dark,
                ),
              ],
            ).marginSymmetric(horizontal: 20, vertical: 20),
            adContainer.marginOnly(bottom: 24),
          ],
        );
      }),
    );
  }
}
