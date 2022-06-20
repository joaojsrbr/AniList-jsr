// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:anisearch2/api/models/api_graphql_media_model.dart';
import 'package:anisearch2/screens/mangaDetails/hero/hero_image.dart';
import 'package:anisearch2/screens/mangaDetails/hero/hero_row_score.dart';
import 'package:anisearch2/screens/mangaDetails/hero/hero_title.dart';

class MangaDetailsRBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MangaDetailsRController>(
      () => MangaDetailsRController(),
    );
  }
}

class MangaDetailsRController extends GetxController {}

class MangaDetailsR extends GetView<MangaDetailsRController> {
  const MangaDetailsR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //
        final w = constraints.maxWidth;
        //
        final h = constraints.maxHeight;

        final dataProvider =
            ModalRoute.of(context)!.settings.arguments as Media;

        // final image = dataProvider.coverImage!.extraLarge ??
        //     dataProvider.coverImage!.large ??
        //     dataProvider.coverImage!.medium ??
        //     dataProvider.bannerImage ??
        //     'https://convertingcolors.com/plain-1E2436.svg';

        final title = dataProvider.title!.english ??
            dataProvider.title!.romaji ??
            dataProvider.title!.native ??
            '';

        final averageScore = ((dataProvider.averageScore ?? 0.0) / 10);

        if (kDebugMode) {
          print('id: ${dataProvider.id} -- title: $title\n');
        }

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: h * 0.7,
                flexibleSpace: FlexibleSpaceBar(
                  background: SafeArea(
                    child: Stack(
                      children: [
                        HeroImage(
                          h: h,
                          w: w,
                          dataProvider: dataProvider,
                        ),
                        Positioned(
                          top: h * .09,
                          right: 2,
                          left: w * .47,
                          height: h * .1,
                          // width: w * .48,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeroTitle(
                                title: title,
                              ),
                              HeroRowScore(
                                dataProvider: dataProvider,
                                averageScore: averageScore,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
