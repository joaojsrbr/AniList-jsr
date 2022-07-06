import 'package:ani_search/screens/grid/controller/controller.dart';
import 'package:ani_search/screens/grid/page/manga_gridm_page.dart';
import 'package:ani_search/screens/home/controller/controller.dart';
import 'package:ani_search/screens/home/widget_List/widgets_model_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Homepage extends GetView<HomepageController> {
  const Homepage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    sliverappbar1() {
      return Obx(
        () => SliverAppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          actions: actions(context, controller.manga.value),
          floating: true,
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      // ),
      key: controller.scaffoldKey,
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
                      key: const PageStorageKey('1'),
                      // lista: manga.manga,
                      // lista2: manga.mangap,
                      // pageInfo: manga.pageInfoM,
                    ),
                    MangaGridM(
                      type: "ANIME",
                      key: const PageStorageKey('2'),
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
    required this.onPressed,
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

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MangaGridSController>();
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // const Text('data'),
                  // const VerticalDivider(
                  //   thickness: 2,
                  //   color: Colors.black,
                  // ),
                  Obx(
                    () => ToggleButtons(
                      constraints: const BoxConstraints(
                        maxHeight: 80,
                        minHeight: 20,
                        maxWidth: 45,
                        minWidth: 20,
                      ),
                      onPressed: (index) {
                        controller.selectOne(index);
                      },
                      borderRadius: BorderRadius.circular(10),
                      isSelected: [
                        controller.select0.value,
                        controller.select1.value,
                        controller.select2.value,
                      ],
                      children: [
                        Container(
                          padding: padding,
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * .045,
                          child: Image.asset('assets/img/image.png'),
                        ),
                        Container(
                          padding: padding,
                          alignment: Alignment.center,
                          height: heightp,
                          child: Image.asset('assets/img/image3.png'),
                        ),
                        Container(
                          padding: padding,
                          alignment: Alignment.center,
                          height: heightp,
                          child: Image.asset('assets/img/image4.png'),
                        ),
                      ],
                    ),
                  )
                ],
              );
  }
}
