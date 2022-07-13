import 'package:ani_search/app/data/api_graphql_media_model.dart';
import 'package:flutter/material.dart';

class HeroTitle extends StatelessWidget {
  const HeroTitle({
    super.key,
    required this.media,
    this.style,
    this.maxLines = 4,
    this.textAlign,
  });
  final int maxLines;
  final TextStyle? style;
  final Media media;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ObjectKey(
          media.title!.english ?? media.title!.romaji ?? media.title!.native),
      child: Text(
        media.title!.english ??
            media.title!.romaji ??
            media.title!.native ??
            '',
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign ?? TextAlign.left,
        style: style ??
            Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
        maxLines: maxLines,
      ),
    );
  }
}
