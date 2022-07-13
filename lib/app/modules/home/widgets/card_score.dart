import 'package:ani_search/app/data/api_graphql_media_model.dart';
import 'package:ani_search/app/modules/home/widgets/cards.dart';
import 'package:flutter/material.dart';

class CardScore extends StatelessWidget {
  const CardScore({
    super.key,
    this.averageScore,
    required this.style,
    required this.media,
  });

  final Media media;
  final dynamic averageScore;

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return CardS(
      // height: 30.49,
      // width: 30.27,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomRight: Radius.circular(7.5),
      ),
      image: false,
      widget: (averageScore == null)
          ? null
          : Text(
              '$averageScore',
              style: style.copyWith(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
    );
  }
}
