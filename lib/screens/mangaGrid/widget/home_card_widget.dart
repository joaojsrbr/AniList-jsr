// // ignore_for_file: avoid_print

// import 'package:anisearch2/api/models/api_graphql_media_model.dart';
// import 'package:anisearch2/screens/mangaDetails/utils/parse_html_to_string.dart';
// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:anisearch2/widgetU/build_image.dart';
// import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
// import 'package:get/get.dart';

// class HomeCardWidget extends StatefulWidget {
//   final Media lista;
//   const HomeCardWidget({
//     super.key,
//     required this.lista,
//   });

//   @override
//   State<HomeCardWidget> createState() => _HomeCardWidgetState();
// }

// class _HomeCardWidgetState extends State<HomeCardWidget> {
//   late ExpandableController expandableController;
//   @override
//   void initState() {
//     expandableController = ExpandableController(initialExpanded: false);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     expandableController.dispose();
//     super.dispose();
//   }

//   @override
//   void didUpdateWidget(covariant HomeCardWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     oldWidget.printInfo();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10),
//       child: AspectRatio(
//         aspectRatio: 16 / 13,
//         child: Column(
//           children: [
//             const HeaderTrends(),
//             Expanded(
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   return ListView.builder(itemBuilder: itemBuilder),
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//     // return GestureDetector(
//     //   onTap: () => Get.toNamed('/d', arguments: widget.lista),
//     //   child: Row(
//     //     crossAxisAlignment: CrossAxisAlignment.start,
//     //     children: [
//     //       BuildImageWidget(
//     //         // width: double.maxFinite,
//     //         imageUrl: (widget.lista.coverImage!.extraLarge ??
//     //             widget.lista.coverImage!.large ??
//     //             widget.lista.coverImage!.medium ??
//     //             'http://html-color.org/pt/888888.jpg'),
//     //         borderradius: 10,
//     //         // height: 250,
//     //         // width: 120,
//     //         // height: 180,
//     //         height: MediaQuery.of(context).size.height * 0.21,
//     //         width: MediaQuery.of(context).size.width * 0.3,

//     //         avatar: false,
//     //         filterQuality: FilterQuality.high,
//     //         // key: Key((lista[index].idMal!).toRadixString(2)),
//     //         colorBlendMode: BlendMode.darken,
//     //       ),
//     //       Flexible(
//     //         flex: 5,
//     //         fit: FlexFit.tight,
//     //         child: Padding(
//     //           padding: const EdgeInsets.all(4.0),
//     //           child: Wrap(
//     //             textDirection: TextDirection.ltr,
//     //             children: [
//     //               Text(
//     //                 widget.lista.title!.english ??
//     //                     widget.lista.title!.romaji ??
//     //                     widget.lista.title!.native ??
//     //                     '',
//     //                 maxLines: 2,
//     //                 // maxLines: null,
//     //                 style: const TextStyle(
//     //                     // backgroundColor: Colors.black,
//     //                     fontSize: 15,
//     //                     color: Colors.white,
//     //                     fontWeight: FontWeight.w900
//     //                     // fontWeight: FontWeight.w700,
//     //                     ),
//     //               ),
//     //               Padding(
//     //                 padding: const EdgeInsets.all(4.0),
//     //                 child: ExpandablePanel(
//     //                   controller: expandableController,
//     //                   theme: const ExpandableThemeData(
//     //                     useInkWell: true,
//     //                     iconColor: Colors.white,
//     //                   ),
//     //                   header: Text(
//     //                     parseHtmlString(widget.lista.description ?? ''),
//     //                     maxLines: 4,
//     //                     style: const TextStyle(
//     //                         // backgroundColor: Colors.black,
//     //                         fontSize: 13,
//     //                         color: Colors.white,
//     //                         fontWeight: FontWeight.w500
//     //                         // fontWeight: FontWeight.w700,
//     //                         ),
//     //                   ),
//     //                   collapsed: Text(
//     //                     parseHtmlString(widget.lista.description ?? ''),
//     //                     softWrap: true,
//     //                     maxLines: 1,
//     //                     overflow: TextOverflow.ellipsis,
//     //                   ),
//     //                   expanded: HtmlWidget(
//     //                     widget.lista.description ?? '',
//     //                     textStyle: const TextStyle(
//     //                         // backgroundColor: Colors.black,

