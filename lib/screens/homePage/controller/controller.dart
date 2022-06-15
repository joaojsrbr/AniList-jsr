import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomepageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late ScrollController scrollController;

  RxBool manga = false.obs;

  RxInt index = 0.obs;

  late TabController tabcontroller;

  @override
  void onInit() {
    tabcontroller = TabController(
      initialIndex: index.value,
      length: 2,
      animationDuration: const Duration(milliseconds: 500),
      vsync: this,
    );
    scrollController = ScrollController();

    super.onInit();
  }

  void onchange(int value) {
    if (kDebugMode) {
      print(value);
    }

    if (value == 0) {
      index.value = value;

      tabcontroller.index = index.value;

      manga.value = true;
    } else {
      index.value = value;
      tabcontroller.index = index.value;

      manga.value = false;
    }
  }

  @override
  void onClose() {
    tabcontroller.dispose();
    scrollController.dispose();

    super.onClose();
  }
}
