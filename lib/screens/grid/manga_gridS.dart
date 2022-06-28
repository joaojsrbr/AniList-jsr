// ignore_for_file: file_names, must_be_immutable

import 'package:anisearch2/api/models/api_graphql_media_model.dart';
import 'package:anisearch2/screens/grid/controller/controller.dart';
import 'package:anisearch2/screens/grid/widget/grid_build.dart';
import 'package:anisearch2/screens/grid/widget/smartr_build.dart';
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
              return SmartRBuild(
                lista: lista,
                constraints: constraints,
                refreshController: refreshController,
                sort: sort,
                popula: popula,
              );
            }
            return GridBuild(
              lista: lista,
              constraints: constraints,
            );
          },
        ),
      ),
    );
  }
}
