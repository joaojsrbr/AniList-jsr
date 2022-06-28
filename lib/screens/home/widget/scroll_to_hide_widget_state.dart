// import 'package:flutter/material.dart';

// class ScrollToHideWidgetState extends StatefulWidget {
//   final Widget child;
//   final Duration duration;
//   final ScrollController scrollController;
//   final double height;
//   const ScrollToHideWidgetState(
//       {required this.child,
//       required this.scrollController,
//       this.duration = const Duration(milliseconds: 200),
//       this.height = kBottomNavigationBarHeight,
//       super.key});

//   @override
//   State<ScrollToHideWidgetState> createState() =>
//       _ScrollToHideWidgetStateState();
// }

// class _ScrollToHideWidgetStateState extends State<ScrollToHideWidgetState> {
//   bool isVisible = true;
//   @override
//   void initState() {
//     super.initState();
//     widget.scrollController.addListener(listen);
//   }

//   void listen() {
//     if (widget.scrollController.position.pixels >= 68) {
//       hide();
//     } else {
//       show();
//     }
//   }

/*red  
*/

//   // void listen() {
//   //   final direction = widget.controller.position.userScrollDirection;
//   //   if (direction == ScrollDirection.forward) {
//   //     show();
//   //   } else if (direction == ScrollDirection.reverse) {
//   //     hide();
//   //   }
//   // }

//   void show() {
//     if (!isVisible) {
//       setState(() {
//         isVisible = true;
//       });
//     }
//   }

//   void hide() {
//     if (isVisible) {
//       setState(() {
//         isVisible = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: widget.duration,
//       height: isVisible ? widget.height : 0,
//       child: Wrap(
//         children: [widget.child],
//       ),
//     );
//   }
// }
