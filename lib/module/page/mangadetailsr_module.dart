import 'package:ani_search/module/page/load_module.dart';
import 'package:flutter/material.dart';
import 'package:ani_search/screens/details/details_page.dart'
    deferred as mangadetailsr_page;

class DetailsRModule extends StatelessWidget {
  const DetailsRModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadModule(
      library: mangadetailsr_page.loadLibrary(),
      module: () => mangadetailsr_page.MangaDetailsR(),
    );
  }
}
