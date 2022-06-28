// ignore_for_file: file_names, must_be_immutable

import 'dart:async';

import 'package:anisearch2/api/models/api_graphql_media_model.dart';
import 'package:anisearch2/screens/details/manga_details.dart';
import 'package:anisearch2/screens/grid/controller/controller.dart';
import 'package:anisearch2/screens/grid/hero/hero_image.dart';
import 'package:anisearch2/screens/home/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MangaGridS extends GetView<MangaGridSController> {
  const MangaGridS({
    super.key,
    this.lista,
    this.main = false,
    this.popula,
    this.sort,
  });
  final bool main;
  final bool? popula;
  final String? sort;
  final List<Media>? lista;

  @override
  Widget build(BuildContext context) {
    final RefreshController refreshController =
        RefreshController(initialRefresh: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: (main == true)
          ? AppBar(
              surfaceTintColor: Theme.of(context).colorScheme.background,
              elevation: 0,
            )
          : null,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (main == true) {
              return GetBuilder<HomepageController>(
                id: 20,
                builder: (controller) => SmartRefresher(
                  enablePullDown: false,
                  enablePullUp: true,
                  semanticChildCount: lista!.length,
                  onLoading: () async {
                    if (lista!.first.type == 'MANGA') {
                      refreshController.requestLoading();

                      controller.streamController.add(
                        Root(
                          context: context,
                          sort: sort!,
                          type: lista!.first.type,
                          popula: popula,
                        ),
                      );
                      Future.delayed(const Duration(seconds: 1));

                      refreshController.loadComplete();
                    } else {
                      refreshController.requestLoading();
                      controller.streamController.add(
                        Root(
                          context: context,
                          sort: sort!,
                          type: lista!.first.type,
                          popula: popula,
                        ),
                      );

                      Future.delayed(const Duration(seconds: 1));
                      refreshController.loadComplete();
                    }
                  },
                  controller: refreshController,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: constraints.maxWidth > 600
                          ? 3
                          : constraints.maxWidth > 200
                              ? 2
                              : 1,
                    ),
                    itemCount: lista!.length,
                    itemBuilder: (context, index) {
                      String _url() {
                        final urlA = lista![index].coverImage!.extraLarge ??
                            lista![index].coverImage!.large ??
                            lista![index].coverImage!.medium ??
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

                      // final imageUrl = lista![index].coverImage!.extraLarge ??
                      //     lista![index].coverImage!.large ??
                      //     lista![index].coverImage!.medium ??
                      //     'https://convertingcolors.com/plain-1E2436.svg';
                      final title = lista![index].title!.english ??
                          lista![index].title!.romaji ??
                          lista![index].title!.native ??
                          '';
                      final style =
                          Theme.of(context).textTheme.button!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              );
                      final averageScore = lista![index].averageScore;
                      final isCurrent = index == index;
                      return GestureDetector(
                        // onTap: () => Get.toNamed(
                        //   '/d',
                        //   arguments: lista![index],
                        // ),
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              settings: RouteSettings(
                                arguments: lista![index],
                              ),
                              transitionDuration:
                                  const Duration(milliseconds: 700),
                              reverseTransitionDuration:
                                  const Duration(milliseconds: 700),
                              pageBuilder: (_, animation, __) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: const MangaDetailsR(),
                                );
                              },
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.blueGrey[900],
                          elevation: 0,
                          child: Column(
                            children: [
                              HeroImageGrid(
                                url: _url,
                                listaU: lista![index],
                                main: true,
                                averageScore: (averageScore ?? 10).toDouble(),
                                constraints: constraints,
                                style: style,
                                isCurrentPage: isCurrent,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 5.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  // child: HeroTitle(
                                  //   maxLines: 1,
                                  //   title: title,
                                  // ),
                                  child: Text(
                                    title,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraints.maxWidth > 600
                    ? 3
                    : constraints.maxWidth > 200
                        ? 2
                        : 1,
              ),
              itemCount: lista!.length,
              itemBuilder: (context, index) {
                // final url = lista![index].coverImage!.extraLarge ??
                //     lista![index].coverImage!.large ??
                //     lista![index].coverImage!.medium ??
                //     '';
                final title = lista![index].title!.english ??
                    lista![index].title!.romaji ??
                    lista![index].title!.native ??
                    '';
                final style = Theme.of(context).textTheme.button!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    );
                final isCurrent = index == index;

                String _url() {
                  final urlA = lista![index].coverImage!.extraLarge ??
                      lista![index].coverImage!.large ??
                      lista![index].coverImage!.medium ??
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

                final averageScore = lista![index].averageScore;
                // print(constraints.maxHeight * .2);

                return GestureDetector(
                  // onTap: () => Get.toNamed(
                  //   '/d',
                  //   arguments: lista![index],
                  // ),
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        settings: RouteSettings(
                          arguments: lista![index],
                        ),
                        transitionDuration: const Duration(milliseconds: 200),
                        reverseTransitionDuration:
                            const Duration(milliseconds: 200),
                        pageBuilder: (_, animation, __) {
                          return FadeTransition(
                            opacity: animation,
                            child: const MangaDetailsR(),
                          );
                        },
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.blueGrey[900],
                    elevation: 0,
                    child: Column(
                      children: [
                        HeroImageGrid(
                          url: _url,
                          listaU: lista![index],
                          constraints: constraints,
                          style: style,
                          main: true,
                          averageScore: (averageScore ?? 0).toDouble(),
                          isCurrentPage: isCurrent,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CardScore extends StatelessWidget {
  const CardScore({
    Key? key,
    this.averageScore,
    required this.style,
    required this.media,
  }) : super(key: key);

  final Media media;
  final dynamic averageScore;

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return CardS(
      // height: 30.49,
      // width: 30.27,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomRight: Radius.circular(7.5),
      ),
      image: false,
      widget: (averageScore == null)
          ? null
          : Text(
              '$averageScore',
              style: style.copyWith(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
    );
  }
}

class CardS extends StatelessWidget {
  final Alignment alignment;
  final bool image;
  final double height;
  final double width;
  final Widget? widget;
  final BorderRadiusGeometry? borderRadius;
  const CardS({
    this.widget,
    this.image = true,
    this.height = 35,
    this.width = 35,
    this.alignment = Alignment.topLeft,
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(8.4),
      bottomRight: Radius.circular(8.4),
    ),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: image == false ? alignment : null,
      decoration: image
          // ? null
          ? BoxDecoration(
              borderRadius: borderRadius,
            )
          : (widget == null)
              ? null
              : BoxDecoration(
                  borderRadius: borderRadius,
                ),
      child: (widget == null)
          ? image
              ? ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(7.5),
                  ),
                  child: Image.asset(
                    // alignment: alignment,
                    'assets/img/AniList_logo.png',
                    fit: BoxFit.fitHeight,
                    cacheHeight: 100,
                    filterQuality: FilterQuality.high,
                    cacheWidth: 100,
                  ),
                )
              : null
          : Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: const Color.fromRGBO(24, 33, 44, 1),
              ),
              alignment: Alignment.center,
              child: widget!,
            ),
    );
  }
}
