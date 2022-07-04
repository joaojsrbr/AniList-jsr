import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsumerTwo<AnimeProvider, MangaProvider> extends StatelessWidget {
  const ConsumerTwo({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext context, AnimeProvider anime,
      MangaProvider manga, Widget child) builder;
  @override
  Widget build(BuildContext context) {
    return Consumer<MangaProvider>(
      builder: (context, manga, child) {
        return Consumer<AnimeProvider>(
          builder: (context, anime, child) {
            return builder(context, anime, manga, child!);
          },
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
