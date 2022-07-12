// ignore_for_file: unused_element

import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/api/repositories/search_repository.dart';
import 'package:ani_search/screens/details/page/details_page.dart';
import 'package:ani_search/screens/home/controller/controller.dart';
import 'package:ani_search/screens/home/hero/hero_image.dart';
import 'package:ani_search/screens/home/hero/hero_title.dart';
import 'package:ani_search/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';

class MySearchDelegate extends SearchDelegate {
  final controller = Get.find<HomepageController>();

  late SearchRepository searchRepository = SearchRepository(
    result: false,
    manga: controller.manga.value,
  );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      scaffoldBackgroundColor: Theme.of(context).colorScheme.background,
      appBarTheme: AppBarTheme(
        surfaceTintColor: Theme.of(context).colorScheme.background,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        key: const Key('clear'),
        icon: const Icon(Icons.clear),
        onPressed: () async {
          if (query.isEmpty) {
            close(context, null);
            // await getData('airing');
          } else {
            query = '';

            // close(context, null);
            // getData(query);
          }
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      key: const Key('arrow back'),
      icon: const Icon(Icons.arrow_back),
      onPressed: () async {
        close(context, null);

        // await getData(getCategory(selectedIndex));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final SearchRepository searchRepository;

    bool querym = false;

    searchRepository = SearchRepository(
      result: true,
      manga: controller.manga.value,
      query: query,
    );
    if (query == '') {
      querym = true;
    }

    return Scaffold(
      body: querym
          ? _KeepLive(
              manga: controller.manga.value,
            )
          : LoadingMoreList(
              ListConfig<Media>(
                autoLoadMore: false,
                autoRefresh: true,
                sourceList: searchRepository,
                padding: const EdgeInsets.all(8),
                itemBuilder: itemBuilder,
                indicatorBuilder: (context, indicator) =>
                    indicatorBuilder(context, indicator, searchRepository),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 340,
                  childAspectRatio: 1,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 15,
                  mainAxisExtent: 300,
                ),
              ),
            ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _KeepLive(
      manga: controller.manga.value,
    );
  }
}

Widget indicatorBuilder(BuildContext context, IndicatorStatus status,
    LoadingMoreBase<Media> loadingMoreBase) {
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

  late Widget widget;
  switch (status) {
    case IndicatorStatus.none:
      widget = Container(height: 0.0);

      break;
    case IndicatorStatus.loadingMoreBusying:
      widget = Container();
      break;
    case IndicatorStatus.fullScreenBusying:
      widget = Center(
        child: getIndicator(context),
      );
      widget = _setbackground(false, widget, 35.0, context);

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
          loadingMoreBase.errorRefresh();
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
          loadingMoreBase.errorRefresh();
        },
        child: widget,
      );

      break;
    case IndicatorStatus.noMoreLoad:
      widget = Container();

      break;
    case IndicatorStatus.empty:
      widget = Container();
      break;
  }
  return widget;
}

class _KeepLive extends StatefulWidget {
  const _KeepLive({
    super.key,
    required this.manga,
  });
  final bool manga;

  @override
  State<_KeepLive> createState() => _KeepLiveState();
}

class _KeepLiveState extends State<_KeepLive>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final controller = Get.find<HomepageController>();

    final mangaRepository =
        widget.manga ? controller.mangaRepository : controller.animeRepository;

    return Scaffold(
      body: GridView.builder(
        // key: ObjectKey(controller.type.value),
        key: const PageStorageKey('Results'),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 340,
          childAspectRatio: 1,
          crossAxisSpacing: 0,
          mainAxisSpacing: 15,
          mainAxisExtent: 300,
        ),
        cacheExtent: 340,
        padding: const EdgeInsets.all(8),
        itemCount: mangaRepository.length,
        itemBuilder: (context, index) => itemBuilder(
          context,
          mangaRepository[index],
          index,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Widget itemBuilder(BuildContext context, Media media, int index) {
  final h = MediaQuery.of(context).size.height;
  final w = MediaQuery.of(context).size.width;
  return grid1(
    h,
    w,
    media,
    context,
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
