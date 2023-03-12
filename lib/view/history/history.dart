import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:qrscan/main.dart';
import 'package:qrscan/styles/app_colors.dart';
import 'package:qrscan/view/history/history_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qrscan/view/history/qr_details.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

Future<Widget> getHistoryAdBanner({
  required BuildContext context,
}) async {
  bool isAdLoaded = false;
  final _listAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-8262174744018997/2244336999',
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, error) {
          print(error);
        },
      ),
      request: AdRequest());
  if (!isAdLoaded) {
    await _listAd.load();
    isAdLoaded = true;
  }

  return AdWidget(
    ad: _listAd,
    key: Key(_listAd.hashCode.toString()),
  );
}

class HistoryPage extends StatefulWidget {
  HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final HistoryController historyController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: AppColors.transparent),
        title: Text(
          'History',
          style: soraSemibold.copyWith(fontSize: 24, color: AppColors.dark),
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: myDatabase.rawQuery('SELECT * FROM AllScans'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occurred',
                          style: soraMedium.copyWith(
                              fontSize: 14, color: AppColors.dark),
                        ),
                      );

                      // if we got our data
                    } else if (snapshot.hasData && snapshot.data != null) {
                      RxList<Map<DateTime, List<dynamic>>> newData =
                          <Map<DateTime, List<dynamic>>>[].obs;

                      var groupByDate = groupBy(snapshot.data!,
                          (obj) => obj['dateTime'].toString().substring(0, 10));
                      groupByDate.forEach((date, list) {
                        newData.add({
                          DateTime(
                              int.parse(
                                date.substring(0, 4),
                              ),
                              int.parse(
                                date.substring(5, 7),
                              ),
                              int.parse(
                                date.substring(8, 10),
                              ),
                              0,
                              0,
                              0,
                              0,
                              0): list
                        });
                      });

                      groupByDate.forEach((date, list) {
                        newData.add({
                          DateTime(
                              int.parse(
                                date.substring(0, 4),
                              ),
                              int.parse(
                                date.substring(5, 7),
                              ),
                              int.parse(
                                date.substring(8, 10),
                              ),
                              0,
                              0,
                              0,
                              0,
                              0): list
                        });
                      });

                      groupByDate.forEach((date, list) {
                        newData.add({
                          DateTime(
                              int.parse(
                                date.substring(0, 4),
                              ),
                              int.parse(
                                date.substring(5, 7),
                              ),
                              int.parse(
                                date.substring(8, 10),
                              ),
                              0,
                              0,
                              0,
                              0,
                              0): list
                        });
                      });
                      groupByDate.forEach((date, list) {
                        newData.add({
                          DateTime(
                              int.parse(
                                date.substring(0, 4),
                              ),
                              int.parse(
                                date.substring(5, 7),
                              ),
                              int.parse(
                                date.substring(8, 10),
                              ),
                              0,
                              0,
                              0,
                              0,
                              0): list
                        });
                      });
                      groupByDate.forEach((date, list) {
                        newData.add({
                          DateTime(
                              int.parse(
                                date.substring(0, 4),
                              ),
                              int.parse(
                                date.substring(5, 7),
                              ),
                              int.parse(
                                date.substring(8, 10),
                              ),
                              0,
                              0,
                              0,
                              0,
                              0): list
                        });
                      });
                      groupByDate.forEach((date, list) {
                        newData.add({
                          DateTime(
                              int.parse(
                                date.substring(0, 4),
                              ),
                              int.parse(
                                date.substring(5, 7),
                              ),
                              int.parse(
                                date.substring(8, 10),
                              ),
                              0,
                              0,
                              0,
                              0,
                              0): list
                        });
                      });
                      groupByDate.forEach((date, list) {
                        newData.add({
                          DateTime(
                              int.parse(
                                date.substring(0, 4),
                              ),
                              int.parse(
                                date.substring(5, 7),
                              ),
                              int.parse(
                                date.substring(8, 10),
                              ),
                              0,
                              0,
                              0,
                              0,
                              0): list
                        });
                      });
                      groupByDate.forEach((date, list) {
                        newData.add({
                          DateTime(
                              int.parse(
                                date.substring(0, 4),
                              ),
                              int.parse(
                                date.substring(5, 7),
                              ),
                              int.parse(
                                date.substring(8, 10),
                              ),
                              0,
                              0,
                              0,
                              0,
                              0): list
                        });
                      });
                      groupByDate.forEach((date, list) {
                        newData.add({
                          DateTime(
                              int.parse(
                                date.substring(0, 4),
                              ),
                              int.parse(
                                date.substring(5, 7),
                              ),
                              int.parse(
                                date.substring(8, 10),
                              ),
                              0,
                              0,
                              0,
                              0,
                              0): list
                        });
                      });
                      groupByDate.forEach((date, list) {
                        newData.add({
                          DateTime(
                              int.parse(
                                date.substring(0, 4),
                              ),
                              int.parse(
                                date.substring(5, 7),
                              ),
                              int.parse(
                                date.substring(8, 10),
                              ),
                              0,
                              0,
                              0,
                              0,
                              0): list
                        });
                      });
                      groupByDate.forEach((date, list) {
                        newData.add({
                          DateTime(
                              int.parse(
                                date.substring(0, 4),
                              ),
                              int.parse(
                                date.substring(5, 7),
                              ),
                              int.parse(
                                date.substring(8, 10),
                              ),
                              0,
                              0,
                              0,
                              0,
                              0): list
                        });
                      });
                      groupByDate.forEach((date, list) {
                        newData.add({
                          DateTime(
                              int.parse(
                                date.substring(0, 4),
                              ),
                              int.parse(
                                date.substring(5, 7),
                              ),
                              int.parse(
                                date.substring(8, 10),
                              ),
                              0,
                              0,
                              0,
                              0,
                              0): list
                        });
                      });
                      groupByDate.forEach((date, list) {
                        newData.add({
                          DateTime(
                              int.parse(
                                date.substring(0, 4),
                              ),
                              int.parse(
                                date.substring(5, 7),
                              ),
                              int.parse(
                                date.substring(8, 10),
                              ),
                              0,
                              0,
                              0,
                              0,
                              0): list
                        });
                      });
                      groupByDate.forEach((date, list) {
                        newData.add({
                          DateTime(
                              int.parse(
                                date.substring(0, 4),
                              ),
                              int.parse(
                                date.substring(5, 7),
                              ),
                              int.parse(
                                date.substring(8, 10),
                              ),
                              0,
                              0,
                              0,
                              0,
                              0): list
                        });
                      });

                      return Obx(() {
                        return newData.length < 1
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'No History',
                                    style: soraSemibold.copyWith(
                                        fontSize: 20, color: AppColors.dark),
                                  ).marginOnly(bottom: 16),
                                  Text(
                                    'Try changing date of filters.',
                                    style: soraMedium.copyWith(
                                        fontSize: 14,
                                        color: AppColors.dark.withOpacity(.5)),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, oIndex) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('dd MMMM, EEE')
                                          .format(newData[oIndex].keys.first),
                                      style: soraSemibold.copyWith(
                                          color: AppColors.dark, fontSize: 20),
                                    ).marginOnly(left: 20, bottom: 16, top: 16),
                                    Column(
                                      children: List.generate(
                                          newData[oIndex].values.first.length,
                                          (i) => QrHistoryViewComponent(
                                              color: newData[oIndex]
                                                  .values
                                                  .first[i]['colorHxDVal']
                                                  .toString(),
                                              id: int.tryParse(newData[oIndex]
                                                      .values
                                                      .first[i]['id']
                                                      .toString()) ??
                                                  0,
                                              codeFormat: newData[oIndex]
                                                  .values
                                                  .first[i]['codeFormat']
                                                  .toString(),
                                              value: newData[oIndex]
                                                  .values
                                                  .first[i]['result']
                                                  .toString(),
                                              deleter: () async {
                                                await myDatabase
                                                    .transaction((txn) async {
                                                  await txn.rawInsert(
                                                      "DELETE FROM AllScans where id=${int.tryParse(newData[oIndex].values.first[i]['id'].toString()) ?? 0}");
                                                });
                                                setState(() {});
                                              },
                                              dateTime: snapshot.data![oIndex]
                                                      ['dateTime']
                                                  .toString())),
                                    ),
                                  ],
                                ),
                                itemCount: newData.length,
                              );
                      });
                    }
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          FutureBuilder(
              future: getHistoryAdBanner(context: context),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  AdWidget ad = snapshot.data as AdWidget;

                  return Container(
                    height: 50,
                    child: ad,
                  );
                } else {
                  return Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 20),
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(AppColors.primary),
                        // value: 0.8,
                      ));
                }
              }).marginOnly(top: 10)
        ],
      ),
    );
  }
}

