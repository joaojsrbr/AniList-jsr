import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/screens/grid/widget/cards.dart';
import 'package:ani_search/widgetU/build_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({
    Key? key,
    required this.h,
    required this.w,
    required this.dataProvider,
  }) : super(key: key);

  final double h;
  final double w;
  final Media dataProvider;

  @override
  Widget build(BuildContext context) {
    String url() {
      final urlA = dataProvider.coverImage!.extraLarge ??
          dataProvider.coverImage!.large ??
          dataProvider.coverImage!.medium ??
          'https://convertingcolors.com/plain-1E2436.svg';

      // final urlB = dataProvider.bannerImage ??
      //     dataProvider.coverImage!.extraLarge ??
      //     dataProvider.coverImage!.large ??
      //     dataProvider.coverImage!.medium ??
      //     'https://convertingcolors.com/plain-1E2436.svg';
      return GetPlatform.isWeb
          ? (MediaQuery.of(context).size.height >= 900)
              ? urlA
              : urlA
          : urlA;
    }

    return Material(
      type: MaterialType.transparency,
      child: Hero(
        key: ObjectKey(dataProvider.idr),
        tag: ObjectKey(dataProvider.idr),
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            _Card(
              image: url(),
            ),
            const Positioned(
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
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String image;
  const _Card({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BuildImageWidget(
        filterQuality: FilterQuality.high,
        imageUrl: image,
        borderradius: 15,
        fit: (GetPlatform.isWeb)
            ? (MediaQuery.of(context).size.height >= 900)
                ? BoxFit.cover
                : BoxFit.cover
            : BoxFit.cover,
      ),
    );
  }
}
