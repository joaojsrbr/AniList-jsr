import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:ani_search/screens/grid/controller/controller.dart';
import 'package:ani_search/screens/grid/page/manga_gridm_page.dart';
import 'package:ani_search/screens/home/controller/controller.dart';
import 'package:ani_search/screens/home/widget_List/widgets_model_list.dart';

class Homepage extends GetView<HomepageController> {
  const Homepage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    sliverappbar1() {
      return SliverAppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        surfaceTintColor: Theme.of(context).colorScheme.background,
        actions: actions(context, controller.manga),
        floating: true,

      );
    }

    final controllerGrid = Get.find<MangaGridSController>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: false,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      // ),
      // key: controller.scaffoldKey,
      body: NestedScrollView(
        floatHeaderSlivers: true,
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
                        onPressedT: controllerGrid.selectOne,
                        select0: controllerGrid.select0.value,
                        select1: controllerGrid.select1.value,
                        select2: controllerGrid.select2.value,
                        enable: controller.enable.value,
                        onPressed: (index) {
                          controller.pageindexcontroller.sink.add(index);
                        },
                        key: ValueKey(controller.load.value),
                        onload: controller.load.value,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.tabcontroller,
                  children: <Widget>[
                    MangaGridM(
                      type: "MANGA",
                      sort: "TRENDING_DESC",
                      key: const Key('1'),
                      // lista: manga.manga,
                      // lista2: manga.mangap,
                      // pageInfo: manga.pageInfoM,
                    ),
                    MangaGridM(
                      type: "ANIME",
                      key: const Key('2'),
                      sort: "TRENDING_DESC",
                      // lista2: anime.animep,
                      // lista: anime.anime,
                      // pageInfo: anime.pageInfoA,
                    )
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
    required this.enable,
    required this.select0,
    required this.select1,
    required this.select2,
    required this.onPressed,
    this.onPressedT,
    this.height = 25,
    this.width = 25,
    this.value,
  }) : super(key: key);

  final bool onload;
  final double? height;
  final bool enable;
  final void Function(int)? onPressed;
  final double? width;
  final double? value;
  final bool select0;
  final bool select1;
  final bool select2;
  final void Function(int)? onPressedT;

  @override
  Widget build(BuildContext context) {
    final double heightp = (MediaQuery.of(context).size.height * .045);

    const EdgeInsets padding = EdgeInsets.all(3.5);

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
        : enable
            ? Container(
                // width: MediaQuery.of(context).size.width * .26,
                height: 45,
                color: Theme.of(context).buttonTheme.colorScheme?.background,
                child: ToggleButtons(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  onPressed: onPressed,
                  isSelected: const [
                    false,
                    false,
                  ],
                  children: const [
                    Icon(
                      Icons.chevron_left,
                    ),
                    Icon(
                      Icons.chevron_right,
                    ),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // const Text('data'),
                  // const VerticalDivider(
                  //   thickness: 2,
                  //   color: Colors.black,
                  // ),
                  ToggleButtons(
                    constraints: const BoxConstraints(
                      maxHeight: 80,
                      minHeight: 20,
                      maxWidth: 40,
                      minWidth: 20,
                    ),
                    onPressed: onPressedT,
                    borderRadius: BorderRadius.circular(10),
                    isSelected: [
                      select0,
                      select1,
                      select2,
                    ],
                    children: [
                      Container(
                        padding: padding,
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * .045,
                        child: Image.asset(
                          'assets/img/image.png',
                          cacheWidth: 53,
                          cacheHeight: 83,
                        ),
                      ),
                      Container(
                        padding: padding,
                        alignment: Alignment.center,
                        height: heightp,
                        child: Image.asset(
                          'assets/img/image3.png',
                          cacheWidth: 53,
                          cacheHeight: 83,
                        ),
                      ),
                      Container(
                        padding: padding,
                        alignment: Alignment.center,
                        height: heightp,
                        child: Image.asset(
                          'assets/img/image4.png',
                          cacheWidth: 53,
                          cacheHeight: 83,
                        ),
                      ),
                    ],
                  ),
                ],
              );
  }
}
