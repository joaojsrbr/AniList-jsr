// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:ani_search/i18n/repositories/locale_provider.dart';
import 'package:ani_search/screens/home/hero/hero_image.dart';
import 'package:ani_search/screens/home/hero/hero_row_score.dart';
import 'package:ani_search/screens/home/hero/hero_title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:provider/provider.dart';

Size _viewportSize = Size.zero;

extension on num {
  double get vw => _viewportSize.width * (this);
  double get vwp => _viewportSize.width * (this / 100);
  double get vh => _viewportSize.height * (this);
}

class MangaDetailsR extends StatefulWidget {
  const MangaDetailsR({super.key});

  @override
  State<MangaDetailsR> createState() => _MangaDetailsRState();
}

class _MangaDetailsRState extends State<MangaDetailsR>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _viewportSize = constraints.biggest;

        final w = _viewportSize.height;

        final h = _viewportSize.width;

        final dataProvider =
            ModalRoute.of(context)!.settings.arguments as Media;

        if (kDebugMode) {
          print(
              'id: ${dataProvider.idr} -- title: ${dataProvider.title!.english ?? dataProvider.title!.romaji ?? dataProvider.title!.native ?? ''}\n');
        }

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                Consumer<LocaleProvider>(
                  builder: (context, value, child) => SliverAppBar(
                    pinned: true,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    // collapsedHeight: .1.vh,
                    expandedHeight: .75.vh,
                    bottom: TabBar(
                      indicatorWeight: 1,
                      isScrollable: true,
                      controller: tabController,
                      tabs: value.tabs
                          .map(
                            (e) => Tab(
                              child: Text(
                                e,
                                // overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: SafeArea(
                        child: Container(
                          padding: EdgeInsets.only(top: .12.vw),
                          child: LayoutGrid(
                            columnGap: 0.004.vwp,
                            rowGap: 0.9.vwp,
                            // columnGap: 12,
                            // rowGap: 12,
                            columnSizes: repeat(2, [1.fr]),

                            rowSizes: repeat(2, [auto]),
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: .03.vw),
                                child: ImageGrid(
                                  h: h,
                                  w: w,
                                  dataProvider: dataProvider,
                                ),
                              ).withGridPlacement(
                                columnStart: 0,
                                rowStart: 0,
                              ),
                              TextGrid(dataProvider: dataProvider)
                                  .withGridPlacement(
                                columnStart: 1,
                                rowStart: 0,
                              ),
                              Container(
                                // color: Colors.black,
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 8),
                                height: .30.vh,
                                // child: TextGrid(dataProvider: dataProvider),
                                child: ListView(
                                  children: [
                                    HtmlWidget(
                                      dataProvider.description!,
                                      enableCaching: true,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                            color: Colors.grey[400],
                                            fontSize: 13,
                                          ),
                                    ),
                                  ],
                                ),
                              ).withGridPlacement(
                                columnStart: 0,
                                rowStart: 1,
                                columnSpan: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                Container(),
                Container(),
                Container(),
                Container(),
                Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TextGrid extends StatelessWidget {
  const TextGrid({
    super.key,
    required this.dataProvider,
  });

  final Media dataProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HeroTitle(
            media: dataProvider,
          ),
          HeroRowScore(
            dataProvider: dataProvider,
          ),
          // Container(
          //   color: Colors.black,
          //   child: Text(
          //     dataProvider.description!,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ImageGrid extends StatelessWidget {
  const ImageGrid({
    super.key,
    required this.h,
    required this.w,
    required this.dataProvider,
  });

  final double h;
  final double w;
  final Media dataProvider;

  @override
  Widget build(BuildContext context) {
    return HeroImage(
      h: h,
      w: w,
      dataProvider: dataProvider,
    );
  }
}
