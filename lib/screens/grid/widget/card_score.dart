import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/screens/grid/widget/cards.dart';
import 'package:flutter/material.dart';

class CardScore extends StatelessWidget {
  const CardScore({
    Key? key,
    this.averageScore,
    required this.style,
    required this.media,
  }) : super(key: key);

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
