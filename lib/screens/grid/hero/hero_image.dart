import 'package:anisearch2/api/models/api_graphql_media_model.dart';
import 'package:anisearch2/screens/grid/manga_gridS.dart';
import 'package:anisearch2/widgetU/build_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeroImageGrid extends StatelessWidget {
  const HeroImageGrid({
    Key? key,
    required this.url,
    required this.isCurrentPage,
    required this.listaU,
    required this.constraints,
    required this.style,
    this.main = true,
    this.averageScore,
  }) : super(key: key);

  final TextStyle style;
  final double? averageScore;
  final String Function() url;
  final bool isCurrentPage;
  final Media listaU;

  final bool main;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Hero(
        key: ObjectKey(listaU.id),
        tag: ObjectKey(listaU.id),
        child: Material(
          type: MaterialType.transparency,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                transform: Matrix4.identity()
                  ..translate(
                    isCurrentPage ? 0.0 : -20.0,
                    isCurrentPage ? 0.0 : 60.0,
                  ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     blurRadius: 15,
                  //     offset: const Offset(0, 25),
                  //     color: Colors.black.withOpacity(.12),
                  //   ),
                  // ],
                ),
                child: BuildImageWidget(
                  filterQuality: FilterQuality.high,
                  imageUrl: url(),
                  borderradius: 8.7,
                  fit: (GetPlatform.isWeb)
                      ? (MediaQuery.of(context).size.height >= 900)
                          ? BoxFit.cover
                          : BoxFit.cover
                      : BoxFit.cover,
                  height: (GetPlatform.isWeb)
                      ? constraints.maxHeight
                      : constraints.maxHeight,
                  width: (GetPlatform.isWeb)
                      ? constraints.maxWidth
                      : constraints.maxWidth,
                  // height: 500,
                  // height: constraints.maxHeight,
                ),
              ),
              main
                  ? Positioned(
                      right: -1,
                      bottom: -1,
                      child: CardScore(
                        averageScore: (averageScore == null)
                            ? null
                            : (averageScore! / 10),
                        media: listaU,
                        style: style,
                      ),
                    )
                  : Container(),
              main
                  ? Container()
                  : Positioned(
                      width: 40,
                      height: 40,
                      bottom: -1,
                      left: -1,
                      child: AnimatedContainer(
                        curve: Curves.bounceIn,
                        transform: Matrix4.identity()
                          ..translate(
                            isCurrentPage ? 0.0 : -20.0,
                            isCurrentPage ? 0.0 : 60.0,
                          ),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        duration: const Duration(milliseconds: 300),
                        child: const CardS(
                          height: 40,
                          width: 40,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(7.5),
                          ),
                          image: true,
                        ),
                      ),
                    ),
              Positioned(
                height: 40,
                width: 40,
                right: -1,
                bottom: -1,
                child: AnimatedContainer(
                  curve: Curves.bounceIn,
                  transform: Matrix4.identity()
                    ..translate(
                      isCurrentPage ? 0.0 : -20.0,
                      isCurrentPage ? 0.0 : 60.0,
                    ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  duration: const Duration(milliseconds: 300),
                  child: CardScore(
                    averageScore:
                        (listaU.episodes == null) ? null : (listaU.episodes),
                    media: listaU,
                    style: style,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
