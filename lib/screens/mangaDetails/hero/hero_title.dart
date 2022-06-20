import 'package:flutter/material.dart';

class HeroTitle extends StatelessWidget {
  const HeroTitle({
    Key? key,
    required this.title,
    this.style,
    this.maxLines = 4,
  }) : super(key: key);
  final int maxLines;
  final TextStyle? style;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ObjectKey(title),
      child: Text(
        title,
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
