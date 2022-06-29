// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/screens/details/hero/hero_image.dart';
import 'package:ani_search/screens/details/hero/hero_row_score.dart';
import 'package:ani_search/screens/details/hero/hero_title.dart';
import 'package:get/get.dart';

class MangaDetailsR extends StatefulWidget {
  const MangaDetailsR({Key? key}) : super(key: key);

  @override
  State<MangaDetailsR> createState() => _MangaDetailsRState();
}

class _MangaDetailsRState extends State<MangaDetailsR> {
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

        // final averageScore = ((dataProvider.averageScore ?? 0.0) / 10);

        if (kDebugMode) {
          print(
              'id: ${dataProvider.idr} -- title: ${dataProvider.title!.english ?? dataProvider.title!.romaji ?? dataProvider.title!.native ?? ''}\n');
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
                          right: GetPlatform.isWindows ? 0 : 2,
                          left: GetPlatform.isWindows ? w * .25 : w * .47,
                          height: h * .2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeroTitle(
                                media: dataProvider,
                              ),
                              HeroRowScore(
                                dataProvider: dataProvider,
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
