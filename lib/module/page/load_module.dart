import 'package:flutter/material.dart';

class LoadModule extends StatelessWidget {
  final Future<dynamic> library;
  final dynamic module;
  const LoadModule({
    super.key,
    required this.library,
    required this.module,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: library,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return module();
          } else {
            return Container();
          }

          // return module();
        },
      ),
    );
  }
}
