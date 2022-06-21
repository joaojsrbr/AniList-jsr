import 'package:anisearch2/module/page/load_module.dart';
import 'package:flutter/material.dart';
import 'package:anisearch2/screens/grid/manga_gridM.dart'
    deferred as mangagridm_page;

class GridMModule extends StatelessWidget {
  const GridMModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadModule(
      library: mangagridm_page.loadLibrary(),
      module: () => mangagridm_page.MangaGridM(),
    );
  }
}
