import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomepageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // late ScrollController scrollController;

  RxBool manga = false.obs;

  late TabController tabcontroller;

  @override
  void onInit() {
    const duration = Duration(milliseconds: 0);
    tabcontroller = TabController(
      animationDuration: duration,
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    // scrollController = ScrollController();

    super.onInit();
  }

  @override
  void onClose() {
    tabcontroller.dispose();
    // scrollController.dispose();

    super.onClose();
  }
}
