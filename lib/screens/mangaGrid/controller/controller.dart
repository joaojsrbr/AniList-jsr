// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:anisearch2/api/models/api_graphql_media_model.dart';
import 'package:anisearch2/api/repositories/manga_anime_provider.dart';

class MangaGridSController extends GetxController {
  RxInt page = 1.obs;
  RxInt index = 0.obs;
  late ScrollController scrollController;

  @override
  void onInit() {
    scrollController = ScrollController();

    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void loadMore(
    BuildContext context,
    bool manga,
    String sort,
    dynamic type,
  ) async {
    page.value += 1;
    await Provider.of<ApiProvider>(context, listen: false).getMore(
      sort: [sort],
      perPage: 25,
      page: page.value,
      type: type!,
      mangas: manga,
    );
  }

  void onLoading(
    BuildContext context,
    String sort,
    dynamic type,
    List<Media>? lista,
  ) {
    if (kDebugMode) {
      print(page.value);
      print(lista!.length);
      print(lista.first.type);
    }
    if (lista!.first.type == "MANGA") {
      loadMore(
        context,
        true,
        sort,
        type,
      );
    } else {
      loadMore(
        context,
        false,
        sort,
        type,
      );
    }
  }
}
