// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:anisearch2/api/repositories/anime_provider.dart';
import 'package:anisearch2/api/repositories/manga_provider.dart';

class Root {
  BuildContext? context;
  String? sort;
  dynamic type;
  bool? popula;
  Root({
    this.context,
    this.sort,
    this.type,
    this.popula,
  });
}

class HomepageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // late ScrollController scrollController;
  RxInt page = 1.obs;

  RxBool manga = false.obs;

  // final controller = StreamController.broadcast();

  late Stream<Root> onload;

  late StreamController<Root> streamController;

  void loadMore(
    BuildContext context,
    String sort,
    dynamic type,
    bool popula,
  ) async {
    page.value += 1;
    if (type == 'MANGA') {
      load.value = true;
      await Provider.of<MangaProvider>(context, listen: false).getMore(
        popula: popula,
        sort: [sort],
        perPage: 25,
        page: page.value,
        type: type!,
      );
      load.value = false;
    } else {
      load.value = true;
      await Provider.of<AnimeProvider>(context, listen: false).getMore(
        popula: popula,
        sort: [sort],
        perPage: 25,
        page: page.value,
        type: type!,
      );
      load.value = false;
    }
    update([20]);
  }

  RxInt length = 0.obs;

  RxBool load = false.obs;

  late TabController tabcontroller;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void onInit() {
    streamController = StreamController.broadcast();
    onload = streamController.stream;
    onload.listen(
      (event) {
        loadMore(event.context!, event.sort!, event.type, event.popula!);
      },
    );

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
    streamController.close();
    super.onClose();
  }
}
