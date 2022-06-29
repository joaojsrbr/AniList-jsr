import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:flutter/material.dart';

class HeroTitle extends StatelessWidget {
  const HeroTitle({
    Key? key,
    required this.media,
    this.style,
    this.maxLines = 4,
  }) : super(key: key);
  final int maxLines;
  final TextStyle? style;
  final Media media;

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
