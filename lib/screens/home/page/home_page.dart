// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
// ignore_for_file: unused_element

import 'package:ani_search/screens/home/widget/toggle_button.dart';
import 'package:boxy/boxy.dart';
import 'package:boxy/flex.dart';
import 'package:boxy/slivers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:localization/localization.dart';

import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/screens/details/page/details_page.dart';
import 'package:ani_search/screens/home/controller/controller.dart';
import 'package:ani_search/screens/home/hero/hero_image.dart';
import 'package:ani_search/screens/home/hero/hero_title.dart';
import 'package:ani_search/screens/home/widget_List/widgets_model_list.dart';
import 'package:ani_search/utils/app_colors.dart';

class Homepage extends GetView<HomepageController> {
  const Homepage({
    super.key,
  });

  Key typeScrollableKey(dynamic primaryIndex) =>
      PageStorageKey('${controller.type.value}-$primaryIndex');

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

    // final h = MediaQuery.of(context).size.height;

    // final w = MediaQuery.of(context).size.width;

    // final style = Theme.of(context).textTheme.headline6!.copyWith(
    //       color: Colors.white,
    //     );

    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: background,
      resizeToAvoidBottomInset: false,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      // ),
      // key: controller.scaffoldKey,

      body: SafeArea(
        child: LoadingMoreCustomScrollView(
          controller: controller.scrollController,
          rebuildCustomScrollView: true,
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
                          enable: controller.enable.value,
                          onPressed: (index) {
                            controller.pageindexcontroller.sink.add(index);
                          },
                          key: ValueKey(controller.cardindex.value),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GetBuilder<HomepageController>(
              id: 28,
              builder: (controller) => SliverContainer(
                // margin: const EdgeInsets.all(8),
                bufferExtent: controller.gridview.value ? 4 : 4,
                sliver: LoadingMoreSliverList(
                  key: PageStorageKey(controller.type.value),
                  SliverListConfig<Media>(
                    indicatorBuilder: indicatorBuilder,
                    gridDelegate: controller.gridDelegate,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    itemBuilder: itemBuilder,
                    sourceList: controller.manga.value
                        ? controller.mangaRepository
                        : controller.animeRepository,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget indicatorBuilder(BuildContext context, IndicatorStatus status) {
    Widget _setbackground(
        bool full, Widget widget, double height, BuildContext context) {
      widget = Container(
        width: double.infinity,
        height: height,
        color: AppColors().background(context),
        alignment: Alignment.center,
        child: widget,
      );
      return widget;
    }

    Widget getIndicator(BuildContext context) {
      final ThemeData theme = Theme.of(context);
      return theme.platform == TargetPlatform.iOS
          ? const CupertinoActivityIndicator(
              animating: true,
              radius: 16.0,
            )
          : const CircularProgressIndicator(
              strokeWidth: 2.0,
            );
    }

    bool isSliver = true;
    late Widget widget;
    switch (status) {
      case IndicatorStatus.none:
        widget = Container(height: 0.0);
        if (isSliver) {
          widget = SliverFillRemaining(
            child: widget,
          );
        }
        break;
      case IndicatorStatus.loadingMoreBusying:
        widget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 0.0),
              height: 30.0,
              width: 30.0,
              child: getIndicator(context),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Carregando..."),
            ),
          ],
        );
        widget = _setbackground(false, widget, 50.0, context);
        break;
      case IndicatorStatus.fullScreenBusying:
        widget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getIndicator(context),
          ],
        );
        widget = _setbackground(false, widget, 35.0, context);
        if (isSliver) {
          widget = SliverFillRemaining(
            child: widget,
          );
        }
        break;
      case IndicatorStatus.error:
        widget = const Center(
          child: Icon(
            Icons.error,
          ),
        );
        widget = _setbackground(false, widget, 35.0, context);
        widget = GestureDetector(
          onTap: () {
            controller.manga.value
                ? controller.mangaRepository.errorRefresh()
                : controller.animeRepository.errorRefresh();
          },
          child: widget,
        );
        break;
      case IndicatorStatus.fullScreenError:
        widget = const Center(
          child: Icon(
            Icons.error,
          ),
        );
        widget = _setbackground(true, widget, double.infinity, context);
        widget = GestureDetector(
          onTap: () {
            controller.manga.value
                ? controller.mangaRepository.errorRefresh()
                : controller.animeRepository.errorRefresh();
          },
          child: widget,
        );
        if (isSliver) {
          widget = SliverFillRemaining(
            child: widget,
          );
        }
        break;
      case IndicatorStatus.noMoreLoad:
        widget = const Center(
          child: Text(
            'NoData',
          ),
        );
        if (isSliver) {
          widget = SliverFillRemaining(
            child: widget,
          );
        }
        break;
      case IndicatorStatus.empty:
        widget = const Center(
          child: Text(
            'NoData',
          ),
        );
        if (isSliver) {
          widget = SliverFillRemaining(
            child: widget,
          );
        }
        break;
    }
    return widget;
  }

