import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscan/styles/app_colors.dart';

enum MySnackbarStatus { success, info, error, warning }

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
