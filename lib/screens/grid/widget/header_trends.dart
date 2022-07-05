import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/screens/grid/page/manga_grids_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderTrends extends StatelessWidget {
  final List<Media>? lista;
  final String title;
  final bool popula;
  final String sort;

  const HeaderTrends({
    required this.title,
    required this.lista,
    required this.popula,
    required this.sort,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          GestureDetector(
            // onTap: () => Get.to(
            //   MangaGridS(
            //     main: true,
            //   ),
            //   arguments: lista!,
            // ),
            // onTap: () {
            // const transitionDuration = Duration(milliseconds: 800);
            // Navigator.of(context).pushReplacement(
            //   PageRouteBuilder(
            //     settings: RouteSettings(
            //       arguments: lista!,
            //     ),
            //     transitionDuration: transitionDuration,
            //     reverseTransitionDuration: transitionDuration,
            //     pageBuilder: (_, animation, __) {
            //       return SizeTransition(
            //         sizeFactor: animation,
            //         child: FadeTransition(
            //           opacity: animation,
            //           child: MangaGridS(
            //             main: true,
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // );
            // Navigator.pushReplacement(
            //   context,
            //   PageRouteBuilder(
            //     settings: RouteSettings(
            //       arguments: lista!,
            //     ),
            //     pageBuilder: (context, a1, a2) => MangaGridS(),
            //   ),
            // );
            // },
            onTap: () => Get.to(
              () => MangaGridS(
                lista: lista!,
                main: true,
                popula: popula,
                sort: sort,
              ),
              // arguments: lista!,
            ),
            child: Text(
              'View all',
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: const Color(0xFF87F5F5),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
