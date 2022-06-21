// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:anisearch2/api/models/api_graphql_media_model.dart';
import 'package:anisearch2/api/models/api_graphql_pageinfo_model.dart';
import 'package:anisearch2/screens/grid/controller/controller.dart';
import 'package:anisearch2/screens/grid/widget/header_trends.dart';
import 'package:anisearch2/screens/grid/widget/trends.dart';

class MangaGridM extends GetView<MangaGridSController> {
  final List<Media>? lista;

  final PageInfo? pageInfo;
  final String? sort;
  final bool search;
  final String? type;

  final List<Media>? lista2;

  const MangaGridM({
    super.key,
    this.lista2,
    this.pageInfo,
    this.search = false,
    this.sort,
    this.type,
    this.lista,
  });
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // final isLoading = Provider.of<ApiProvider>(context).isLoading;
    return Scaffold(
      // key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: <Widget>[
          _CopyWidget(
            lista: lista,
            type: type!,
            sort: sort!,
            title: 'Trending',
          ),
          _CopyWidget(
            lista: lista2,
            type: type!,
            popula: true,
            sort: "POPULARITY_DESC",
            title: 'All Time Popular',
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
