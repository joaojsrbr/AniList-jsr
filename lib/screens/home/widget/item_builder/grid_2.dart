import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/screens/details/page/details_page.dart';
import 'package:ani_search/screens/home/controller/controller.dart';
import 'package:ani_search/screens/home/hero/hero_image.dart';
import 'package:ani_search/screens/home/page/home_page.dart';
import 'package:ani_search/utils/app_colors.dart';
import 'package:boxy/boxy.dart';
import 'package:boxy/flex.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

Widget grid2(Media media, BuildContext context, double w, double h, int index) {
  final style = Theme.of(context).textTheme.headline6!.copyWith(
        color: Colors.white,
      );

  final controller = Get.find<HomepageController>();

  final publishing = 'Publishing'.i18n();

  return GestureDetector(
    onTap: () {
      Get.to(
        const MangaDetailsR(),
        arguments: media,
        curve: Curves.ease,
        duration: controller.transitionDuration,
        transition: Transition.fade,
      );
    },
    child: BoxyRow(
      children: [
        Dominant(
          child: CustomBoxy(
            delegate: Mybox(),
            children: [
              BoxyId(
                id: #image,
                hasData: true,
                data: Size(w / 2.3, h),
                child: HeroImage(
                  logo: false,
                  h: h,
                  w: w,
                  dataProvider: media,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          width: w * .5,
          child: BoxyColumn(
            children: [
              Text(
                '$publishing ${media.startDate!.year}',
                textAlign: TextAlign.left,
                style: style.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                media.type ?? '',
                textAlign: TextAlign.left,
                style: style.copyWith(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                media.description ?? '',
                maxLines: 12,
                overflow: TextOverflow.ellipsis,
                style: style.copyWith(
                  color: Colors.grey[400],
                  fontSize: 13,
                ),
              ),
              Dominant.expanded(
                flex: 2,
                child: Wrap(
                  children: media.genres!
                      .map<Widget>(
                        (e) => Card(
                          child: Text(
                            e,
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                              fontSize: 12.5,
                              color: AppColors().primary(context),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
