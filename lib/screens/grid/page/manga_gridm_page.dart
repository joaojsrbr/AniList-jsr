// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/api/repositories/anime_provider.dart';
import 'package:ani_search/api/repositories/manga_provider.dart';
import 'package:ani_search/screens/details/hero/hero_image.dart';
import 'package:ani_search/screens/details/hero/hero_title.dart';
import 'package:ani_search/screens/details/page/details_page.dart';
import 'package:ani_search/screens/grid/controller/controller.dart';
import 'package:ani_search/widgetU/consumer_two_value.dart';

class GridViewP<A> extends StatelessWidget {
  // const ValueListenableBuilder3(
  //   this.first,
  //   this.three,
  //   this.second, {
  //   super.key,
  //   required this.builder,
  //   this.child,
  // });

  const GridViewP(
    this.lista, {
    super.key,
    this.padding,
    this.reverse = false,
    this.shrinkWrap = false,
    this.controller,
    this.onEndOfPage,
    this.primary,
    this.physics,
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addSemanticIndexes = true,
    this.addRepaintBoundaries = true,
    // this.itemCount,
    this.isLoading = false,
    required this.gridDelegate,
    required this.itemBuilder,
  });
  final EdgeInsetsGeometry? padding;
  final List<A>? lista;

  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final SliverGridDelegate gridDelegate;
  final bool shrinkWrap;
  final int? Function(Key)? findChildIndexCallback;
  // final int? itemCount;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final void Function(int length)? onEndOfPage;
  final bool isLoading;

  final Widget Function(BuildContext context, int index, A a, int length)
      itemBuilder;
  @override
  Widget build(BuildContext context) {
    return LazyLoadScrollView(
      isLoading: isLoading,
      onEndOfPage: () {
        onEndOfPage!(lista!.length);
      },
      child: GridView.builder(
        itemCount: lista!.length,
        gridDelegate: gridDelegate,
        reverse: reverse,
        primary: primary,
        findChildIndexCallback: findChildIndexCallback,
        shrinkWrap: shrinkWrap,
        controller: controller,
        padding: padding,
        itemBuilder: (context, index) {
          return itemBuilder(context, index, lista![index], lista!.length);
        },
      ),
    );
  }
}

class MangaGridM extends GetResponsiveView<MangaGridSController> {
  final String? sort;
  final bool search;
  final String? type;

  MangaGridM({
    super.key,
    this.search = false,
    this.sort,
    this.type,
  });
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final h = constraints.maxHeight;
        final w = constraints.maxWidth;

        // final double height = (MediaQuery.of(context).size.height * .045);

        // const EdgeInsets padding = EdgeInsets.all(3.5);

        return Scaffold(
          // key: scaffoldKey,
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Column(
            children: [
              Expanded(
                child: GetBuilder<MangaGridSController>(
                  id: 28,
                  builder: (controller) =>
                      ConsumerTwo<AnimeProvider, MangaProvider>(
                    builder: (context, anime, manga, child) {
                      final lista =
                          (type == 'MANGA') ? manga.manga : anime.anime;
                      final isLoading =
                          (type == 'MANGA') ? manga.isLoading : anime.isLoading;

                      return (anime.anime.isEmpty | manga.manga.isEmpty)
                          ? child
                          : controller.select0.value
                              ? GridViewP<Media>(
                                  lista,
                                  isLoading: isLoading,

                                  onEndOfPage: (length) async {
                                    await controller.loadmore(
                                      context,
                                      sort,
                                      type,
                                    );
                                  },
                                  primary: true,
                                  // primary: true,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 8,
                                  ),
                                  shrinkWrap: true,
                                  // key: UniqueKey(),
                                  physics: const ScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics(),
                                  ),
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent:
                                        MediaQuery.of(context).size.height *
                                            .35,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 15,
                                    mainAxisExtent:
                                        MediaQuery.of(context).size.height *
                                            .33,
                                  ),
                                  itemBuilder: (context, index, media, length) {
                                    return GestureDetector(
                                      onTap: () {
                                        const transitionDuration =
                                            Duration(milliseconds: 600);
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            settings: RouteSettings(
                                              arguments: media,
                                            ),
                                            transitionDuration:
                                                transitionDuration,
                                            reverseTransitionDuration:
                                                transitionDuration,
                                            pageBuilder: (_, animation, __) {
                                              return FadeTransition(
                                                opacity: animation,
                                                child: const MangaDetailsR(),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
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
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : controller.select1.value
                                  ? Container()
                                  : Container();
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// class _CopyWidget extends StatelessWidget {
//   const _CopyWidget({
//     Key? key,
//     required this.title,
//     required this.sort,
//     required this.type,
//     required this.lista,
//     this.streamController,
//     this.popula = false,
//   }) : super(key: key);
//   final bool popula;
//   final List<Media>? lista;
//   final StreamController<int>? streamController;
//   final String sort, type, title;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 15),
//       child: SafeArea(
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height * .59,
//           child: Column(
//             // primary: true,
//             // mainAxisAlignment: MainAxisAlignment.start,
//             // crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               HeaderTrends(
//                 popula: popula,
//                 title: title,
//                 lista: lista,
//                 sort: sort,
//               ),
//               Trends(
//                 streamController: streamController,
//                 popula: popula,
//                 lista: lista,
//                 sort: sort,
//                 type: type,
//               ),
//               // const Recents()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
