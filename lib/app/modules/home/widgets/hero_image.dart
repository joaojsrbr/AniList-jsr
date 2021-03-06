import 'package:ani_search/app/data/api_graphql_media_model.dart';
import 'package:ani_search/app/modules/home/widgets/cards.dart';
import 'package:ani_search/app/widgets/build_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({
    super.key,
    required this.h,
    required this.w,
    this.logo = true,
    this.hero = true,
    required this.dataProvider,
  });

  final double h;
  final double w;
  final Media dataProvider;
  final bool logo;
  final bool hero;

  @override
  Widget build(BuildContext context) {
    final imageUrl = dataProvider.coverImage!.extraLarge ??
        dataProvider.coverImage!.large ??
        dataProvider.coverImage!.medium ??
        'https://convertingcolors.com/plain-1E2436.svg';

    return HeroMode(
      enabled: hero,
      child: Hero(
        tag: ObjectKey(dataProvider.idr),
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            BuildImageWidget(
              filterQuality: FilterQuality.medium,
              imageUrl: imageUrl,
              borderradius: logo ? 15 : 8,
              fit: (GetPlatform.isWeb)
                  ? (MediaQuery.of(context).size.height >= 900)
                      ? BoxFit.cover
                      : BoxFit.cover
                  : BoxFit.cover,
            ),
            logo
                ? const Positioned(
                    // width: 40,
                    // height: 40,
                    bottom: -0.5,
                    left: -0.5,
                    child: CardS(
                      height: 30,
                      width: 30,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(7.5),
                      ),
                      image: true,
                    ),
                  )
                : Container()

            // : Positioned(
            //     bottom: -4.5,
            //     height: 70,
            //     width: w / 2.195,
            //     child: Opacity(
            //       opacity: 0.9,
            //       child: Card(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(0.0),
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.all(2.0),
            //           child: Column(
            //             textBaseline: TextBaseline.alphabetic,
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Text(
            //                 title,
            //                 textAlign: TextAlign.center,
            //                 maxLines: 3,
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .headline6!
            //                     .copyWith(
            //                       color: Colors.white,
            //                       fontWeight: FontWeight.w600,
            //                       fontSize: 14,
            //                     ),
            //                 textDirection: TextDirection.ltr,
            //                 overflow: TextOverflow.ellipsis,
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
