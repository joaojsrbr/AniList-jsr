import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/screens/details/models/list_type.dart';
import 'package:ani_search/screens/details/widget/card_w.dart';
import 'package:flutter/material.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

List<Widget> listCard(BuildContext context, Media? media) {
  final localizations = KLocalizations.of(context);

  return cardlistString(media!, localizations.defaultLocale.countryCode)
      .entries
      .map<Widget>(
        (a) => CardW(
          // height: 40,
          // height: MediaQuery.of(context).size.height * .110,
          width: MediaQuery.of(context).size.width * .435,
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text(
            (a.value.entries.map((e) => e.value).first ?? '').toString(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            (a.value.entries.map((e) => e.value).last ?? '').toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 13.5,
              // color: Theme.of(context).colorScheme.primary,
              color: Colors.white70,
            ),
          ),
        ),
      )
      .toList();
}
