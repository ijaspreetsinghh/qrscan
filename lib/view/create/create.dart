import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qrscan/main.dart';
import 'package:qrscan/styles/app_colors.dart';
import 'package:qrscan/view/create/controller.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class CreateQrCode extends StatefulWidget {
  const CreateQrCode({super.key});

  @override
  State<CreateQrCode> createState() => _CreateQrCodeState();
}

class _CreateQrCodeState extends State<CreateQrCode> {
  final CreateQrController controller = Get.put(CreateQrController());
  ScreenshotController screenshotController = ScreenshotController();
  BannerAd? belowCreateBanner;
  @override
  void initState() {
    controller.qrText.text = controller.qrValue.value;

    belowCreateBanner = BannerAd(
        size: AdSize.largeBanner,
        adUnitId: 'ca-app-pub-8262174744018997/2244336999',
        listener: BannerAdListener(
          onAdFailedToLoad: (ad, error) {
            print(error);
          },
        ),
        request: AdRequest());
    belowCreateBanner!.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(
      ad: belowCreateBanner!,
    );
    final sfQR = Obx(() => SfBarcodeGenerator(
          value: controller.qrValue.value,
          symbology: QRCode(),
        ));
    final Container adContainer = Container(
      child: adWidget,
      width: belowCreateBanner!.size.width.toDouble(),
      height: belowCreateBanner!.size.height.toDouble(),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            statusBarColor: AppColors.transparent),
        title: Text(
          'Create',
          style: soraSemibold.copyWith(fontSize: 24, color: AppColors.white),
        ),
        elevation: 0,
        backgroundColor: AppColors.primary,
      ),
      body: LayoutBuilder(builder: (context, size) {
        return ListView(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: size.maxHeight * .4,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                      ),
                    ),
                    Container(
                      height: size.maxHeight * .6,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                blurStyle: BlurStyle.normal,
                                color: AppColors.grey.withOpacity(.2),
                                offset: Offset(0, 5),
                                spreadRadius: 1)
                          ]),
                      width: size.maxWidth,
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() => Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: controller.bgColor.value,
                                    borderRadius: BorderRadius.circular(14)),
                                child: Container(
                                  height: 160,
                                  width: 160,
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Screenshot(
                                    controller: screenshotController,
                                    child: sfQR,
                                  ),
                                ),
                              )),
                          TextFormField(
                            onChanged: (value) {
                              controller.qrValue.value = value;
                            },
                            controller: controller.qrText,
                            style: soraMedium.copyWith(
                                fontSize: 14, color: AppColors.dark),
                            decoration: InputDecoration(
                              hintText: 'Type to create qr code.',
                              hintStyle: soraMedium.copyWith(
                                  fontSize: 14, color: AppColors.dark),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color: AppColors.grey.withOpacity(.3),
                                      width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color: AppColors.grey.withOpacity(.3),
                                      width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color: AppColors.grey.withOpacity(.3),
                                      width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color: AppColors.grey.withOpacity(.3),
                                      width: 2)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color: AppColors.grey.withOpacity(.3),
                                      width: 2)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color: AppColors.grey.withOpacity(.3),
                                      width: 2)),
                            ),
                          ).marginOnly(
                              right: 20, left: 20, top: 20, bottom: 20),
                          Wrap(
                            alignment: WrapAlignment.spaceEvenly,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.spaceEvenly,
                            runSpacing: 2,
                            spacing: 2,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              ColorPickerBoxForCreateQr(
                                color: Color(0xffff6a6a),
                              ),
                              ColorPickerBoxForCreateQr(
                                color: Color(0xffffb26a),
                              ),
                              ColorPickerBoxForCreateQr(
                                color: Color(0xfffcd967),
                              ),
                              ColorPickerBoxForCreateQr(
                                color: Color(0xff2db67e),
                              ),
                              ColorPickerBoxForCreateQr(
                                color: Color(0xff50f3cc),
                              ),
                            ],
                          ),
                          Divider(
                            color: AppColors.grey.withOpacity(.3),
                            endIndent: 8,
                            indent: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: AlignmentDirectional.center,
                                  height: 56,
                                  decoration: BoxDecoration(),
                                  child: InkWell(
                                    onTap: () {
                                      controller.qrText.clear();
                                      controller.qrValue.value = '';
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: soraBold.copyWith(
                                          fontSize: 16,
                                          color: Color(0xffff6a6a)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 56,
                                width: 1,
                                child: VerticalDivider(
                                  color: AppColors.grey.withOpacity(.3),
                                  width: 56,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: AlignmentDirectional.center,
                                  height: 56,
                                  decoration: BoxDecoration(),
                                  child: Obx(() => InkWell(
                                        onTap: () async {
                                          if (controller
                                              .qrValue.value.isNotEmpty) {
                                            await screenshotController
                                                .captureFromWidget(Obx(
                                              () => Container(
                                                padding: EdgeInsets.all(24),
                                                color: AppColors.white,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Obx(() => Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          decoration: BoxDecoration(
                                                              color: controller
                                                                  .bgColor
                                                                  .value,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          14)),
                                                          child: Container(
                                                            height: 160,
                                                            width: 160,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    6),
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: sfQR,
                                                          ),
                                                        )),
                                                    Text(
                                                      controller.qrValue.value,
                                                      style: soraBold.copyWith(
                                                          fontSize: 14,
                                                          color:
                                                              AppColors.dark),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ))
                                                .then((Uint8List? image) async {
                                              if (image != null) {
                                                final directory =
                                                    await getApplicationDocumentsDirectory();
                                                final imagePath = await File(
                                                        '${directory.path}/${controller.qrValue.value}.png')
                                                    .create();
                                                await imagePath
                                                    .writeAsBytes(image);

                                                await Share.shareXFiles(
                                                    [XFile(imagePath.path)]);
                                                final now = DateTime.now();
                                                await myDatabase
                                                    .transaction((txn) async {
                                                  await txn.rawInsert(
                                                      "INSERT INTO AllScans(dateTime,codeFormat,result,colorHxDVal) VALUES ( '${now.toIso8601String()}', 'qrcode','${controller.qrValue.value}','${controller.bgColor.value.toString().substring(6, 16)}' )");
                                                });
                                              }
                                            });
                                            controller.qrText.clear();
                                            controller.qrValue.value = '';
                                          }
                                        },
                                        child: Text(
                                          'Save',
                                          style: soraBold.copyWith(
                                              fontSize: 16,
                                              color: controller
                                                      .qrValue.value.isNotEmpty
                                                  ? Color(0xff2db67e)
                                                  : AppColors.grey),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ).marginSymmetric(horizontal: 24),
                    Container(
                      // height: 100,
                      // width: 320,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: adContainer,
                    ).marginOnly(top: 20),
                  ],
                )
              ],
            ),
          ],
        );
      }),
    );
  }
}

class ColorPickerBoxForCreateQr extends StatelessWidget {
  ColorPickerBoxForCreateQr({super.key, required this.color});
  final Color color;
  final CreateQrController controller = Get.put(CreateQrController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
          onTap: () {
            controller.bgColor.value = color;
          },
          child: Container(
            decoration: BoxDecoration(
                color: controller.bgColor.value == color
                    ? AppColors.grey.withOpacity(.3)
                    : AppColors.transparent,
                borderRadius: BorderRadius.circular(6)),
            padding: EdgeInsets.all(4),
            child: Container(
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(6)),
              height: 32,
              width: 32,
            ),
          ),
        ));
  }
}
