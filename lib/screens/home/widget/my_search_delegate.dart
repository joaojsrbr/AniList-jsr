import 'dart:collection';
import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/api/repositories/anime_provider.dart';
import 'package:ani_search/api/repositories/manga_provider.dart';
import 'package:ani_search/api/repositories/search_provider.dart';
import 'package:ani_search/screens/details/page/details_page.dart';
import 'package:ani_search/screens/home/hero/hero_image.dart';
import 'package:ani_search/screens/home/hero/hero_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MySearchDelegate extends SearchDelegate {
  BuildContext context;
  final bool manga;

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

  void searchDataSu(String query, bool manga) {
    Provider.of<SearchProvider>(context).searchDataSu(
      query: query,
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
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    if (query.isNotEmpty) {
      searchDataSu(query, manga);
      final queryMain = Provider.of<SearchProvider>(context).searchListSu;
      return _return(
          const PageStorageKey('Results'), h, w, manga ? queryMain : queryMain);
      // return MangaGridS(
      //   lista: manga ? queryMain : queryMain,
      //   key: const PageStorageKey('Results'),
      // );
    } else {
      final queryMainManga = Provider.of<MangaProvider>(context).manga;
      return _return(const PageStorageKey('Results'), h, w, queryMainManga);
      // return MangaGridS(
      //   lista: queryMainManga,
      //   key: const PageStorageKey('Results'),
      // );
    }
  }

  Scaffold _return(PageStorageKey key, double h, double w,
      UnmodifiableListView<Media> queryMainManga) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            key: key,
            itemCount: queryMainManga.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 340,
              childAspectRatio: 1,
              crossAxisSpacing: 0,
              mainAxisSpacing: 15,
              mainAxisExtent: 300,
            ),
            itemBuilder: (context, index) {
              return grid1(h, w, queryMainManga[index], context);
            },
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

  Future<void> getHomeManga(List<String> sort, String type) async {
    await Provider.of<MangaProvider>(context, listen: false)
        .getHomeManga(sort: sort, type: type);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final queryMainAnime = Provider.of<AnimeProvider>(context).anime;

    final queryMainManga = Provider.of<MangaProvider>(context).manga;

    return _return(
      const PageStorageKey('Results'),
      h,
      w,
      (manga ? queryMainManga : queryMainAnime),
    );
  }
}
