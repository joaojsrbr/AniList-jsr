// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'dart:async';

import 'package:ani_search/api/repositories/manga_and_anime_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root {
  BuildContext? context;
  String? sort;
  dynamic type;

  Root({
    this.context,
    this.sort,
    this.type,
  });
}

class HomepageController extends GetxController {
  RxInt page = 1.obs;

  late StreamController<int> pageindexcontroller;

  // late MangaandAnimeRepository mangaandAnimeRepository;

  late MangaandAnimeRepository mangaRepository;

  late MangaandAnimeRepository animeRepository;

  RxInt selectedIndex = 0.obs;

  // RxDouble tempDouble = 0.0.obs;

  final transitionDuration = const Duration(milliseconds: 750);

  RxInt cardindex = 0.obs;

  RxString sort = "TRENDING_DESC".obs;

  RxString type = 'MANGA'.obs;

  RxBool enable = false.obs;

  RxBool manga = true.obs;

  late ScrollController scrollController;

  late Stream<Root> onload;

  RxInt length = 0.obs;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    mangaRepository = MangaandAnimeRepository(
      manga: true,
      type: 'MANGA',
      sorts: "TRENDING_DESC",
      perPage: 25,
      page: 0,
    );
    animeRepository = MangaandAnimeRepository(
      manga: true,
      type: 'ANIME',
      sorts: "TRENDING_DESC",
      perPage: 25,
      page: 0,
    );
    // streamController = StreamController.broadcast();
    // onload = streamController.stream;
    // onload.listen(
    //   (event) async {
    //     await loadMore(
    //       event.context!,
    //       event.sort!,
    //       event.type,
    //       // event.popula!,
    //     );
    //   },
    // );

    scrollController = ScrollController();

    super.onInit();
  }

  // void _scrollListener() {
  //   if (scrollController.position.pixels ==
  //       scrollController.position.maxScrollExtent) {
  //     loadmore(
  //       Get.context!,
  //       sort.value,
  //       type.value,
  //     );
  //   }
  // }

  @override
  void onClose() {
    // scrollController.dispose();
    mangaRepository.dispose();
    animeRepository.dispose();
    scrollController.dispose();

    pageindexcontroller.close();
    super.onClose();
  }

  void onTabchange(int value) async {
    if (value == 0) {
      scrollController.jumpTo(0.0);
      manga.value = true;
      type.value = "MANGA";
      // mangaandAnimeRepository = MangaandAnimeRepository(
      //   manga: manga.value,
      //   type: type.value,
      //   sorts: sort.value,
      //   perPage: 25,
      //   page: 0,
      // );
      // await mangaRepository.refresh();
      selectedIndex.value = 0;
      update([28]);
    } else {
      scrollController.jumpTo(0.0);
      manga.value = false;
      type.value = "ANIME";
      // mangaandAnimeRepository = MangaandAnimeRepository(
      //   manga: manga.value,
      //   type: type.value,
      //   sorts: sort.value,
      //   perPage: 25,
      //   page: 0,
      // );
      // await animeRepository.refresh();
      selectedIndex.value = 1;
      update([28]);
    }
  }

  GlobalKey<State> key = GlobalKey();

  SliverGridDelegate gridDelegate =
      const SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 340,
    childAspectRatio: 1,
    crossAxisSpacing: 0,
    mainAxisSpacing: 15,
    mainAxisExtent: 300,
  );

  // * GridView.builder
  RxBool gridview = true.obs;

  // * ListView
  RxBool listview = false.obs;

  void selectOne(int index) {
    if (index == 0) {
      gridDelegate = const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 290,
        childAspectRatio: 1,
        crossAxisSpacing: 0,
        mainAxisSpacing: 15,
        mainAxisExtent: 272,
      );
      gridview.value = true;
      listview.value = false;

      update([28]);
    } else if (index == 1) {
      gridDelegate = const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 15,
        mainAxisExtent: 300,
      );
      gridview.value = false;
      listview.value = false;
      update([28]);
    } else {
      listview.value = true;
      // update([28]);
    }
  }
}
