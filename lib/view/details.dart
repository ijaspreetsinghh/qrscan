import 'package:clipboard/clipboard.dart';
import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrscan/main.dart';
import 'package:qrscan/styles/app_colors.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class QrDetailsPage extends StatefulWidget {
  const QrDetailsPage({
    super.key,
    required this.barcode,
    required this.dateTime,
  });
  final Barcode barcode;
  final DateTime dateTime;

  @override
  State<QrDetailsPage> createState() => _QrDetailsPageState();
}

class _QrDetailsPageState extends State<QrDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          'Results',
          style: nunitoTextStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
      ),
      backgroundColor: AppColors.primary,
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            children: [
              Row(
                children: [
                  Text(
                    'Type: ',
                    style: nunitoTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.mediumDark),
                  ),
                  Text(
                    widget.barcode.type.name.capitalizeFirst.toString(),
                    style: nunitoTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.dark),
                  ),
                ],
              ).marginOnly(bottom: 8),
              Row(
                children: [
                  Text(
                    'Scanned on : ',
                    style: nunitoTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.mediumDark),
                  ),
                  Text(
                    DateFormat('dd-MMM-yyyy, hh:mm a').format(widget.dateTime),
                    style: nunitoTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.dark),
                  ),
                ],
              ).marginOnly(bottom: 8),
              Row(
                children: [
                  Text(
                    'Code Format : ',
                    style: nunitoTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.mediumDark),
                  ),
                  Text(
                    widget.barcode.format.name.toUpperCase(),
                    style: nunitoTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.dark),
                  ),
                ],
              ).marginOnly(bottom: 8),
              Row(
                children: [
                  Text(
                    'Scanned Result : ',
                    style: nunitoTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.mediumDark),
                  ),
                ],
              ).marginOnly(bottom: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primary.withOpacity(.1),
                ),
                child: SelectableText(
                  widget.barcode.rawValue.toString(),
                  style: nunitoTextStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: AppColors.dark),
                ),
              ).marginOnly(bottom: 16),
              LayoutBuilder(builder: (context, rowSize) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: widget.barcode.rawValue.toString().isURL
                          ? InkWell(
                              onTap: () {
                                openUrl(
                                    url: Uri.parse(
                                        widget.barcode.rawValue.toString()));
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.language_rounded,
                                    size: 42,
                                    color: AppColors.primary,
                                  ),
                                  Text(
                                    'Open URL',
                                    style: nunitoTextStyle.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: AppColors.dark),
                                  ),
                                ],
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                openUrl(
                                    url: Uri.parse(
                                        'https://www.google.co.in/search?q=${widget.barcode.rawValue.toString()}'));
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.search_rounded,
                                    size: 42,
                                    color: AppColors.primary,
                                  ),
                                  Text(
                                    'Web Search',
                                    style: nunitoTextStyle.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: AppColors.dark),
                                  ),
                                ],
                              ),
                            ),
                    ).marginOnly(right: 24),
                    InkWell(
                      onTap: () {
                        Share.share(widget.barcode.rawValue.toString());
                      },
                      child: Column(
                        children: [
                          const Icon(
                            Icons.share_rounded,
                            size: 42,
                            color: AppColors.primary,
                          ),
                          Text(
                            'Share',
                            style: nunitoTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: AppColors.dark),
                          ),
                        ],
                      ).marginOnly(right: 24),
                    ),
                    InkWell(
                      onTap: () {
                        FlutterClipboard.copy(
                                widget.barcode.rawValue.toString())
                            .then(
                          (value) => Get.showSnackbar(
                            GetSnackBar(
                              messageText: Text(
                                'Copied Successfully!!',
                                style: nunitoTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white),
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          const Icon(
                            Icons.copy_rounded,
                            size: 42,
                            color: AppColors.primary,
                          ),
                          Text(
                            'Copy',
                            style: nunitoTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: AppColors.dark),
                          ),
                        ],
                      ).marginOnly(right: 24),
                    )
                  ],
                );
              }),
              FacebookBannerAd(
                placementId: "467441950932019_554989958843884",
                bannerSize: BannerSize.LARGE,
                keepAlive: true,
                listener: (result, value) {
                  switch (result) {
                    case BannerAdResult.ERROR:
                      debugPrint("Error: $value");
                      break;
                    case BannerAdResult.LOADED:
                      debugPrint("Loaded: $value");
                      break;
                    case BannerAdResult.CLICKED:
                      debugPrint("Clicked: $value");
                      break;
                    case BannerAdResult.LOGGING_IMPRESSION:
                      debugPrint("Logging Impression: $value");
                      break;
                  }
                },
              )
            ]),
      ),
    );
  }
}