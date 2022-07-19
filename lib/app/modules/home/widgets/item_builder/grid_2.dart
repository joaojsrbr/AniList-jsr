import 'package:ani_search/app/data/api_graphql_media_model.dart';
import 'package:ani_search/app/modules/home/widgets/hero_image.dart';
import 'package:ani_search/app/modules/home/widgets/hero_title.dart';
import 'package:ani_search/app/routes/app_pages.dart';
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

  // final controller = Get.find<HomepageController>();

  final publishing = 'Publishing'.i18n();

  // final description = media.description!;
  final description =
      (media.description ?? '').trim().replaceAll(RegExp(r'\n'), "");

  // final borderRadius = BorderRadius.circular(8);

  int _flex() {
    var flex = media.genres!.length;

    if (flex == 1) {
      flex = 12;
      return flex;
    } else if (flex >= 2 && flex <= 4) {
      flex = 12;
      return flex;
    } else if (flex >= 5 && flex <= 6) {
      flex = 16;
      return flex;
    } else if (flex >= 7) {
      flex = 24;
      return flex;
    } else {
      flex = 24;
    }
    return flex;
  }

  return GestureDetector(
    onTap: () {
      Get.toNamed(
        Routes.details,
        arguments: media,
      );
    },
    child: CustomBoxy(
      delegate: Mybox(),
      children: [
        BoxyId(
          id: #image,
          hasData: true,
          data: const Size(500, 400),
          child: HeroImage(
            logo: false,
            hero: false,
            h: h,
            w: w,
            dataProvider: media,
          ),
        ),
        BoxyId(
          id: #title,
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: BoxyColumn(
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.ltr,
                children: [
                  HeroTitle(
                    media: media,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                    // textDirection: TextDirection.ltr,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
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
                  fit: FlexFit.loose,
                  child: HtmlWidget(
                    description,
                    enableCaching: true,
                    // maxLines: 9,
                    // overflow: TextOverflow.ellipsis,

                    renderMode: RenderMode.column,
                    textStyle: style.copyWith(
                      overflow: TextOverflow.clip,
                      color: Colors.grey[400],
                      fontSize: 13,
                    ),
                  ),
                ),
                BoxyFlexible(
                  // flex: media.genres!.length >= 6 ? 22 : 11,
                  flex: _flex(),
                  child: Wrap(
                    children: media.genres!
                        .map<Widget>(
                          (e) => Padding(
                            padding: const EdgeInsets.only(top: 5.5, left: 2),
                            child: Container(
                              height: h * 0.028,
                              margin: const EdgeInsets.only(left: 2, bottom: 4),
                              child: Chip(
                                padding:
                                    const EdgeInsets.only(bottom: 8, top: 0),
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                label: Text(
                                  e,
                                  textAlign: TextAlign.start,
                                  style: style.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
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

    final title = getChild(#title);

    text.layout(
      constraints.copyWith(
        maxWidth: sizei.width / 2.5,
        minWidth: sizei.width / 2.5,
        maxHeight: sizei.height / 1.45,
        minHeight: sizei.height / 1.45,
      ),
    );
    image.layout(
      constraints.copyWith(
        maxWidth: sizei.width / 2.9,
        minWidth: sizei.width / 2.9,
        maxHeight: sizei.height / 1.25,
        minHeight: sizei.height / 1.25,
      ),
    );
    title.layout(
      constraints.copyWith(
        maxWidth: sizei.width / 2.75,
        minWidth: sizei.width / 2.75,
        maxHeight: image.size.height / 4.2,
        minHeight: image.size.height / 4.2,
      ),
    );

    final dy = (image.size.height - title.size.height) * 1.018;
    final dx = image.size.width - image.size.width - 4.9;

    title.position(Offset(dx, dy));

    text.position(image.rect.topRight);

    return image.size;
    // return texto.size + Offset(0, card.size.height);
  }
}
