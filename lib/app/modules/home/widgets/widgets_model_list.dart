import 'package:ani_search/app/modules/home/widgets/my_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildSheet() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5,
        minChildSize: 0.5,
        maxChildSize: 0.6,
        // maxChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              controller: scrollController,
            ),
          ),
        ),
      ),
    );

// NavigationBar widgfuc(
//     BuildContext context, int indexscreen, void Function(int) fucDS) {
//   return NavigationBar(
//     selectedIndex: indexscreen,
//     onDestinationSelected: (v) => fucDS(v),
//     // height: 75,
//     backgroundColor: Theme.of(context).colorScheme.background,
//     labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
//     destinations: ListWidget().destinations(context),
//   );
// }

// List<Widget> destinations(BuildContext context) => const [
//       NavigationDestination(
//         selectedIcon: Icon(
//           Icons.book_rounded,
//         ),
//         label: "Manga",
//         icon: Icon(
//           Icons.book_outlined,
//         ),
//       ),
//       NavigationDestination(
//         selectedIcon: Icon(Icons.favorite),
//         label: "Anime",
//         icon: Icon(Icons.favorite_outline),
//       ),
//     ];

List<Widget> actions(BuildContext context, RxBool manga) => <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Material(
          type: MaterialType.button,
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.background,
          child: IconButton(
            // autofocus: true,
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearchDelegate(),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Material(
          clipBehavior: Clip.antiAlias,
          type: MaterialType.button,
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.background,
          child: IconButton(
            // autofocus: true,
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                // isScrollControlled: true,
                context: context,
                // shape: const RoundedRectangleBorder(
                //   borderRadius: BorderRadius.vertical(
                //     top: Radius.circular(20),
                //   ),
                // ),
                // isScrollControlled: true,
                builder: (context) => buildSheet(),
              );
            },
            icon: const Icon(Icons.filter_list_rounded),
          ),
        ),
      ),
    ];
