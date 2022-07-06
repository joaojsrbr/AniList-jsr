// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:ui' as ui;

import 'package:ani_search/screens/home/controller/controller.dart';
import 'package:ani_search/screens/grid/hero/hero_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/screens/details/hero/hero_row_score.dart';
import 'package:ani_search/screens/details/hero/hero_title.dart';
import 'package:ani_search/screens/details/page/details_page.dart';
import 'package:ani_search/screens/grid/widget/dialog.dart';

class Trends extends StatefulWidget {
  Trends({
    super.key,
    required this.type,
    required this.sort,
    required this.lista,
    required this.popula,
    this.streamController,
  });
  final String sort;
  final bool popula;
  final String type;
  final List<Media>? lista;
  StreamController<int>? streamController;

  @override
  State<Trends> createState() => _TrendsState();
}

class _TrendsState extends State<Trends>
    with AutomaticKeepAliveClientMixin<Trends> {
  double cardPage = 0.0;
  int cardIndex = 0;

  final _details = ValueNotifier(true);
  late PageController _pageController;

  // late StreamController<int> streamController;

  // late Stream<int> page;

  // void getData() {
  //   final controller = Get.find<HomepageController>();
  //   controller.loadMore(context, widget.sort, widget.type, widget.popula);
  //   Get.find<HomepageController>().length.value = widget.lista!.length;
  // }

  @override
  bool get wantKeepAlive => true;

  // @override
  // void didUpdateWidget(covariant Trends oldWidget) {
  //   if (oldWidget.streamController!.isClosed &&
  //       widget.streamController != null) {
  //     print('1');
  //   }
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  void initState() {
    // streamController = StreamController();

    // if (_pageController.page!.toInt() == 1) {
    //   Get.find<HomepageController>().enable.value = false;
    // }

    // if (widget.streamController != null) {
    // Get.find<HomepageController>().pageindexcontroller =
    //     StreamController.broadcast();

    // widget.streamController = StreamController.broadcast();

    // page = widget.streamController!.stream;

    //   page.listen((event) {
    //     // print(event);
    //     if (event == 1) {
    //       _pageController.nextPage(
    //           duration: const Duration(milliseconds: 500), curve: Curves.ease);
    //       percentListener();
    //     } else {
    //       _pageController.previousPage(
    //           duration: const Duration(milliseconds: 500), curve: Curves.ease);
    //       percentListener();
    //     }
    //   });
    // }

    // onload = streamController.stream;
    // onload.listen(
    //   (event) async {
    //     final controller = Get.find<HomepageController>();
    //     controller.load.value = true;
    //     getData();
    //     await Future.delayed(const Duration(seconds: 2));
    //     controller.load.value = false;
    //   },
    // );
    _pageController = PageController(viewportFraction: 0.77)
      ..addListener(percentListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageController
      // = PageController(viewportFraction: 0.77)
      ..removeListener(percentListener)
      ..dispose();
    // if (Get.find<HomepageController>().enable.value == false) {
    //   if (widget.streamController != null) {
    //     widget.streamController!.close();
    //   }
    // }

    // streamController.close();
    super.dispose();
  }

  bool firstLoad = true;

  percentListener() {
    setState(() {
      cardIndex = _pageController.page!.round();
      cardPage = _pageController.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build;
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // final controller1 = Get.find<MangaGridSController>();

          return PageBuildWidget(
            mounted: mounted,
            pageController: _pageController,
            cardPage: cardPage,
            constraints: constraints,
            lista: widget.lista,
            type: widget.type,
            sort: widget.sort,
            popula: widget.popula,
            cardIndex: cardIndex,
            details: _details,
          );
        },
      ),
    );
  }
}

class PageBuildWidget extends StatelessWidget {
  const PageBuildWidget({
    super.key,
    required this.mounted,
    required this.pageController,
    required this.cardPage,
    required this.popula,
    required this.lista,
    required this.sort,
    required this.type,
    required this.cardIndex,
    required this.constraints,
    required this.details,
  });

