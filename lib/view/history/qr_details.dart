import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:qrscan/styles/overlays.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../main.dart';
import '../../styles/app_colors.dart';

class QrDetails extends StatefulWidget {
  const QrDetails(
      {super.key,
      required this.value,
      required this.dateTime,
      required this.format,
      required this.id,
      required this.color});
  final String value;
  final DateTime dateTime;
  final String format;
  final Color color;
  final int id;
  @override
  State<QrDetails> createState() => _QrDetailsState();
}

class _QrDetailsState extends State<QrDetails> {
  BannerAd? resultBanner;
  BannerAd? topResultBanner;
  @override
  void initState() {
    resultBanner = BannerAd(
        size: AdSize.largeBanner,
        adUnitId: 'ca-app-pub-8262174744018997/5170431975',
        listener: BannerAdListener(
          onAdFailedToLoad: (ad, error) {
            print(error);
          },
        ),
        request: AdRequest());
    topResultBanner = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-8262174744018997/4967321805',
        listener: BannerAdListener(
          onAdFailedToLoad: (ad, error) {
            print(error);
          },
        ),
        request: AdRequest());
    resultBanner!.load();

    topResultBanner!.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(
      ad: resultBanner!,
    );

    final Container adContainer = Container(
      child: adWidget,
      width: resultBanner!.size.width.toDouble(),
      height: resultBanner!.size.height.toDouble(),
    );

    final AdWidget topAdWidget = AdWidget(
      ad: topResultBanner!,
    );

    final Container topAdContainer = Container(
      child: topAdWidget,
      width: topResultBanner!.size.width.toDouble(),
      height: topResultBanner!.size.height.toDouble(),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: AppColors.transparent),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.dark,
          ),
          onPressed: () {
            Get.back(result: false);
          },
        ),
        title: Text(
          'Details',
          style: soraSemibold.copyWith(fontSize: 20, color: AppColors.dark),
        ),
        elevation: 0,
        actions: [
          widget.id == 0
              ? SizedBox()
              : InkWell(
                  onTap: () {
                    Get.back(result: true);
                  },
                  child: SvgPicture.asset(
                    'assets/images/delete.svg',
                    // ignore: deprecated_member_use
                    color: AppColors.dark,
                    height: 20,
                  ),
                ).marginOnly(right: 20),
        ],
        backgroundColor: AppColors.white,
      ),
      body: LayoutBuilder(builder: (context, size) {
        return ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    height: 180,
                    width: 180,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: SfBarcodeGenerator(
                      value: widget.value,
                      symbology: QRCode(),
                      barColor: AppColors.dark,
                    ),
                  ),
                ).marginOnly(bottom: 12),
                SelectableText(widget.value,
                        style: soraSemibold.copyWith(
                            fontSize: 14, color: AppColors.dark))
                    .marginSymmetric(horizontal: 20)
              ],
            ).marginOnly(top: 20, bottom: 20),
            topAdContainer,
            Container(
              margin: EdgeInsets.all(24),
              decoration: BoxDecoration(
                  color: AppColors.lightBg,
                  borderRadius: BorderRadius.circular(16)),
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Date: ',
                        style: soraMedium.copyWith(
                            fontSize: 16,
                            color: AppColors.dark.withOpacity(.7))),
                    TextSpan(
                        text: DateFormat('dd.MM.yyyy').format(widget.dateTime),
                        style: soraSemibold.copyWith(
                            fontSize: 16, color: AppColors.dark))
                  ])).marginOnly(bottom: 12),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Time: ',
                        style: soraMedium.copyWith(
                            fontSize: 16,
                            color: AppColors.dark.withOpacity(.7))),
                    TextSpan(
                        text: DateFormat('hh:mm a').format(widget.dateTime),
                        style: soraSemibold.copyWith(
                            fontSize: 16, color: AppColors.dark))
                  ])).marginOnly(bottom: 12),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Code Type: ',
                        style: soraMedium.copyWith(
                            fontSize: 16,
                            color: AppColors.dark.withOpacity(.7))),
                    TextSpan(
                        text: widget.format,
                        style: soraSemibold.copyWith(
                            fontSize: 16, color: AppColors.dark))
                  ])).marginOnly(bottom: 12),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Value: ',
                        style: soraMedium.copyWith(
                            fontSize: 16,
                            color: AppColors.dark.withOpacity(.7))),
                    TextSpan(
                        text: widget.value,
                        style: soraSemibold.copyWith(
                            fontSize: 16, color: AppColors.dark))
                  ])),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    if (widget.value.toString().isURL) {
                      openUrl(url: Uri.parse(widget.value.toString()));
                    } else {
                      openUrl(
                          url: Uri.parse(
                              'https://www.google.co.in/search?q=${widget.value.toString()}'));
                    }
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/search.svg',
                        // ignore: deprecated_member_use
                        color: AppColors.dark,
                        height: 24,
                      ).marginOnly(bottom: 8),
                      Text(
                        widget.value.toString().isURL
                            ? 'Open URL'
                            : 'Web Search',
                        style: soraSemibold.copyWith(
                            fontSize: 12, color: AppColors.dark),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    FlutterClipboard.copy(widget.value.toString()).then(
                      (value) => Get.showSnackbar(showSnackbar(
                          snackbarStatus: MySnackbarStatus.success,
                          title: 'Copied Successfully!!',
                          msg: widget.value,
                          milliseconds: 2000)),
                    );
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/copy.svg',
                        // ignore: deprecated_member_use
                        color: AppColors.dark,
                        height: 24,
                      ).marginOnly(bottom: 8),
                      Text(
                        'Copy',
                        style: soraSemibold.copyWith(
                            fontSize: 12, color: AppColors.dark),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/share.svg',
                      // ignore: deprecated_member_use
                      color: AppColors.dark,
                      height: 24,
                    ).marginOnly(bottom: 8),
                    Text(
                      'Share',
                      style: soraSemibold.copyWith(
                          fontSize: 12, color: AppColors.dark),
                    )
                  ],
                ),
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/download.svg',
                      // ignore: deprecated_member_use
                      color: AppColors.dark,
                      height: 24,
                    ).marginOnly(bottom: 8),
                    Text(
                      'Save',
                      style: soraSemibold.copyWith(
                          fontSize: 12, color: AppColors.dark),
                    )
                  ],
                ),
              ],
            ).marginOnly(bottom: 24),
            adContainer.marginOnly(bottom: 20)
          ],
        );
      }),
    );
  }
}
