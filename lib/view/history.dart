import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:qrscan/main.dart';
import 'package:get/get.dart';
import 'package:qrscan/view/details.dart';
import '../styles/app_colors.dart';

class History extends StatefulWidget {
  const History({
    Key? key,
  }) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  RxInt page = 0.obs;
  @override
  void initState() {
    // readAllScans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          'History',
          style: nunitoTextStyle.copyWith(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
          future: myDatabase.rawQuery('SELECT * FROM AllScans'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: TextStyle(fontSize: 18),
                  ),
                );

                // if we got our data
              } else if (snapshot.hasData && snapshot.data != null) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      final DateTime now = DateTime.now();
                      Get.to(
                          () => QrDetailsPage(
                                codeFormat: snapshot.data![index]['codeFormat']
                                    .toString(),
                                result:
                                    snapshot.data![index]['result'].toString(),
                                type: snapshot.data![index]['type'].toString(),
                                dateTime: now,
                              ),
                          transition: Transition.rightToLeft);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(.1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            snapshot.data![index]['result'].toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: nunitoTextStyle.copyWith(
                                fontSize: 16,
                                color: AppColors.dark,
                                fontWeight: FontWeight.w600),
                          ).marginOnly(bottom: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('dd-MMM-yyyy, hh:mm a').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        int.parse(snapshot.data![index]
                                                ['scannedOn']
                                            .toString()))),
                                maxLines: 1,
                                style: nunitoTextStyle.copyWith(
                                    fontSize: 14,
                                    color: AppColors.mediumDark,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                snapshot.data![index]['codeFormat']
                                    .toString()
                                    .toUpperCase(),
                                maxLines: 1,
                                style: nunitoTextStyle.copyWith(
                                    fontSize: 14,
                                    color: AppColors.mediumDark,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ).marginOnly(bottom: 8),
                  ),
                  itemCount: snapshot.data!.length,
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
