import 'package:ani_search/module/page/load_module.dart';
import 'package:flutter/material.dart';
import 'package:ani_search/screens/home/page/home_page.dart'
    deferred as homepage_page;

class HomepageModule extends StatelessWidget {
  const HomepageModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadModule(
      library: homepage_page.loadLibrary(),
      module: () => homepage_page.Homepage(),
    );
  }
}
