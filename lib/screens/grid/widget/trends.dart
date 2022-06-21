// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:ui' as ui;

import 'package:anisearch2/screens/homePage/controller/controller.dart';
import 'package:anisearch2/screens/grid/hero/hero_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:anisearch2/api/models/api_graphql_media_model.dart';
import 'package:anisearch2/screens/details/hero/hero_row_score.dart';
import 'package:anisearch2/screens/details/hero/hero_title.dart';
import 'package:anisearch2/screens/details/manga_details.dart';
import 'package:anisearch2/screens/grid/controller/controller.dart';
import 'package:anisearch2/screens/grid/widget/dialog.dart';

class Trends extends StatefulWidget {
  const Trends({
    super.key,
    required this.type,
    required this.sort,
    required this.lista,
  });
  final String sort;
  final String type;
  final List<Media>? lista;

  @override
  State<Trends> createState() => _TrendsState();
}

class _TrendsState extends State<Trends> {
  double cardPage = 0.0;
  int cardIndex = 0;

  final _details = ValueNotifier(true);
  late PageController _pageController;

  late StreamController<int> streamController;

  late Stream<int> onload;

  void getData() {
    final controller = Get.find<MangaGridSController>();
    controller.onLoading(context, widget.sort, widget.type, widget.lista!);
    Get.find<HomepageController>().length.value = widget.lista!.length;
  }

  @override
  void initState() {
    streamController = StreamController();

    onload = streamController.stream;
    onload.listen(
      (event) async {
        final controller = Get.find<HomepageController>();
        controller.load.value = true;
        getData();
        await Future.delayed(const Duration(seconds: 2));
        controller.load.value = false;
      },
    );
    _pageController = PageController(viewportFraction: 0.77)
      ..addListener(percentListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageController
      ..removeListener(percentListener)
      ..dispose();
    streamController.close();
    super.dispose();
  }

  percentListener() {
    setState(() {
      cardIndex = _pageController.page!.round();
      cardPage = _pageController.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // final controller1 = Get.find<MangaGridSController>();

          return PageView.builder(
            onPageChanged: (value) {
              if (kDebugMode) {
                print(value + 1);
              }
              if (value + 1 == widget.lista!.length) {
                if (mounted) {
                  streamController.sink.add(value);
                }
              }
            },
            clipBehavior: Clip.none,
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.lista!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final progress = (cardPage - index);
              final scale = ui.lerpDouble(1, .8, progress.abs())!;
              final listaU = widget.lista![index];

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

              // final title = listaU.title!.english ??
              //     listaU.title!.romaji ??
              //     listaU.title!.native ??
              //     '';

              final isCurrentPage = index == cardIndex;
              final isScrolling =
                  _pageController.position.isScrollingNotifier.value;
              final isFirstPage = index == 0;

              // Future<double> averageScore(int? value) {
              //   double calc(int? value) {
              //     return (value ?? 0) / 10;
              //   }

              //   return compute(calc, value);
              // }

              // final averageScore = compute(
              //   calc ,/ 10
              // )

              // ((listaU.averageScore ?? 0) / 10);
              final style = Theme.of(context).textTheme.button!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  );

              return Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Transform.scale(
                  alignment: Alignment.lerp(
                    Alignment.centerLeft,
                    Alignment.center,
                    -progress,
                  ),
                  scale: isScrolling && isFirstPage ? 1 - progress : scale,
                  child: GestureDetector(
                    onTap: () {
                      _details.value = !_details.value;
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
                        _details.value = !_details.value;
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
                                ? constraints.maxHeight
                                : constraints.maxHeight
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
        },
      ),
    );
  }
}
