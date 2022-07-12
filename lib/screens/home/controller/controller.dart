// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
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

  late MangaandAnimeRepository mangaRepository;

  late MangaandAnimeRepository animeRepository;

  RxInt selectedIndex = 0.obs;

  final transitionDuration = const Duration(milliseconds: 750);

  RxInt cardindex = 0.obs;

  RxString sort = "TRENDING_DESC".obs;

  RxString type = 'MANGA'.obs;

  RxBool manga = true.obs;

  late ScrollController scrollController;

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

    scrollController = ScrollController();

    super.onInit();
  }

  @override
  void onClose() {
    mangaRepository.dispose();
    animeRepository.dispose();
    scrollController.dispose();
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
    } else if (index == 1) {
      gridDelegate = const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 15,
        mainAxisExtent: 320,
      );
      gridview.value = false;
      listview.value = false;
    } else {
      listview.value = true;
    }
  }
}
