import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/api/repositories/search_repository.dart';
import 'package:ani_search/screens/details/page/details_page.dart';
import 'package:ani_search/screens/home/hero/hero_image.dart';
import 'package:ani_search/screens/home/hero/hero_title.dart';
import 'package:ani_search/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';

class MySearchDelegate extends SearchDelegate {
  BuildContext context;
  final bool manga;

  late SearchRepository searchRepository =
      SearchRepository(result: false, manga: manga);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      scaffoldBackgroundColor: Theme.of(context).colorScheme.background,
      appBarTheme: AppBarTheme(
        surfaceTintColor: Theme.of(context).colorScheme.background,
      ),
    );
  }

  MySearchDelegate({
    required this.manga,
    required this.context,
  });

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
    late SearchRepository searchRepository;
    searchRepository = SearchRepository(
      result: true,
      manga: manga,
      query: query,
    );
    return Scaffold(
      key: const PageStorageKey('Results'),
      body: LoadingMoreList(
        ListConfig<Media>(
          autoLoadMore: false,
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

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold(
      key: const PageStorageKey('Suggestions'),
      body: LoadingMoreList(
        key: const PageStorageKey('Suggestions'),
        ListConfig<Media>(
          padding: const EdgeInsets.all(8),
          autoLoadMore: false,
          sourceList: searchRepository,
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
}

Widget indicatorBuilder(BuildContext context, IndicatorStatus status,
    SearchRepository searchRepository) {
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
          searchRepository.errorRefresh();
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
          searchRepository.errorRefresh();
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
