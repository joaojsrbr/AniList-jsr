import 'package:ani_search/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Gnav extends GetView<HomepageController> {
  const Gnav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GNav(
        key: key,
        rippleColor: Colors.grey[300]!,
        hoverColor: Colors.grey[100]!,
        gap: 8,
        activeColor: Colors.black,
        iconSize: 20,
        mainAxisAlignment: MainAxisAlignment.start,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: const Duration(milliseconds: 400),
        tabBackgroundColor: Colors.grey[100]!,
        color: Colors.white,
        onTabChange: controller.onTabchange,
        selectedIndex: controller.selectedIndex.value,
        tabs: const <GButton>[
          GButton(
            // icon: LineIcons.home,
            icon: Icons.book,
            iconActiveColor: Colors.black,
            text: 'Manga',
          ),
          GButton(
            // icon: LineIcons.home,
            icon: Icons.play_circle,
            iconActiveColor: Colors.black,
            text: 'Anime',
          ),
        ],
      ),
    );
  }
}
