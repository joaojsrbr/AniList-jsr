// ignore_for_file: file_names

import 'package:anisearch2/api/models/api_graphql_media_model.dart';
import 'package:anisearch2/api/models/api_graphql_pageinfo_model.dart';
import 'package:anisearch2/screens/mangaGrid/controller/controller.dart';
import 'package:anisearch2/screens/mangaGrid/manga_gridS.dart';
import 'package:anisearch2/widgetU/build_image.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:get/get.dart';

class MangaGridM extends GetView<MangaGridSController> {
  final List<Media>? lista;
  final ScrollController? scrollController;
  final PageInfo? pageInfo;
  final String? sort;
  final bool search;
  final String? type;

  MangaGridM({
    super.key,
    this.pageInfo,
    this.scrollController,
    this.search = false,
    this.sort,
    this.type,
    this.lista,
  });

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    // final isLoading = Provider.of<ApiProvider>(context).isLoading;

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: lista!.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  CopyWidget(
                    refreshController: refreshController,
                    lista: lista,
                    type: type!,
                    sort: sort!,
                    title: 'Trending',
                  ),
                  // CopyWidget(
                  //   type: type!,
                  //   sort: sort!,
                  //   lista: lista,
                  //   title: 'All Time Popular',
                  // ),
                ],
              )
        // : FetchMoreIndicator(
        //     onAction: () => controller.onLoading(context, sort!, type, lista),
        //     child: ListView.separated(
        //       // controller: controller_2,
        //       primary: true,
        //       itemBuilder: (context, index) {
        //         return Card(
        //           surfaceTintColor: Colors.blueGrey,
        //           child: itemBuilder(
        //             context,
        //             index,
        //             lista,
        //           ),
        //         );
        //       },
        //       separatorBuilder: separatorBuilder,
        //       itemCount: lista!.length,
        //       key: PageStorageKey(lista!.first.type),
        //       padding: const EdgeInsets.all(5).copyWith(left: 20, right: 20),
        //     ),
        //   ),
        );
  }
}

class CopyWidget extends StatelessWidget {
  const CopyWidget({
    Key? key,
    required this.title,
    required this.sort,
    required this.type,
    required this.lista,
    required this.refreshController,
  }) : super(key: key);

  final RefreshController refreshController;
  final List<Media>? lista;
  final String sort, type, title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SafeArea(
        child: AspectRatio(
          aspectRatio: (GetPlatform.isWeb)
              ? (MediaQuery.of(context).size.height >= 900)
                  ? (38 / 12)
                  : (16 / 12)
              : (16 / 12),
          child: Column(
            // primary: true,
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderTrends(
                title: title,
                lista: lista!,
              ),
              Trends(
                lista: lista,
                sort: sort,
                type: type,
              ),
              // const Recents()
            ],
          ),
        ),
      ),
    );
  }
}

class Trends extends StatefulWidget {
  const Trends({
    super.key,
    required this.type,
    required this.sort,
    required this.lista,
  });
  final String sort;
  final String type;
  final List<Media>? lista;

  @override
  State<Trends> createState() => _TrendsState();
}

class _TrendsState extends State<Trends> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final controller = Get.find<MangaGridSController>();

          return SmartRefresher(
            enablePullDown: false,
            enablePullUp: true,
            semanticChildCount: widget.lista!.length,
            controller: refreshController,
            onLoading: () async {
              await Future.delayed(const Duration(milliseconds: 1000));
              if (mounted) {
                // setState(() {
                controller.onLoading(
                    context, widget.sort, widget.type, widget.lista!);
                // });
              }
              refreshController.loadComplete();
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: widget.lista!.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(top: 10, left: 20),
              itemBuilder: (context, index) {
                final listaU = widget.lista![index];
                final url = listaU.coverImage!.extraLarge ??
                    listaU.coverImage!.large ??
                    listaU.coverImage!.medium ??
                    'https://convertingcolors.com/plain-1E2436.svg';
                final title = listaU.title!.english ??
                    listaU.title!.romaji ??
                    listaU.title!.native ??
                    '';

                final averageScore = ((listaU.averageScore ?? 0) / 10);
                final style = Theme.of(context).textTheme.button!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    );
                return GestureDetector(
                  onTap: () => Get.toNamed(
                    '/d',
                    arguments: listaU,
                  ),
                  child: _return(
                    constraints,
                    url,
                    title,
                    context,
                    listaU,
                    averageScore,
                    style,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Padding _return(
      BoxConstraints constraints,
      String url,
      String? title,
      BuildContext context,
      Media listaU,
      double averageScore,
      TextStyle style) {
    if (kDebugMode) {
      print(
          'maxHeight: ${constraints.maxHeight}, maxWidth: ${constraints.maxWidth},');
    }
    return Padding(
      padding: EdgeInsets.only(right: (GetPlatform.isWeb) ? 10 : 18),
      child: SizedBox(
        width: (GetPlatform.isWeb)
            ? (MediaQuery.of(context).size.height >= 900)
                ? constraints.maxWidth * .175
                : constraints.maxWidth * .355
            : constraints.maxWidth * .355,
        height:
            (GetPlatform.isWeb) ? constraints.maxHeight : constraints.maxHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Stack(
                children: [
                  BuildImageWidget(
                    filterQuality: FilterQuality.high,
                    imageUrl: url,
                    borderradius: 10,
                    fit: BoxFit.cover,
                    height: (GetPlatform.isWeb)
                        ? constraints.maxHeight
                        : constraints.maxHeight,
                    width: (GetPlatform.isWeb)
                        ? constraints.maxWidth
                        : constraints.maxWidth,
                    // height: 500,
                    // height: constraints.maxHeight,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const CardS(
                        height: 30.49,
                        width: 30.27,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.4),
                            bottomRight: Radius.circular(8.4)),
                        image: true,
                      ),
                      CardScore(
                        title: (listaU.episodes == null)
                            ? null
                            : (listaU.episodes).toString(),
                        style: style,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: (GetPlatform.isWeb) ? 5 : 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    title ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                  ),
                ),
                ClipOval(
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              dialog(context, constraints, listaU),
                        );
                      },
                      child: const SizedBox(
                        width: 19,
                        height: 19,
                        child: Center(
                          child: Icon(
                            Icons.question_mark,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 7.5),
            Row(
              children: [
                Image.asset(
                  'assets/img/AniList_logo.png',
                  height: 22,
                  width: 22,
                  cacheHeight: 60,
                  cacheWidth: 60,
                  filterQuality: FilterQuality.high,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Score: $averageScore',
                  style: style,
                ),
                const SizedBox(
                  width: 7.5,
                ),
                // Text(
                //   '# ${listaU.episodes ?? 0}',
                //   style: style.copyWith(
                //     color: Colors.cyan,
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }

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
}

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
            onTap: () => Get.to(
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
