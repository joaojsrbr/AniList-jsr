import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

class HomepageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // late ScrollController scrollController;

  RxBool manga = false.obs;

  RxInt length = 0.obs;

  RxBool load = false.obs;

  late TabController tabcontroller;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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

  // double? count() {
  //   Iterable<int> range(int low, int high) sync* {
  //     for (int i = low; i < high; ++i) {
  //       yield i;
  //     }
  //   }

  //   for (var i in range(0, 100)) {
  //     return i.toDouble();
  //   }
  // }
}
