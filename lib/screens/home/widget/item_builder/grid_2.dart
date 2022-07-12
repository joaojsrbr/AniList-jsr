import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/screens/details/page/details_page.dart';
import 'package:ani_search/screens/home/controller/controller.dart';
import 'package:ani_search/screens/home/hero/hero_image.dart';
import 'package:ani_search/utils/app_colors.dart';
import 'package:boxy/boxy.dart';
import 'package:boxy/flex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

Widget grid2(Media media, BuildContext context, double w, double h, int index) {
  final style = Theme.of(context).textTheme.headline6!.copyWith(
        color: Colors.white,
      );

  final controller = Get.find<HomepageController>();

  final publishing = 'Publishing'.i18n();

  final description = media.description ?? '';
  final borderRadius = BorderRadius.circular(8);

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
    child: CustomBoxy(
      delegate: Mybox(),
      children: [
        BoxyId(
          id: #image,
          hasData: true,
          data: const Size(500, 350),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: HeroImage(
              logo: false,
              h: h,
              w: w,
              dataProvider: media,
            ),
          ),
        ),
        BoxyId(
          id: #text,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: BoxyColumn(
              textBaseline: TextBaseline.alphabetic,
              textDirection: TextDirection.ltr,
              children: [
                Text(
                  '$publishing ${media.startDate?.year}',
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
                BoxyFlexible(
                  flex: 40,
                  child: HtmlWidget(
                    description,
                    enableCaching: true,
                    // maxLines: 9,
                    // overflow: TextOverflow.ellipsis,
                    renderMode: RenderMode.column,
                    textStyle: style.copyWith(
                      color: Colors.grey[400],
                      fontSize: 13,
                    ),
                  ),
                ),
                BoxyFlexible(
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
                ),
              ],
            ),
          ),
        ),
        // BoxyId(
        //   hasData: true,
        //   data: description,
        //   id: #card,
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 8.0),
        //     child: Wrap(
        //       children: media.genres!
        //           .map<Widget>(
        //             (e) => Card(
        //               child: Text(
        //                 e,
        //                 textAlign: TextAlign.center,
        //                 style: style.copyWith(
        //                   fontSize: 12.5,
        //                   color: AppColors().primary(context),
        //                 ),
        //               ),
        //             ),
        //           )
        //           .toList(),
        //     ),
        //   ),
        // ),
      ],
    ),
  );
}

class Mybox extends BoxyDelegate {
  @override
  Size layout() {
    final image = getChild(#image);

    final text = getChild(#text);

    final sizei = image.parentData as Size;

    text.layout(
      constraints.copyWith(
        maxWidth: sizei.width / 2.5,
        minWidth: sizei.width / 2.5,
        maxHeight: sizei.height / 1.4,
        minHeight: sizei.height / 1.4,
      ),
    );
    image.layout(constraints.copyWith(
      maxWidth: sizei.width / 3,
      minWidth: sizei.width / 3,
      maxHeight: sizei.height / 1.1,
      minHeight: sizei.height / 1.1,
    ));

    text.position(image.rect.topRight);

    return image.size;
    // return texto.size + Offset(0, card.size.height);
  }
}
