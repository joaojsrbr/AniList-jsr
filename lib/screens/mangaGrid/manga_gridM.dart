// ignore_for_file: file_names
import 'dart:ui' as ui;
import 'package:anisearch2/api/models/api_graphql_media_model.dart';
import 'package:anisearch2/api/models/api_graphql_pageinfo_model.dart';
import 'package:anisearch2/screens/mangaDetails/manga_details.dart';
import 'package:anisearch2/screens/mangaGrid/controller/controller.dart';
import 'package:anisearch2/screens/mangaGrid/manga_gridS.dart';
import 'package:anisearch2/widgetU/build_image.dart';

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

  const MangaGridM({
    super.key,
    this.pageInfo,
    this.scrollController,
    this.search = false,
    this.sort,
    this.type,
    this.lista,
  });

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
  }) : super(key: key);

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
                  ? (38 / 16)
                  : (8 / 10.5)
              : (8 / 10.5),
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
  late final PageController _movieCardPageController;
  // late final PageController _movieDetailPageController;
  double _movieCardPage = 0.0;
  final _showMovieDetails = ValueNotifier(true);
  int _movieCardIndex = 0;

  _movieCardPagePercentListener() {
    setState(() {
      _movieCardPage = _movieCardPageController.page!;
      _movieCardIndex = _movieCardPageController.page!.round();
    });
  }

  @override
  void initState() {
    _movieCardPageController = PageController(viewportFraction: 0.77)
      ..addListener(_movieCardPagePercentListener);

    super.initState();
    super.initState();
  }

  @override
  void dispose() {
    _movieCardPageController
      ..removeListener(_movieCardPagePercentListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final controller = Get.find<MangaGridSController>();

          return PageView.builder(
            onPageChanged: (value) {
              if (value + 1 == widget.lista!.length) {
                if (mounted) {
                  controller.onLoading(
                      context, widget.sort, widget.type, widget.lista!);
                }
              }
            },
            clipBehavior: Clip.none,
            controller: _movieCardPageController,
            physics: const BouncingScrollPhysics(),
            // onPageChanged: (page) {
            //   _movieDetailPageController.animateToPage(
            //     page,
            //     duration: const Duration(milliseconds: 500),
            //     curve: const Interval(0.25, 1, curve: Curves.decelerate),
            //   );
            // },

            itemCount: widget.lista!.length,
            scrollDirection: Axis.horizontal,
            // padding: const EdgeInsets.only(top: 10, left: 20),
            itemBuilder: (context, index) {
              final progress = (_movieCardPage - index);
              final scale = ui.lerpDouble(1, .8, progress.abs())!;
              final listaU = widget.lista![index];

              String _url() {
                final urlA = listaU.coverImage!.extraLarge ??
                    listaU.coverImage!.large ??
                    listaU.coverImage!.medium ??
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

              // final url = listaU.coverImage!.extraLarge ??
              //     listaU.coverImage!.large ??
              //     listaU.coverImage!.medium ??
              //     'https://convertingcolors.com/plain-1E2436.svg';

              final title = listaU.title!.english ??
                  listaU.title!.romaji ??
                  listaU.title!.native ??
                  '';

              final isCurrentPage = index == _movieCardIndex;
              final isScrolling =
                  _movieCardPageController.position.isScrollingNotifier.value;
              final isFirstPage = index == 0;

              final averageScore = ((listaU.averageScore ?? 0) / 10);
              final style = Theme.of(context).textTheme.button!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  );
              return Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Transform.scale(
                  alignment: Alignment.lerp(
                    Alignment.centerLeft,
                    Alignment.center,
                    -progress,
                  ),
                  scale: isScrolling && isFirstPage ? 1 - progress : scale,
                  child: GestureDetector(
                    onTap: () {
                      _showMovieDetails.value = !_showMovieDetails.value;
                      const transitionDuration = Duration(milliseconds: 550);
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          settings: RouteSettings(
                            arguments: listaU,
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
                      Future.delayed(transitionDuration, () {
                        _showMovieDetails.value = !_showMovieDetails.value;
                      });
                    },
                    // onTap: () => Get.toNamed(
                    //   '/d',
                    //   arguments: listaU,
                    // ),
                    child: _return(
                      constraints,
                      _url(),
                      title,
                      context,
                      listaU,
                      averageScore,
                      style,
                      isCurrentPage,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Padding _return(
    BoxConstraints constraints,
    String url,
    String title,
    BuildContext context,
    Media listaU,
    double averageScore,
    TextStyle style,
    isCurrentPage,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        right: (GetPlatform.isWeb) ? 10 : 18,
      ),
      child: SizedBox(
        width: (GetPlatform.isWeb)
            ? (MediaQuery.of(context).size.height >= 900)
                // ? constraints.maxWidth * .055
                ? constraints.maxWidth
                : constraints.maxWidth * .355
            : constraints.maxWidth * .020,
        height: (GetPlatform.isWeb)
            ? (MediaQuery.of(context).size.height >= 900)
                ? constraints.maxHeight
                : constraints.maxHeight
            : constraints.maxHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: listaU.id!,
                child: Material(
                  type: MaterialType.transparency,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        transform: Matrix4.identity()
                          ..translate(
                            isCurrentPage ? 0.0 : -20.0,
                            isCurrentPage ? 0.0 : 60.0,
                          ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 25,
                              offset: const Offset(0, 25),
                              color: Colors.black.withOpacity(.12),
                            ),
                          ],
                        ),
                        child: BuildImageWidget(
                          filterQuality: FilterQuality.high,
                          imageUrl: url,
                          borderradius: 8.7,
                          fit: (GetPlatform.isWeb)
                              ? (MediaQuery.of(context).size.height >= 900)
                                  ? BoxFit.cover
                                  : BoxFit.cover
                              : BoxFit.cover,
                          height: (GetPlatform.isWeb)
                              ? constraints.maxHeight
                              : constraints.maxHeight,
                          width: (GetPlatform.isWeb)
                              ? constraints.maxWidth
                              : constraints.maxWidth,
                          // height: 500,
                          // height: constraints.maxHeight,
                        ),
                      ),
                      Positioned(
                        width: 40,
                        height: 40,
                        bottom: -0.5,
                        left: -0.5,
                        child: AnimatedContainer(
                          curve: Curves.bounceIn,
                          transform: Matrix4.identity()
                            ..translate(
                              isCurrentPage ? 0.0 : -20.0,
                              isCurrentPage ? 0.0 : 60.0,
                            ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(70),
                            ),
                          ),
                          duration: const Duration(milliseconds: 300),
                          child: const CardS(
                            height: 40,
                            width: 40,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(7.5),
                            ),
                            image: true,
                          ),
                        ),
                      ),
                      Positioned(
                        height: 40,
                        width: 40,
                        right: -0.5,
                        bottom: -0.5,
                        child: Material(
                          type: MaterialType.transparency,
                          child: AnimatedContainer(
                            curve: Curves.bounceIn,
                            transform: Matrix4.identity()
                              ..translate(
                                isCurrentPage ? 0.0 : -20.0,
                                isCurrentPage ? 0.0 : 60.0,
                              ),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(70),
                              ),
                            ),
                            duration: const Duration(milliseconds: 300),
                            child: CardScore(
                              title: (listaU.episodes == null)
                                  ? null
                                  : (listaU.episodes).toString(),
                              style: style,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: (GetPlatform.isWeb) ? 5 : 15),
            Hero(
              tag: title,
              child: Material(
                type: MaterialType.transparency,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                        maxLines: 1,
                      ),
                    ),
                    ClipOval(
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
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 7.5),
            Material(
              type: MaterialType.transparency,
              child: Hero(
                tag: listaU.recommendations!,
                child: Row(
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
                  ],
                ),
              ),
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
