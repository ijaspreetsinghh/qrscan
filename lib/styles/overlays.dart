import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscan/styles/app_colors.dart';

enum MySnackbarStatus { success, info, error, warning }

showLoader({required String text}) {
  hideLoader();
  Get.dialog(
    useSafeArea: true,
    name: 'Loader',
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(24),
          constraints: const BoxConstraints(
              maxHeight: 250, minHeight: 200, maxWidth: 500, minWidth: 250),
          child: Material(
            color: AppColors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.primary)),
                ).marginOnly(bottom: 24),
                Text(
                  text,
                  style: soraBold.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.dark),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

hideLoader() {
  if (Get.isOverlaysOpen || Get.isDialogOpen! || Get.isSnackbarOpen) {
    Get.back();
    Get.closeAllSnackbars();
  }
}

showSnackbar({
  required MySnackbarStatus snackbarStatus,
  required String title,
  required String msg,
  required int milliseconds,
}) {
  hideLoader();

  Get.snackbar('', '',
      backgroundColor: snackbarStatus == MySnackbarStatus.success
          ? Color(0xff2db67e)
          : snackbarStatus == MySnackbarStatus.error
              ? Color(0xffff6a6a)
              : snackbarStatus == MySnackbarStatus.info
                  ? Color(0xff7250f2)
                  : Color(0xffffb26a),
      titleText: Text(
        title,
        style: soraBold.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      messageText: Text(
        msg,
        style: soraBold.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: AppColors.white.withOpacity(.8),
        ),
      ),
      duration: Duration(milliseconds: milliseconds),
      padding: const EdgeInsets.all(12),
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      forwardAnimationCurve: Curves.ease,
      reverseAnimationCurve: Curves.ease,
      margin: const EdgeInsets.only(top: 20, left: 12, right: 12));
}
