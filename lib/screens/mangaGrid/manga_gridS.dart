// ignore_for_file: file_names, must_be_immutable

import 'package:anisearch2/api/models/api_graphql_media_model.dart';
import 'package:anisearch2/api/repositories/manga_anime_provider.dart';
import 'package:anisearch2/screens/homePage/home_page.dart';
import 'package:anisearch2/screens/mangaGrid/controller/controller.dart';
import 'package:anisearch2/widgetU/build_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MangaGridS extends GetView<MangaGridSController> {
  MangaGridS({
    super.key,
    this.lista,
    this.main = false,
  });
  final bool main;

  List<Media>? lista;

  @override
  Widget build(BuildContext context) {
    // final sw = Get.find<MangaGridSController>();
    final List<Media> listaManga = Provider.of<ApiProvider>(context).manga;
    final List<Media> listaAnime = Provider.of<ApiProvider>(context).anime;

    return Scaffold(
      appBar: (main == true)
          ? AppBar(
              surfaceTintColor: Theme.of(context).colorScheme.background,
              elevation: 0,
            )
          : null,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (main == true) {
              final dataProvider =
                  ModalRoute.of(context)!.settings.arguments as List<Media>;

              lista = dataProvider;

              if (kDebugMode) {
                print(lista);
              }
              final RefreshController refreshController =
                  RefreshController(initialRefresh: false);

              return SmartRefresher(
                enablePullDown: false,
                enablePullUp: true,
                semanticChildCount: lista!.length,
                onLoading: () {
                  if (lista!.first.type == 'MANGA') {
                    final sw = Get.find<MangaGridSController>();
                    sw.onLoading(
                        context, 'TRENDING_DESC', lista!.first.type, lista!);
                    lista = listaManga;
                    refreshController.loadComplete();
                  } else {
                    final sw = Get.find<MangaGridSController>();
                    sw.onLoading(
                        context, 'TRENDING_DESC', lista!.first.type, lista!);
                    lista = listaAnime;
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
                    final imageUrl = lista![index].coverImage!.extraLarge ??
                        lista![index].coverImage!.large ??
                        lista![index].coverImage!.medium ??
                        'https://convertingcolors.com/plain-1E2436.svg';
                    final title = lista![index].title!.english ??
                        lista![index].title!.romaji ??
                        lista![index].title!.native ??
                        '';
                    final style = Theme.of(context).textTheme.button!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        );
                    final averageScore = lista![index].averageScore;

                    return GestureDetector(
                      onTap: () => Get.toNamed(
                        '/d',
                        arguments: lista![index],
                      ),
                      child: Card(
                        color: Colors.blueGrey[900],
                        elevation: 0,
                        child: Column(
                          children: [
                            Flexible(
                              fit: FlexFit.tight,
                              child: Stack(
                                children: [
                                  BuildImageWidget(
                                    borderradius: 10,
                                    fit: BoxFit.cover,
                                    width: constraints.maxWidth,
                                    height: constraints.maxHeight,
                                    imageUrl: imageUrl,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const CardS(
                                        height: 30.49,
                                        width: 30.27,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8.4),
                                            bottomRight: Radius.circular(8.4)),
                                        image: true,
                                      ),
                                      CardScore(
                                        title: (averageScore == null)
                                            ? null
                                            : (averageScore / 10).toString(),
                                        style: style,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 5.0),
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
                final imageUrl = lista![index].coverImage!.extraLarge ??
                    lista![index].coverImage!.large ??
                    lista![index].coverImage!.medium ??
                    '';
                final title = lista![index].title!.english ??
                    lista![index].title!.romaji ??
                    lista![index].title!.native ??
                    '';
                final style = Theme.of(context).textTheme.button!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    );
                final averageScore = lista![index].averageScore;
                // print(constraints.maxHeight * .2);

                return GestureDetector(
                  onTap: () => Get.toNamed(
                    '/d',
                    arguments: lista![index],
                  ),
                  child: Card(
                    color: Colors.blueGrey[900],
                    elevation: 0,
                    child: Column(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: Stack(
                            children: [
                              BuildImageWidget(
                                filterQuality: FilterQuality.high,
                                borderradius: 10,
                                width: (GetPlatform.isWeb)
                                    ? (constraints.maxWidth * 1)
                                    : constraints.maxWidth,
                                height: (GetPlatform.isWeb)
                                    ? (constraints.maxHeight * 1)
                                    : constraints.maxHeight,
                                fit: BoxFit.cover,
                                imageUrl: imageUrl,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CardS(
                                    height: GetPlatform.isWeb ? 31 : 30.49,
                                    width: GetPlatform.isWeb ? 32 : 30.27,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8.4),
                                        bottomRight: Radius.circular(8.4)),
                                    image: true,
                                  ),
                                  CardScore(
                                    title: (averageScore == null)
                                        ? null
                                        : (averageScore / 10).toString(),
                                    style: style,
                                  ),
                                ],
                              ),
                            ],
                          ),
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
    required this.title,
    required this.style,
  }) : super(key: key);

  final String? title;

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return CardS(
      height: 30.49,
      // width: 30.27,
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8.4), bottomLeft: Radius.circular(8.4)),
      image: false,
      widget: (title == null)
          ? null
          : Text(
              '# $title',
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
    this.height = 37.49,
    this.width = 37.27,
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
      // alignment: image == false ? alignment : null,
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
                    topLeft: Radius.circular(8.4),
                    bottomRight: Radius.circular(8.4),
                  ),
                  child: Image.asset(
                    alignment: alignment,
                    'assets/img/AniList_logo.png',
                    fit: BoxFit.cover,
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
