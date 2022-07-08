import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/api/repositories/anime_provider.dart';
import 'package:ani_search/api/repositories/manga_provider.dart';
import 'package:ani_search/screens/details/page/details_page.dart';
import 'package:ani_search/screens/home/hero/hero_image.dart';
import 'package:ani_search/screens/home/hero/hero_title.dart';
import 'package:ani_search/screens/home/widget/live_sliver_p.dart';

import 'package:ani_search/widgetU/consumer_two_value.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
        floating: false,
      );
    }

    final background = Theme.of(context).colorScheme.background;
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: background,
      resizeToAvoidBottomInset: false,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      // ),
      // key: controller.scaffoldKey,

      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          controller: controller.scrollController,
          slivers: [
            sliverappbar1(),
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: DelegatePageHeader(
                maxExtent: 60,
                minExtent: 60,
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  color: background,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _Gnav(
                        controller: controller,
                      ),
                      Obx(
                        () => LoadOn(
                          onPressedT: controller.selectOne,
                          select0: controller.select0.value,
                          select1: controller.select1.value,
                          select2: controller.select2.value,
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
              ),
            ),
            // SliverToBoxAdapter(
            //   child: _Gnav(
            //     controller: controller,
            //   ),
            // ),
            ConsummerPerson<MangaProvider, AnimeProvider>(
              builder: (context, manga, anime, child) {
                return GetBuilder<HomepageController>(
                  id: 28,
                  builder: (controller) => controller.select2.value
                      ? LiveSliverListP<Media>(
                          controller: controller.scrollController,
                          lista: (controller.type.value == 'MANGA')
                              ? manga.manga
                              : anime.anime,
                          key: PageStorageKey(controller.selectedIndex.value),
                          itemBuilder: (context, index, animation, media) {
                            final imageUrl = media.coverImage!.extraLarge ??
                                media.coverImage!.large ??
                                media.coverImage!.medium;
                            final title = media.title!.english ??
                                media.title!.romaji ??
                                media.title!.native;
                            return SizedBox(
                              child: ListTile(
                                onTap: () {
                                  Get.to(
                                    const MangaDetailsR(),
                                    arguments: media,
                                    duration: const Duration(milliseconds: 200),
                                    transition: Transition.size,
                                  );
                                },
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                title: Text(
                                  title!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: const Text('asdasd'),
                                leading: SizedBox(
                                  height: 200,
                                  width: 60,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: imageUrl!,
                                      memCacheWidth: 165,
                                      memCacheHeight: 154,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : LiveSliverGridP<Media>(
                          lista: (controller.type.value == 'MANGA')
                              ? manga.manga
                              : anime.anime,
                          controller: controller.scrollController,
                          reAnimateOnVisibility: true,
                          // itemCount: (controller.type.value == 'MANGA')
                          //     ? manga.manga.length
                          //     : anime.anime.length,

                          key: ObjectKey(controller.type.value),
                          gridDelegate: controller.gridDelegate,
                          itemBuilder: (BuildContext context, int index,
                              animation, media) {
                            return controller.select0.value
                                ? grid1(
                                    h,
                                    w,
                                    media,
                                    context,
                                  )
                                : grid2(
                                    media,
                                    context,
                                    w,
                                    h,
                                  );
                          },
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector grid2(media, BuildContext context, double w, double h) {
    return GestureDetector(
      onTap: () {
        Get.to(
          const MangaDetailsR(),
          arguments: media,
          duration: const Duration(milliseconds: 600),
          transition: Transition.fadeIn,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
            // left: 8.0,
            // right: 8,
            ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Flexible(
                child: SizedBox(
                  width: w / 2.3,
                  child: HeroImage(
                    logo: false,
                    h: h,
                    w: w,
                    dataProvider: media,
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    ListTile(
                      subtitle: Text(
                        media.type ?? '',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector grid1(double h, double w, Media media, BuildContext context) {
    return GestureDetector(
      onTap: () {
        const transitionDuration = Duration(milliseconds: 600);
        Navigator.of(context).push(
          PageRouteBuilder(
            settings: RouteSettings(
              arguments: media,
            ),
            transitionDuration: transitionDuration,
            reverseTransitionDuration: transitionDuration,
            pageBuilder: (_, animation, __) {
              return FadeTransition(
                opacity: animation,
                child: const MangaDetailsR(),
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: HeroImage(
                h: h,
                w: w,
                dataProvider: media,
              ),
            ),
            HeroTitle(
              media: media,
              maxLines: 1,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class DelegatePageHeader extends SliverPersistentHeaderDelegate {
  DelegatePageHeader({
    required this.maxExtent,
    required this.minExtent,
    required this.child,
  });
  final Widget child;
  @override
  final double minExtent;
  @override
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _Gnav extends StatelessWidget {
  const _Gnav({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomepageController controller;

  @override
  Widget build(BuildContext context) {
    return GNav(
      rippleColor: Colors.grey[300]!,
      hoverColor: Colors.grey[100]!,
      gap: 8,
      activeColor: Colors.black,
      iconSize: 20,
      mainAxisAlignment: MainAxisAlignment.start,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      duration: const Duration(milliseconds: 400),
      tabBackgroundColor: Colors.grey[100]!,
      color: Colors.white,
      onTabChange: controller.onTabchange,
      selectedIndex: controller.selectedIndex.value,
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
        ? Container(
            alignment: Alignment.centerLeft,
            height: height,
            width: width,
            child: const CircularProgressIndicator(
              // value: value,
              strokeWidth: 2,
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