//     //                         color: Colors.white,
//     //                         fontWeight: FontWeight.w500

//     //                         // fontWeight: FontWeight.w700,
//     //                         ),
//     //                   ),
//     //                 ),
//     //               ),
//     //               Text(
//     //                 'Rank ${(((widget.lista.averageScore) ?? 0) / 10).toDouble().toString()}',
//     //                 // maxLines: 4,
//     //                 // maxLines: null,

//     //                 style: const TextStyle(
//     //                     // backgroundColor: Colors.black,
//     //                     fontSize: 13,
//     //                     color: Colors.white,
//     //                     fontWeight: FontWeight.w700
//     //                     // fontWeight: FontWeight.w700,
//     //                     ),
//     //               ),
//     //             ],
//     //           ),
//     //         ),
//     //       )
//     // Expanded(
//     //   child: Padding(
//     //     padding: const EdgeInsets.only(top: 4.0, left: 8.0),
//     //     child: Column(
//     //       textDirection: TextDirection.ltr,
//     //       crossAxisAlignment: CrossAxisAlignment.start,
//     //       children: [
//     //         Text(
//     //           widget.lista.title!.english ??
//     //               widget.lista.title!.romaji ??
//     //               widget.lista.title!.native ??
//     //               '',
//     //           maxLines: 2,
//     //           // maxLines: null,
//     //           style: const TextStyle(
//     //               // backgroundColor: Colors.black,
//     //               fontSize: 15,
//     //               color: Colors.white,
//     //               fontWeight: FontWeight.w900
//     //               // fontWeight: FontWeight.w700,
//     //               ),
//     //         ),
//     //         Padding(
//     //           padding: const EdgeInsets.only(top: 5),
//     //           child: ExpandablePanel(
//     //             controller: expandableController,
//     //             theme: const ExpandableThemeData(
//     //               useInkWell: true,
//     //               iconColor: Colors.white,
//     //             ),
//     //             header: Text(
//     //               parseHtmlString(widget.lista.description ?? ''),
//     //               maxLines: 4,
//     //               style: const TextStyle(
//     //                   // backgroundColor: Colors.black,
//     //                   fontSize: 13,
//     //                   color: Colors.white,
//     //                   fontWeight: FontWeight.w500
//     //                   // fontWeight: FontWeight.w700,
//     //                   ),
//     //             ),
//     //             collapsed: Text(
//     //               parseHtmlString(widget.lista.description ?? ''),
//     //               softWrap: true,
//     //               maxLines: 1,
//     //               overflow: TextOverflow.ellipsis,
//     //             ),
//     //             expanded: HtmlWidget(
//     //               widget.lista.description ?? '',
//     //               textStyle: const TextStyle(
//     //                   // backgroundColor: Colors.black,

//     //                   color: Colors.white,
//     //                   fontWeight: FontWeight.w500

//     //                   // fontWeight: FontWeight.w700,
//     //                   ),
//     //             ),
//     //           ),
//     //         ),
//     //         Text(
//     //           'Rank ${(((widget.lista.averageScore) ?? 0) / 10).toDouble().toString()}',
//     //           // maxLines: 4,
//     //           // maxLines: null,

//     //           style: const TextStyle(
//     //               // backgroundColor: Colors.black,
//     //               fontSize: 13,
//     //               color: Colors.white,
//     //               fontWeight: FontWeight.w700
//     //               // fontWeight: FontWeight.w700,
//     //               ),
//     //         ),
//     //       ],
//     //     ),
//     //   ),
//     // ),
//     // ],
//     // ),
//     // );
//   }
// }

// class HeaderTrends extends StatelessWidget {
//   const HeaderTrends({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         children: [
//           Text(
//             'Trends',
//             style: Theme.of(context).textTheme.headline6!.copyWith(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//           Text(
//             'View all',
//             style: Theme.of(context).textTheme.headline6!.copyWith(
//                   color: const Color(0xFF87F5F5),
//                   fontWeight: FontWeight.w700,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }
// }
