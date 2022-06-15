import 'package:anisearch2/module/page/load_module.dart';
import 'package:flutter/material.dart';
import 'package:anisearch2/screens/mangaGrid/manga_gridS.dart'
    deferred as mangagrids_page;

class MangaGridSModule extends StatelessWidget {
  const MangaGridSModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadModule(
      library: mangagrids_page.loadLibrary(),
      module: () => mangagrids_page.MangaGridS(),
    );
  }
}
