// ignore_for_file: file_names

import 'package:anisearch2/api/repositories/anime_provider.dart';
import 'package:anisearch2/api/repositories/manga_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:anisearch2/api/models/api_graphql_media_model.dart';
import 'package:anisearch2/screens/grid/controller/controller.dart';
import 'package:anisearch2/screens/grid/widget/header_trends.dart';
import 'package:anisearch2/screens/grid/widget/trends.dart';
import 'package:provider/provider.dart';

class ConsumerTwo<AnimeProvider, MangaProvider> extends StatelessWidget {
  const ConsumerTwo({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext context, AnimeProvider anime,
      MangaProvider manga, Widget child) builder;
  @override
  Widget build(BuildContext context) {
    return Consumer<MangaProvider>(
      builder: (context, manga, child) {
        return Consumer<AnimeProvider>(
          builder: (context, anime, child) {
            return builder(context, anime, manga, child!);
          },
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class MangaGridM extends GetView<MangaGridSController> {
  final String? sort;
  final bool search;
  final String? type;

  const MangaGridM({
    super.key,
    this.search = false,
    this.sort,
    this.type,
  });
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: <Widget>[
          ConsumerTwo<AnimeProvider, MangaProvider>(
            builder: (context, anime, manga, child) {
              if (type == 'MANGA') {
                return _CopyWidget(
                  lista: manga.manga,
                  type: type!,
                  sort: sort!,
                  title: 'Trending',
                );
              } else {
                return _CopyWidget(
                  title: 'Trending',
                  // sort: "POPULARITY_DESC",
                  sort: sort!,
                  type: type!,
                  lista: anime.anime,
                );
              }
            },
          ),
          ConsumerTwo<AnimeProvider, MangaProvider>(
            builder: (context, anime, manga, child) {
              if (type == 'MANGA') {
                return _CopyWidget(
                  lista: manga.mangap,
                  type: type!,
                  popula: true,
                  sort: "POPULARITY_DESC",
                  title: 'All Time Popular',
                );
              } else {
                return _CopyWidget(
                  title: 'All Time Popular',
                  popula: true,
                  sort: "POPULARITY_DESC",
                  // sort: sort!,
                  type: type!,
                  lista: anime.animep,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _CopyWidget extends StatelessWidget {
  const _CopyWidget({
    Key? key,
    required this.title,
    required this.sort,
    required this.type,
    required this.lista,
    this.popula = false,
  }) : super(key: key);
  final bool popula;
  final List<Media>? lista;
  final String sort, type, title;

// aspectRatio: (GetPlatform.isWeb)
//               ? (MediaQuery.of(context).size.height >= 900)
//                   ? (38 / 16)
//                   : (8 / 10.5)
//               : (8 / 9.9),
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .59,
          child: Column(
            // primary: true,
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderTrends(
                popula: popula,
                title: title,
                lista: lista,
                sort: sort,
              ),
              Trends(
                popula: popula,
                lista: lista,
                sort: sort,
                type: type,
              ),
              // const Recents()
            ],
          ),
        ),
      ),
    );
  }
}