  Widget itemBuilder(BuildContext context, Media media, int index) {
    final h = MediaQuery.of(context).size.height;

    final w = MediaQuery.of(context).size.width;

    return controller.gridview.value
        ? grid1(
            h,
            w,
            media,
            context,
            index,
          )
        : grid2(
            media,
            context,
            w,
            h,
            index,
          );
  }

  Widget grid2(
      Media media, BuildContext context, double w, double h, int index) {
    final style = Theme.of(context).textTheme.headline6!.copyWith(
          color: Colors.white,
        );

    final publishing = 'Publishing'.i18n();
    return GestureDetector(
      key: typeScrollableKey(index),
      onTap: () {
        Get.to(
          const MangaDetailsR(),
          arguments: media,
          curve: Curves.ease,
          duration: controller.transitionDuration,
          transition: Transition.fade,
        );
      },
      child: BoxyRow(
        children: [
          Dominant(
            child: CustomBoxy(
              delegate: Mybox(),
              children: [
                BoxyId(
                  id: #image,
                  hasData: true,
                  data: Size(w / 2.3, h),
                  child: HeroImage(
                    logo: false,
                    h: h,
                    w: w,
                    dataProvider: media,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            width: w * .5,
            child: BoxyColumn(
              children: [
                Text(
                  '$publishing ${media.startDate!.year}',
                  textAlign: TextAlign.left,
                  style: style.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Text(
                  media.type ?? '',
                  textAlign: TextAlign.left,
                  style: style.copyWith(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                Text(
                  media.description ?? '',
                  maxLines: 12,
                  overflow: TextOverflow.ellipsis,
                  style: style.copyWith(
                    color: Colors.grey[400],
                    fontSize: 13,
                  ),
                ),
                Dominant.expanded(
                  flex: 2,
                  child: Wrap(
                    children: media.genres!
                        .map<Widget>(
                          (e) => Card(
                            child: Text(
                              e,
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                fontSize: 12.5,
                                color: AppColors().primary(context),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget grid1(
      double h, double w, Media media, BuildContext context, int index) {
    return GestureDetector(
      key: typeScrollableKey(index),
      onTap: () {
        Get.to(
          const MangaDetailsR(),
          opaque: true,
          curve: Curves.ease,
          arguments: media,
          duration: controller.transitionDuration,
          transition: Transition.fade,
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

class Mybox extends BoxyDelegate {
  @override
  Size layout() {
    final image = getChild(#image);

    // final main = getChild(#main);
    // final card = getChild(#card);

    final sizei = image.parentData as Size;

    // main.layout(constraints.copyWith(
    //     maxWidth: sizei.width * 2.3, minWidth: sizei.width * 2.3));
    image.layout(
        constraints.copyWith(maxWidth: sizei.width, minWidth: sizei.width));

    // texto.layout(constraints);
    // card.layout(constraints);
    return image.size;
    // return texto.size + Offset(0, card.size.height);
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
    super.key,
    required this.controller,
  });

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
    super.key,
    required this.enable,
    required this.onPressed,
    this.onPressedT,
    this.height = 25,
    this.width = 25,
    this.value,
  });

  final double? height;
  final bool enable;
  final void Function(int)? onPressed;
  final double? width;
  final double? value;
  final void Function(int)? onPressedT;

  @override
  Widget build(BuildContext context) {
    final double heightp = (MediaQuery.of(context).size.height * .045);

    const EdgeInsets padding = EdgeInsets.all(3.5);

    return enable
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
              ToggleButton(
                onPressed: onPressedT,
                normal: false,
                initvalue: 0,
                borderRadius: BorderRadius.circular(10),
                constraints: const BoxConstraints(
                  maxHeight: 80,
                  minHeight: 20,
                  maxWidth: 40,
                  minWidth: 20,
                ),
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
              )

              // ToggleButtons(
              //   constraints: const BoxConstraints(
              //     maxHeight: 80,
              //     minHeight: 20,
              //     maxWidth: 40,
              //     minWidth: 20,
              //   ),
              //   onPressed: onPressedT,
              //   borderRadius: BorderRadius.circular(10),
              //   isSelected: [
              //     select0,
              //     select1,
              //     select2,
              //   ],
              //   children: [
              //     Container(
              //       padding: padding,
              //       alignment: Alignment.center,
              //       height: MediaQuery.of(context).size.height * .045,
              //       child: Image.asset(
              //         'assets/img/image.png',
              //         cacheWidth: 53,
              //         cacheHeight: 83,
              //       ),
              //     ),
              //     Container(
              //       padding: padding,
              //       alignment: Alignment.center,
              //       height: heightp,
              //       child: Image.asset(
              //         'assets/img/image3.png',
              //         cacheWidth: 53,
              //         cacheHeight: 83,
              //       ),
              //     ),
              //     Container(
              //       padding: padding,
              //       alignment: Alignment.center,
              //       height: heightp,
              //       child: Image.asset(
              //         'assets/img/image4.png',
              //         cacheWidth: 53,
              //         cacheHeight: 83,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          );
  }
}
