// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:anisearch2/api/models/api_graphql_media_model.dart';
import 'package:anisearch2/screens/mangaDetails/models/list_type.dart';
import 'package:anisearch2/scroll/scrollbehavior.dart';
// import 'package:anisearch2/screens/mangaDetails/widget/colored_tabbar.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:anisearch2/widgetU/build_image.dart';

import 'package:get/get.dart';

class MangaDetailsRBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MangaDetailsRController>(MangaDetailsRController());
  }
}

class MangaDetailsRController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late ExpandableController expandedController;
  late ScrollController scrollController;
  late TabController tabController;
  // final GlobalKey<NestedScrollViewState> globalKey = GlobalKey();
  @override
  void onInit() {
    tabController = TabController(
      length: 5,
      vsync: this,
      animationDuration: const Duration(milliseconds: 500),
    );
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   globalKey.currentState!.innerController.addListener(() {
    //     print('notify');
    //   });
    // });
    expandedController = ExpandableController(initialExpanded: false);
    scrollController = ScrollController();
    super.onInit();
  }

  @override
  void onClose() {
    expandedController.dispose();
    // scrollController.dispose();
    tabController.dispose();
    super.onClose();
  }
}

class MangaDetailsR extends GetView<MangaDetailsRController> {
  const MangaDetailsR({Key? key}) : super(key: key);

  // late ExpandableController _expandableController;
  // late ScrollController _scrollController;
  // late ScrollController _singleController;
  // late LinkedScrollControllerGroup _controllerGroup;
  // final GlobalKey<NestedScrollViewState> globalKey = GlobalKey();
  // late TabController _tabController;
  // @override
  // void initState() {
  //   _tabController = TabController(
  //     length: 5,
  //     vsync: this,
  //   );

  //   _expandableController = ExpandableController(initialExpanded: false);
  //   _scrollController = ScrollController();
  //   // SingleChildScrollW(
  //   //   parentController: _scrollController,
  //   // );
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _expandableController.dispose();
  //   _scrollController.dispose();
  //   _tabController.dispose();
  //   super.dispose();
  // }

  // @override
  // void didUpdateWidget(covariant MangaDetailsR oldWidget) {
  //   _expandableController.expanded;
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    // final loadProvider = Provider.of<Apitest>(context);
    // final dataProvider = Provider.of<ApiProvider>(context).searchdetails;
    final dataProvider = ModalRoute.of(context)!.settings.arguments as Media;

    // const main = Key('Main');

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: NestedScrollView(
        scrollDirection: Axis.vertical,

        // controller: ScrollController(),
        // controller: _scrollController,
        controller: controller.scrollController,
        physics: const ScrollPhysics(parent: PageScrollPhysics()),
        scrollBehavior: MyScrollBehavior(),
        // physics: ClampingScrollPhysics(),
        body: TabBarView(
          controller: controller.tabController,
          children: [
            Container(
              color: Colors.transparent,
            ),
            Container(
              color: Colors.transparent,
            ),
            Container(
              color: Colors.transparent,
            ),
            Container(
              color: Colors.transparent,
            ),
            Container(
              color: Colors.transparent,
            ),
          ],
        ),
        headerSliverBuilder: (ctx, main) => [
          SliverAppBar(
            surfaceTintColor: Theme.of(context).colorScheme.background,
            pinned: true,
            leading: const BackButton(
              color: Colors.white,
            ),
            expandedHeight: controller.expandedController.expanded
                ? MediaQuery.of(context).size.height * .92
                : MediaQuery.of(context).size.height * .92,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Stack(
                children: [
                  BuildImageWidget(
                    filterQuality: FilterQuality.high,
                    colorBlendMode: BlendMode.dstIn,
                    colors: withOpacity
                        .map(
                          (e) => Theme.of(context)
                              .colorScheme
                              .background
                              .withOpacity(e),
                        )
                        .toList(),
                    height: MediaQuery.of(context).size.height * 1,
                    width: MediaQuery.of(context).size.width * 1,
                    colorfilter: true,
                    fit: GetPlatform.isWeb ? BoxFit.cover : BoxFit.fitHeight,
                    imageUrl: dataProvider.bannerImage ??
                        dataProvider.coverImage!.extraLarge ??
                        dataProvider.coverImage!.large ??
                        dataProvider.coverImage!.medium ??
                        'https://convertingcolors.com/plain-1E2436.svg',
                  ),
                  _TestViewState(
                    scrollController: controller.scrollController,
                  )
                  // SingleChildScrollW(
                  //   dataProvider: dataProvider,
                  //   parentController: controller.scrollController,
                  //   expandableController: controller.expandedController,
                  // ),
                ],
              ),
            ),
            bottom: TabBar(
              isScrollable: true,
              indicatorWeight: 2.0,
              // physics: const BouncingScrollPhysics(),
              controller: controller.tabController,
              tabs: tablistString
                  .map<Tab>(
                    (e) => Tab(
                      child: Text(
                        e,
                        style: const TextStyle(
                          fontSize: 15.5,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TestViewState extends StatefulWidget {
  ScrollController scrollController;
  _TestViewState({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<_TestViewState> createState() => __TestViewStateState();
}

class __TestViewStateState extends State<_TestViewState>
    with AutomaticKeepAliveClientMixin<_TestViewState> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        // HEY!! LISTEN!!
        // this will set controller1's offset the same as controller2's
        // if (_scrollController.offset >= 550) {
        //   widget.scrollController
        //       .jumpTo(widget.scrollController.position.maxScrollExtent);
        //   _scrollController.jumpTo(widget.scrollController.offset);
        // }
        // if (widget.scrollController.offset ==
        //     widget.scrollController.position.minScrollExtent) {
        //   _scrollController
        //       .jumpTo(widget.scrollController.position.minScrollExtent);
        // }
        // if (_scrollController.position.pixels == 0) {
        //   widget.scrollController.jumpTo(0);
        // }

        widget.scrollController.jumpTo(_scrollController.offset / 1.5);

        // you can check both offsets in terminal
        if (kDebugMode) {
          print(
              'check -- offset Left: ${widget.scrollController.offset.toInt()} -- offset Right: ${_scrollController.offset.toInt()}');
        }
        return false;
      },
      child: ListView(
        key: UniqueKey(), controller: _scrollController,
        // primary: true,
        children: const [
          ListTile(),
        ],
      ),
    );
  }
}
