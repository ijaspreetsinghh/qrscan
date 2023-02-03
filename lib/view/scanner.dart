import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrscan/styles/app_colors.dart';
import 'package:get/get.dart';
import 'package:qrscan/view/details.dart';

class QrScanner extends StatelessWidget {
  final isScanning = true.obs;

  @override
  Widget build(BuildContext context) {
    final MobileScannerController mobileScannerController =
        MobileScannerController();
    return LayoutBuilder(builder: (context, size) {
      return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: size.maxHeight,
                      // width: 250,
                      child: MobileScanner(
                        controller: mobileScannerController,
                        allowDuplicates: true,
                        onDetect: (barcode, args) {
                          if (barcode.rawValue != null) {
                            // final String code = barcode.rawValue!;
                            mobileScannerController.stop();
                            isScanning.value = false;
                            Get.to(
                                () => QrDetailsPage(
                                      barcode: barcode,
                                      dateTime: DateTime.now(),
                                    ),
                                transition: Transition.rightToLeft);
                          }
                        },
                      )),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              Obx(
                () => isScanning.value
                    ? const SizedBox()
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Scanning Pause',
                                style: nunitoTextStyle.copyWith(
                                    fontSize: 24, color: AppColors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Press',
                                style: nunitoTextStyle.copyWith(
                                    fontSize: 14, color: AppColors.white),
                              ),
                              const Icon(
                                Icons.play_arrow_rounded,
                                color: AppColors.white,
                              ),
                              Text(
                                ' button to start scanning.',
                                style: nunitoTextStyle.copyWith(
                                    fontSize: 14, color: AppColors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                      color: Colors.white,
                      icon: Obx(() => isScanning.value
                          ? const Icon(Icons.pause_rounded,
                              color: AppColors.grey)
                          : const Icon(Icons.play_arrow_rounded,
                              color: AppColors.primary)),
                      iconSize: 24.0,
                      onPressed: () {
                        isScanning.toggle();

                        if (isScanning.value) {
                          mobileScannerController.start();
                        } else {
                          mobileScannerController.stop();
                        }
                      },
                    ),
                  ).marginOnly(bottom: 24),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                      color: Colors.white,
                      icon: ValueListenableBuilder(
                        valueListenable: mobileScannerController.torchState,
                        builder: (context, state, child) {
                          switch (state) {
                            case TorchState.off:
                              return const Icon(Icons.flashlight_off_rounded,
                                  color: AppColors.grey);
                            case TorchState.on:
                              return const Icon(Icons.flashlight_on_rounded,
                                  color: AppColors.primary);
                          }
                        },
                      ),
                      iconSize: 24.0,
                      onPressed: () => mobileScannerController.toggleTorch(),
                    ),
                  ).marginOnly(bottom: 24),
                ],
              ),
            ],
          ),
        ],
      );
    });
  }
}
