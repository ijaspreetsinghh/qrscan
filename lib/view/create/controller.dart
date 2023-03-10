import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateQrController extends GetxController {
  TextEditingController qrText = TextEditingController();
  RxString qrValue = ''.obs;

  Rx<Color> bgColor = Color(0xffff6a6a).obs;
}
