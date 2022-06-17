import 'package:anisearch2/screens/homePage/controller/controller.dart';
import 'package:anisearch2/screens/mangaGrid/manga_gridM.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:provider/provider.dart';
import 'package:anisearch2/api/repositories/manga_anime_provider.dart';
import 'package:anisearch2/screens/homePage/widget_List/widgets_model_list.dart';

import 'package:get/get.dart';

class Homepage extends GetView<HomepageController> {
  const Homepage({
    super.key,
  });

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // late TabController tabcontroller;

  // Future<void> getHomeAnime(
  //     int page, int perPage, List<String> sort, dynamic type) async {
  //   await Provider.of<ApiProvider>(Get.context!, listen: false).getHomeAnime(
  //     sort: sort,
  //     type: type,
  //     page: page,
  //     perPage: perPage,
  //   );
  // }

  // Future<void> getHomeManga(
  //     int page, int perPage, List<String> sort, dynamic type) async {
  //   await Provider.of<ApiProvider>(Get.context!, listen: false).getHomeManga(
  //     sort: sort,
  //     type: type,
  //     page: page,
  //     perPage: perPage,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    sliverappbar1() {
      return Obx(
        () => SliverAppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          // expandedHeight: MediaQuery.of(context).size.height * .20,
          // pinned: true,
          actions: ListWidget().actions(context, controller.manga.value),
          // surfaceTintColor: Theme.of(context).colorScheme.background,
          floating: true,
          stretch: true,
        ),
      );
    }

    final listaManga = Provider.of<ApiProvider>(context).manga;
    final listaAnime = Provider.of<ApiProvider>(context).anime;
    final pageInfoA = Provider.of<ApiProvider>(context).pageInfoA;
    final pageInfoM = Provider.of<ApiProvider>(context).pageInfoM;
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: NestedScrollView(
        controller: controller.scrollController,
        headerSliverBuilder: (context, _) {
          return <Widget>[
            sliverappbar1(),
          ];
        },
        body: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GNav(
                      rippleColor: Colors.grey[300]!,
                      hoverColor: Colors.grey[100]!,
                      gap: 8,
                      activeColor: Colors.black,
                      iconSize: 20,
                      mainAxisAlignment: MainAxisAlignment.start,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      duration: const Duration(milliseconds: 400),
                      tabBackgroundColor: Colors.grey[100]!,
                      color: Colors.white,
                      onTabChange: controller.onchange,
                      selectedIndex: controller.index.value,
                      tabs: const <GButton>[
                        GButton(
                          // icon: LineIcons.home,
                          icon: Icons.book,
                          iconActiveColor: Colors.black,
                          text: 'Manga',
                        ),
                        GButton(
                          // icon: LineIcons.home,
                          icon: Icons.play_circle,
                          iconActiveColor: Colors.black,
                          text: 'Anime',
                        ),
                      ],
                    ),
                    // Flexible(
                    //   child: Obx(
                    //     () {
                    //       return PageViewDotIndicator(
                    //         alignment: Alignment.centerRight,
                    //         currentItem: indexP(
                    //           indexpage.index.value.toInt(),
                    //           controller.manga.value
                    //               ? listaManga.length
                    //               : listaManga.length,
                    //         ).clamp(0, 4),
                    //         count: 4,
                    //         unselectedColor: Colors.black26,
                    //         selectedColor: Colors.blue,
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.tabcontroller,
                  children: [
                    MangaGridM(
                      scrollController: controller.scrollController,
                      type: "MANGA",
                      key: const Key('ListaManga'),
                      sort: "TRENDING_DESC",
                      lista: listaManga,
                      pageInfo: pageInfoM,
                    ),
                    MangaGridM(
                      scrollController: controller.scrollController,
                      type: "ANIME",
                      sort: "TRENDING_DESC",
                      key: const Key('ListaAnime'),
                      lista: listaAnime,
                      pageInfo: pageInfoA,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> labels = [
  'main',
  'main',
  'main',
  'main',
];
