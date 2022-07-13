import 'package:ani_search/app/data/api_graphql_media_model.dart';
import 'package:ani_search/app/modules/home/controllers/home_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'grid_1.dart';
import 'grid_2.dart';

Widget itemBuilder(BuildContext context, Media media, int index) {
  final h = MediaQuery.of(context).size.height;

  final w = MediaQuery.of(context).size.width;

  final controller = Get.find<HomepageController>();

  return controller.gridview.value
      ? grid1(
          h,
          w,
          media,
          context,
          index,
        )
      : grid2(
          media,
          context,
          w,
          h,
          index,
        );
}
