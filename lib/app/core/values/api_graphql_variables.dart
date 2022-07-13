variablesG({
  required List<String> sort,
  required type,
  int perPage = 25,
  int page = 1,
  String? search,
}) {
  return <String, dynamic>{
    "page": page,
    "perPage": perPage,
    "type": type,
    "sort": sort,
    "search": search
  };
}

variablesS({
  required int perPage,
  required int page,
  String? search,
}) {
  return <String, dynamic>{
    "page": page,
    "perPage": perPage,
    "search": search,
  };
}

variablesByID({
  int perPage = 1,
  int page = 0,
  int? id,
}) {
  return <String, dynamic>{
    "page": page,
    "perPage": perPage,
    "id": id,
  };
}
