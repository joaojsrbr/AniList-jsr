import 'package:flutter/material.dart';

import 'package:ani_search/app/data/api_graphql_media_model.dart';

AlertDialog dialog(
    BuildContext context, BoxConstraints constraints, Media listaU) {
  return AlertDialog(
    contentPadding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
    backgroundColor: Theme.of(context).colorScheme.background,
    alignment: Alignment.center,
    content: Container(
      width: constraints.maxWidth * 1.2,
      height: 230,
      // constraints: constraints,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(32.0),
        ),
      ),
      child: ListView(
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            title: Text(
              'English',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              listaU.title!.english ?? '',
            ),
          ),
          ListTile(
            title: Text(
              'Romaji',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(listaU.title!.romaji ?? ''),
          ),
          ListTile(
            title: Text(
              'Native',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(listaU.title!.native ?? ''),
          ),
        ],
      ),
    ),
  );
}
