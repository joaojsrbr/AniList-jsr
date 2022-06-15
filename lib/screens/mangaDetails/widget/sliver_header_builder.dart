// import 'package:flutter/material.dart';

// class SliverHeaderBuilder extends SliverPersistentHeaderDelegate {
//   final Widget Function(double percent) builder;
//   final double maxExtend;
//   final double mixExtend;
//   SliverHeaderBuilder({
//     required this.builder,
//     this.maxExtend = 100.0,
//     this.mixExtend = 100.0,
//   });

//   @override
//   Widget build(Object context, double shrinkOffset, bool overlapsContent) {
//     return builder(shrinkOffset / maxExtend);
//   }

//   @override
//   double get maxExtent => maxExtend;

//   @override
//   double get minExtent => mixExtend;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return false;
//   }
// }
