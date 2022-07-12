import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/screens/details/page/details_page.dart';
import 'package:ani_search/screens/home/controller/controller.dart';
import 'package:ani_search/screens/home/hero/hero_image.dart';
import 'package:ani_search/screens/home/hero/hero_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget grid1(double h, double w, Media media, BuildContext context, int index) {
  final controller = Get.find<HomepageController>();
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: GestureDetector(
            onTap: () {
              Get.to(
                const MangaDetailsR(),
                opaque: true,
                curve: Curves.ease,
                arguments: media,
                duration: controller.transitionDuration,
                transition: Transition.fade,
              );
            },
            child: HeroImage(
              h: h,
              w: w,
              dataProvider: media,
            ),
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
  );
}
