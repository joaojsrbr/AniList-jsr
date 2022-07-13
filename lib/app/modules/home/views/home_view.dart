// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';

import 'package:ani_search/app/modules/home/controllers/home_controller.dart';
import 'package:ani_search/app/modules/home/widgets/home_export_widgets.dart';
import 'package:ani_search/app/core/themes/app_colors.dart';

class Homepage extends GetView<HomepageController> {
  const Homepage({
    super.key,
  });

  Key typeScrollableKey(dynamic primaryIndex) =>
      PageStorageKey('${controller.type.value}-$primaryIndex');

  @override
  Widget build(BuildContext context) {
    sliverappbar1() {
      return SliverAppBar(
        backgroundColor: AppColors().background(context),
        surfaceTintColor: AppColors().background(context),
        actions: actions(context, controller.manga),
        floating: false,
      );
    }

    final double heightp = (MediaQuery.of(context).size.height * .045);

    const EdgeInsets padding = EdgeInsets.all(3.5);

    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: AppColors().background(context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LoadingMoreCustomScrollView(
          controller: controller.scrollController,
          rebuildCustomScrollView: true,
          slivers: [
            sliverappbar1(),
            SliverPersistentHeader(
              pinned: false,
              floating: true,
              delegate: DelegatePageHeader(
                vsync: controller,
                maxExtent: 60,
                minExtent: 60,
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  color: AppColors().background(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Gnav(
                        key: ObjectKey(controller.selectedIndex.value),
                      ),
                      SelectButton(
                        // key: ObjectKey(
                        //     'SelectButton-#${controller.selectedIndex.value}'),
                        onPressed: controller.selectOne,
                        config: SelectButtonConfig(
                          normal: false,
                          initvalue: 0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        constraints: const BoxConstraints(
                          maxHeight: 80,
                          minHeight: 20,
                          maxWidth: 40,
                          minWidth: 20,
                        ),
                        children: [
                          Container(
                            padding: padding,
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * .045,
                            child: Image.asset(
                              'assets/img/image.png',
                              cacheWidth: 53,
                              cacheHeight: 83,
                            ),
                          ),
                          Container(
                            padding: padding,
                            alignment: Alignment.center,
                            height: heightp,
                            child: Image.asset(
                              'assets/img/image3.png',
                              cacheWidth: 53,
                              cacheHeight: 83,
                            ),
                          ),
                          Container(
                            padding: padding,
                            alignment: Alignment.center,
                            height: heightp,
                            child: Image.asset(
                              'assets/img/image4.png',
                              cacheWidth: 53,
                              cacheHeight: 83,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GetBuilder<HomepageController>(
              id: #LoadingMoreSliverList,
              builder: (controller) => LoadingMoreSliverList(
                key: PageStorageKey(controller.type.value),
                SliverListConfig<Media>(
                  indicatorBuilder: (context, status) => indicatorBuilder(
                    context,
                    status,
                    controller.manga.value
                        ? controller.mangaRepository
                        : controller.animeRepository,
                  ),
                  gridDelegate: controller.gridDelegate,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  itemBuilder: itemBuilder,
                  sourceList: controller.manga.value
                      ? controller.mangaRepository
                      : controller.animeRepository,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DelegatePageHeader extends SliverPersistentHeaderDelegate {
  DelegatePageHeader({
    required this.maxExtent,
    required this.minExtent,
    required this.child,
    required this.vsync,
  }) : super();

  final Widget child;
  @override
  final double minExtent;
  @override
  final double maxExtent;
  @override
  final TickerProvider vsync;

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration =>
      FloatingHeaderSnapConfiguration(
        curve: Curves.linear,
        duration: const Duration(milliseconds: 100),
      );

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
