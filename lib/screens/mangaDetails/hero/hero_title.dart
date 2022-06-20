import 'package:flutter/material.dart';

class HeroTitle extends StatelessWidget {
  const HeroTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ObjectKey(title),
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
        maxLines: 2,
      ),
    );
  }
}
