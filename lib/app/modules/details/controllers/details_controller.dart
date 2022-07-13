import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
