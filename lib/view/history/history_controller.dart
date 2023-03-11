import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  final RxString currentCodeFilter = 'All'.obs;
  TextEditingController searchText = TextEditingController();
  RxString searchVal = ''.obs;
  Rx<DateTime> firstDate = DateTime.now().subtract(Duration(days: 20)).obs;
  Rx<DateTime> lastDate = DateTime.now().obs;
}