  final bool mounted;
  final String sort;
  final bool popula;
  final String type;
  final BoxConstraints constraints;
  final List<Media>? lista;
  final PageController pageController;

  final double cardPage;

  final int cardIndex;
  final ValueNotifier<bool> details;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: (value) {
        debugPrint(
            'title: ${lista![value].title!.english ?? lista![value].title!.romaji ?? lista![value].title!.native} -- popula: $popula -- ${value + 1}');

        // if (value + 1 >= 5) {
        //   Get.find<HomepageController>().enable.value = true;
        // } else {
        //   Get.find<HomepageController>().enable.value = false;
        // }

        if (value + 1 == lista!.length) {
          if (mounted) {
            Get.find<HomepageController>().streamController.add(
                  Root(
                    context: context,
                    sort: sort,
                    type: lista!.first.type,
                    // popula: popula,
                  ),
                );
          }
        }
      },
      clipBehavior: Clip.none,
      // key: PageStorageKey(PageStorage.of(context)?.readState(context)),
      controller: pageController,
      physics: const BouncingScrollPhysics(),
      itemCount: lista!.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final progress = (cardPage - index);
        final scale = ui.lerpDouble(1, .8, progress.abs())!;
        final listaU = lista![index];

        String _url() {
          final urlA = listaU.coverImage!.extraLarge ??
              listaU.coverImage!.large ??
              listaU.coverImage!.medium ??
              'https://convertingcolors.com/plain-1E2436.svg';

          // final urlB = listaU.bannerImage ??
          //     listaU.coverImage!.extraLarge ??
          //     listaU.coverImage!.large ??
          //     listaU.coverImage!.medium ??
          //     'https://convertingcolors.com/plain-1E2436.svg';
          return GetPlatform.isWeb
              ? (MediaQuery.of(context).size.height >= 900)
                  ? urlA
                  : urlA
              : urlA;
        }

        final isCurrentPage = index == cardIndex;
        final isScrolling = pageController.position.isScrollingNotifier.value;
        final isFirstPage = index == 0;

        final style = Theme.of(context).textTheme.button!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            );

        return Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, bottom: 5),
          child: Transform.scale(
            alignment: Alignment.lerp(
              Alignment.centerLeft,
              Alignment.center,
              -progress,
            ),
            scale: isScrolling && isFirstPage ? 1 - progress : scale,
            child: GestureDetector(
              onTap: () {
                details.value = !details.value;
                const transitionDuration = Duration(milliseconds: 600);
                Navigator.of(context).push(
                  PageRouteBuilder(
                    settings: RouteSettings(
                      arguments: listaU,
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
                Future.delayed(transitionDuration, () {
                  details.value = !details.value;
                });
              },
              child: Padding(
                padding: EdgeInsets.all(
                  (GetPlatform.isWeb) ? 10 : 2,
                ),
                child: SizedBox(
                  width: (GetPlatform.isWeb)
                      ? (MediaQuery.of(context).size.height >= 900)
                          // ? constraints.maxWidth * .055
                          ? constraints.maxWidth
                          : constraints.maxWidth * .355
                      : constraints.maxWidth * .020,
                  height: (GetPlatform.isWeb)
                      ? (MediaQuery.of(context).size.height >= 900)
                          ? constraints.maxHeight * .2
                          : constraints.maxHeight * .2
                      : constraints.maxHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      HeroImageGrid(
                        constraints: constraints,
                        url: _url,
                        isCurrentPage: isCurrentPage,
                        listaU: listaU,
                        style: style,
                      ),
                      SizedBox(height: (GetPlatform.isWeb) ? 5 : 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Material(
                              type: MaterialType.transparency,
                              child: HeroTitle(
                                media: listaU,
                                maxLines: 1,
                              ),
                            ),
                          ),
                          ClipOval(
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => dialog(
                                    context,
                                    constraints,
                                    listaU,
                                  ),
                                );
                              },
                              child: const SizedBox(
                                width: 19,
                                height: 19,
                                child: Center(
                                  child: Icon(
                                    Icons.question_mark,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: HeroRowScore(
                          dataProvider: listaU,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
