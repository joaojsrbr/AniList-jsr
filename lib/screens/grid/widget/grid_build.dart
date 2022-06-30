import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/screens/details/details_page.dart';
import 'package:ani_search/screens/grid/hero/hero_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridBuild extends StatelessWidget {
  const GridBuild({
    Key? key,
    required this.lista,
    required this.constraints,
  }) : super(key: key);

  final BoxConstraints constraints;
  final List<Media>? lista;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: constraints.maxWidth > 600
            ? 3
            : constraints.maxWidth > 200
                ? 2
                : 1,
      ),
      itemCount: lista!.length,
      itemBuilder: (context, index) {
        // final url = lista![index].coverImage!.extraLarge ??
        //     lista![index].coverImage!.large ??
        //     lista![index].coverImage!.medium ??
        //     '';
        final title = lista![index].title!.english ??
            lista![index].title!.romaji ??
            lista![index].title!.native ??
            '';
        final style = Theme.of(context).textTheme.button!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            );
        final isCurrent = index == index;

        String _url() {
          final urlA = lista![index].coverImage!.extraLarge ??
              lista![index].coverImage!.large ??
              lista![index].coverImage!.medium ??
              'https://convertingcolors.com/plain-1E2436.svg';

          // final urlB = listaU.bannerImage ??
          //     listaU.coverImage!.extraLarge ??
          //     listaU.coverImage!.large ??
          //     listaU.coverImage!.medium ??
          //     'https://convertingcolors.com/plain-1E2436.svg';
          return GetPlatform.isWeb
              ? (MediaQuery.of(context).size.height >= 900)
                  ? urlA
                  : urlA
              : urlA;
        }

        final averageScore = lista![index].averageScore;
        // print(constraints.maxHeight * .2);

        return GestureDetector(
          // onTap: () => Get.toNamed(
          //   '/d',
          //   arguments: lista![index],
          // ),
          onTap: () {
            const transitionDuration = Duration(milliseconds: 600);
            Navigator.of(context).push(
              PageRouteBuilder(
                settings: RouteSettings(
                  arguments: lista![index],
                ),
                transitionDuration: transitionDuration,
                reverseTransitionDuration: transitionDuration,
                pageBuilder: (_, animation, __) {
                  return FadeTransition(
                    opacity: animation,
                    child: const MangaDetailsR(),
                  );
                },
              ),
            );
          },
          child: Card(
            color: Colors.blueGrey[900],
            elevation: 0,
            child: Column(
              children: [
                HeroImageGrid(
                  url: _url,
                  listaU: lista![index],
                  constraints: constraints,
                  style: style,
                  main: true,
                  averageScore: (averageScore ?? 0).toDouble(),
                  isCurrentPage: isCurrent,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 5.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
