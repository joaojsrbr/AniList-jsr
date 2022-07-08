import 'package:flutter/material.dart';

class CardS extends StatelessWidget {
  final Alignment alignment;
  final bool image;
  final double height;
  final double width;
  final Widget? widget;
  final BorderRadiusGeometry? borderRadius;
  const CardS({
    this.widget,
    this.image = true,
    this.height = 35,
    this.width = 35,
    this.alignment = Alignment.topLeft,
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(8.4),
      bottomRight: Radius.circular(8.4),
    ),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: image == false ? alignment : null,
      decoration: image
          // ? null
          ? BoxDecoration(
              borderRadius: borderRadius,
            )
          : (widget == null)
              ? null
              : BoxDecoration(
                  borderRadius: borderRadius,
                ),
      child: (widget == null)
          ? image
              ? ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(7.5),
                  ),
                  child: Image.asset(
                    // alignment: alignment,
                    'assets/img/AniList_logo.png',
                    fit: BoxFit.fitHeight,
                    cacheHeight: 100,
                    filterQuality: FilterQuality.high,
                    cacheWidth: 100,
                  ),
                )
              : null
          : Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: const Color.fromRGBO(24, 33, 44, 1),
              ),
              alignment: Alignment.center,
              child: widget!,
            ),
    );
  }
}
