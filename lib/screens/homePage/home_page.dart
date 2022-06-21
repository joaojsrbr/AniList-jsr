// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anisearch2/api/repositories/anime_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import 'package:anisearch2/api/repositories/manga_provider.dart';
import 'package:anisearch2/screens/homePage/controller/controller.dart';
import 'package:anisearch2/screens/homePage/widget_List/widgets_model_list.dart';
import 'package:anisearch2/screens/grid/manga_gridM.dart';

class Homepage extends GetView<HomepageController> {
  const Homepage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    sliverappbar1() {
      return Obx(
        () => SliverAppBar(
          // backgroundColor: Theme.of(context).colorScheme.background,
          // expandedHeight: MediaQuery.of(context).size.height * .20,
          // pinned: true,
          actions: ListWidget().actions(context, controller.manga.value),
          surfaceTintColor: Theme.of(context).colorScheme.background,
          floating: true,
        ),
      );
    }

    // final listaManga = Provider.of<MangaProvider>(context).manga;

    // final listaAnime = Provider.of<ApiProvider>(context).anime;

    // final pageInfoA = Provider.of<ApiProvider>(context).pageInfoA;

    // final pageInfoM = Provider.of<ApiProvider>(context).pageInfoM;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      // ),
      // key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: NestedScrollView(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      onTabChange: (value) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          controller.tabcontroller.index = value;
                          if (value == 0) {
                            controller.manga.value = true;
                          } else {
                            controller.manga.value = false;
                          }
                        });
                      },
                      selectedIndex: controller.tabcontroller.index,
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
                    Obx(
                      () => LoadOn(
                        key: ValueKey(controller.load.value),
                        onload: controller.load.value,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.tabcontroller,
                  children: [
                    Consumer<MangaProvider>(
                      builder: (context, manga, child) {
                        return manga.isLoading
                            ? child!
                            : MangaGridM(
                                type: "MANGA",
                                sort: "TRENDING_DESC",
                                key: const Key('ListaManga'),
                                lista: manga.manga,
                                pageInfo: manga.pageInfoM,
                              );
                      },
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    Consumer<AnimeProvider>(
                      builder: (context, anime, child) {
                        return anime.isLoading
                            ? child!
                            : MangaGridM(
                                type: "ANIME",
                                sort: "TRENDING_DESC",
                                key: const Key('ListaAnime'),
                                lista: anime.anime,
                                pageInfo: anime.pageInfoA,
                              );
                      },
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
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

class LoadOn extends StatelessWidget {
  const LoadOn({
    Key? key,
    required this.onload,
    this.height = 20,
    this.width = 20,
    this.value,
  }) : super(key: key);

  final bool onload;
  final double? height;
  final double? width;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return onload
        ? SizedBox(
            height: height,
            width: width,
            child: const Center(
              child: CircularProgressIndicator(
                // value: value,
                strokeWidth: 2,
              ),
            ),
          )
        : Container();
  }
}
