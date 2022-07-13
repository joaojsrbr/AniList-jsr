import 'package:ani_search/app/data/api_graphql_media_model.dart';
// import 'package:ani_search/app/modules/details/view/details_view.dart';
// import 'package:ani_search/app/modules/home/controllers/home_controller.dart';
import 'package:ani_search/app/modules/home/widgets/hero_image.dart';
import 'package:ani_search/app/modules/home/widgets/hero_title.dart';
import 'package:ani_search/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget grid1(double h, double w, Media media, BuildContext context, int index) {
  // final controller = Get.find<HomepageController>();
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: GestureDetector(
            onTap: () {
              Get.toNamed(
                Routes.details,
                arguments: media,
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
