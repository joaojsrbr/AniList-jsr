import 'package:anisearch2/api/models/api_graphql_media_model.dart';
import 'package:flutter/material.dart';

class HeroRowScore extends StatelessWidget {
  const HeroRowScore({
    Key? key,
    required this.dataProvider,
    required this.averageScore,
  }) : super(key: key);

  final Media dataProvider;
  final double averageScore;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.button!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        );
    return Hero(
      tag: ObjectKey(dataProvider.recommendations!),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Image.asset(
              'assets/img/AniList_logo.png',
              height: 22,
              width: 22,
              cacheHeight: 60,
              cacheWidth: 60,
              filterQuality: FilterQuality.high,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Score: $averageScore',
              style: style,
            ),
          ),
          const SizedBox(
            width: 7.5,
          ),
        ],
      ),
    );
  }
}
