// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:anisearch2/api/models/api_graphql_media_model.dart';
import 'package:anisearch2/api/models/api_graphql_pageinfo_model.dart';
import 'package:anisearch2/screens/mangaGrid/controller/controller.dart';
import 'package:anisearch2/screens/mangaGrid/widget/header_trends.dart';
import 'package:anisearch2/screens/mangaGrid/widget/trends.dart';

class MangaGridM extends GetView<MangaGridSController> {
  final List<Media>? lista;

  final PageInfo? pageInfo;
  final String? sort;
  final bool search;
  final String? type;

  const MangaGridM({
    super.key,
    this.pageInfo,
    this.search = false,
    this.sort,
    this.type,
    this.lista,
  });

  @override
  Widget build(BuildContext context) {
    // final isLoading = Provider.of<ApiProvider>(context).isLoading;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: lista!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _CopyWidget(
                  lista: lista,
                  type: type!,
                  sort: sort!,
                  title: 'Trending',
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
  }) : super(key: key);

  final List<Media>? lista;
  final String sort, type, title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SafeArea(
        child: AspectRatio(
          aspectRatio: (GetPlatform.isWeb)
              ? (MediaQuery.of(context).size.height >= 900)
                  ? (38 / 16)
                  : (8 / 10.5)
              : (8 / 10.5),
          child: Column(
            // primary: true,
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderTrends(
                title: title,
                lista: lista!,
              ),
              Trends(
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
