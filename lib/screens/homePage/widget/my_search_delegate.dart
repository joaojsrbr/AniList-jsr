import 'package:anisearch2/screens/mangaGrid/manga_gridS.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anisearch2/api/repositories/manga_anime_provider.dart';

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
    Provider.of<ApiProvider>(context).searchDataSu(
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
    if (query.isNotEmpty) {
      searchDataSu(query, manga);
      final queryMain = Provider.of<ApiProvider>(context).searchListSu;
      return MangaGridS(
        lista: manga ? queryMain : queryMain,
        key: const PageStorageKey('Results'),
      );
    } else {
      final queryMainManga = Provider.of<ApiProvider>(context).manga;
      return MangaGridS(
        lista: queryMainManga,
        key: const PageStorageKey('Results'),
      );
    }
  }

  Future<void> getHomeManga(List<String> sort, String type) async {
    await Provider.of<ApiProvider>(context, listen: false)
        .getHomeManga(sort: sort, type: type);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final queryMainAnime = Provider.of<ApiProvider>(context).anime;

    final queryMainManga = Provider.of<ApiProvider>(context).manga;

    // final queryMain = Provider.of<ApiProvider>(context).searchListSu;

    return MangaGridS(
      lista: manga ? queryMainManga : queryMainAnime,
      key: const PageStorageKey('Results'),
    );
  }
}
