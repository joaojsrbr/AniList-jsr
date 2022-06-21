import 'package:anisearch2/api/models/api_graphql_media_model.dart';
import 'package:anisearch2/screens/grid/manga_gridS.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderTrends extends StatelessWidget {
  final List<Media>? lista;
  final String title;

  const HeaderTrends({
    required this.title,
    required this.lista,
    Key? key,
  }) : super(key: key);

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
            onTap: () async => Get.to(
              MangaGridS(
                main: true,
              ),
              arguments: lista!,
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
