import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/screens/home/controller/controller.dart';
import 'package:ani_search/screens/home/widget/item_builder/grid_1.dart';
import 'package:ani_search/screens/home/widget/item_builder/grid_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
