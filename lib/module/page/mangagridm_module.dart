import 'package:anisearch2/module/page/load_module.dart';
import 'package:flutter/material.dart';
import 'package:anisearch2/screens/mangaGrid/manga_gridM.dart'
    deferred as mangagridm_page;

class MangaGridMModule extends StatelessWidget {
  const MangaGridMModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadModule(
      library: mangagridm_page.loadLibrary(),
      module: () => mangagridm_page.MangaGridM(),
    );
  }
}
