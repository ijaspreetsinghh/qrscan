import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qrscan/main.dart';
import 'package:qrscan/styles/app_colors.dart';
import 'package:qrscan/view/history/history_controller.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});
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
        actions: [
          Container(
            child: Icon(
              Icons.info_outline_rounded,
              color: AppColors.dark,
              size: 24,
            ),
          ).marginOnly(right: 16)
        ],
      ),
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          SizedBox(
            height: 56,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => Obx(() => InkWell(
                    onTap: () {
                      historyController.currentCodeFilter.value =
                          codesSupported[index];
                    },
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      height: 56,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: historyController.currentCodeFilter.value
                                    .toUpperCase() ==
                                codesSupported[index].toUpperCase()
                            ? AppColors.primary
                            : AppColors.lightBg,
                      ),
                      child: Text(
                        codesSupported[index].toUpperCase(),
                        style: soraSemibold.copyWith(
                          fontSize: 14,
                          color: historyController.currentCodeFilter.value
                                      .toUpperCase() ==
                                  codesSupported[index].toUpperCase()
                              ? AppColors.white
                              : AppColors.dark,
                        ),
                      ),
                    ),
                  )),
              itemCount: codesSupported.length,
              scrollDirection: Axis.horizontal,
            ),
          ).marginOnly(bottom: 16, top: 16),
          TextFormField(
            style: soraMedium.copyWith(fontSize: 14, color: AppColors.dark),
            decoration: InputDecoration(
                filled: true,
                // isDense: true,
                hintText: 'Search',
                hintStyle:
                    soraMedium.copyWith(fontSize: 14, color: AppColors.grey),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: AppColors.grey,
                  size: 28,
                ),
                fillColor: AppColors.lightBg,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none)),
          ).marginOnly(bottom: 16, right: 20, left: 20),
          Expanded(
            child: FutureBuilder(
                future: myDatabase
                    .rawQuery('SELECT * FROM AllScans GROUP by scannedOn'),
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
                            // Get.to(
                            //     () => QrDetailsPage(
                            //           codeFormat: snapshot.data![index]['codeFormat']
                            //               .toString(),
                            //           result:
                            //               snapshot.data![index]['result'].toString(),
                            //           type: snapshot.data![index]['type'].toString(),
                            //           dateTime: now,
                            //         ),
                            //     transition: Transition.rightToLeft);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(.1)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  snapshot.data![index]['result'].toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: soraBold.copyWith(
                                      fontSize: 16,
                                      color: AppColors.dark,
                                      fontWeight: FontWeight.w600),
                                ).marginOnly(bottom: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      DateFormat('dd-MMM-yyyy, hh:mm a').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              int.parse(snapshot.data![index]
                                                      ['scannedOn']
                                                  .toString()))),
                                      maxLines: 1,
                                      style: soraBold.copyWith(
                                          fontSize: 14,
                                          color: AppColors.dark,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      snapshot.data![index]['codeFormat']
                                          .toString()
                                          .toUpperCase(),
                                      maxLines: 1,
                                      style: soraBold.copyWith(
                                          fontSize: 14,
                                          color: AppColors.dark,
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
          ),
        ],
      ),
    );
  }
}