class QrHistoryViewComponent extends StatelessWidget {
  const QrHistoryViewComponent(
      {super.key,
      required this.color,
      required this.codeFormat,
      required this.value,
      required this.dateTime,
      required this.deleter,
      required this.id});
  final String color;
  final String codeFormat;
  final String value;
  final String dateTime;
  final int id;
  final dynamic deleter;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final del = await Get.to(
            () => QrDetails(
                  format: codeFormat,
                  value: value,
                  id: id,
                  color: Color(int.parse(color.toString())),
                  dateTime: DateTime.parse(dateTime),
                ),
            transition: Transition.rightToLeft);

        if (del) {
          deleter();
        }
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: AppColors.grey.withOpacity(
                .3,
              ),
              width: 1.3),
        ),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Container(
          padding: EdgeInsets.only(left: 12),
          decoration: BoxDecoration(
            color: Color(int.parse(color)),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                height: 100,
                width: 100,
                child: SfBarcodeGenerator(
                  value: value,
                  symbology: QRCode(),
                ),
              ).marginSymmetric(horizontal: 8),
              SizedBox(
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Code Format: ',
                          style: soraMedium.copyWith(
                              fontSize: 12, color: AppColors.grey)),
                      TextSpan(
                          text: codeFormat.toUpperCase(),
                          style: soraSemibold.copyWith(
                              fontSize: 12, color: AppColors.dark))
                    ])),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Date: ',
                              style: soraMedium.copyWith(
                                  fontSize: 12, color: AppColors.grey)),
                          TextSpan(
                              text: DateFormat('dd.MM.yyyy')
                                  .format(DateTime.parse(dateTime)),
                              style: soraSemibold.copyWith(
                                  fontSize: 12, color: AppColors.dark))
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Value: ',
                            style: soraMedium.copyWith(
                                fontSize: 12, color: AppColors.grey)),
                        Text(
                            value.length <= 14
                                ? value.substring(0, value.length)
                                : value.substring(0, 14) + '...',
                            style: soraSemibold.copyWith(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 12,
                                color: AppColors.dark))
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.dark,
                size: 20,
              ).marginOnly(right: 10)
            ]),
          ),
        ),
      ),
    );
  }
}
