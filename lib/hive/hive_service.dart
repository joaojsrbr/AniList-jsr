// import 'package:ani_search/hive/models/grid.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:hive/hive.dart';

// class HiveService extends ChangeNotifier {
//   final String gHiveBox = 'grid-box';

//   GridModel _select = GridModel(select: 0);

//   GridModel get select => _select;

//   HiveService() {
//     oninit();
//   }

//   Future<void> oninit() async {
//     Box<GridModel> box = await Hive.openBox<GridModel>(gHiveBox);

//     _select = box.values.first ?? GridModel(select: 0);
//     notifyListeners();
//   }
// }
