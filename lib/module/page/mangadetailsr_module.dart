import 'package:anisearch2/module/page/load_module.dart';
import 'package:flutter/material.dart';
import 'package:anisearch2/screens/mangaDetails/manga_details.dart'
    deferred as mangadetailsr_page;

class MangaDetailsRModule extends StatelessWidget {
  const MangaDetailsRModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadModule(
      library: mangadetailsr_page.loadLibrary(),
      module: () => mangadetailsr_page.MangaDetailsR(),
    );
  }
}
