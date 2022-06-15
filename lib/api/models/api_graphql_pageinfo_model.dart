class PageInfo {
  String? sTypename;
  int? total;
  int? currentPage;
  int? lastPage;
  bool? hasNextPage;
  int? perPage;

  PageInfo(
      {this.sTypename,
      this.total,
      this.currentPage,
      this.lastPage,
      this.hasNextPage,
      this.perPage});

  PageInfo.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    total = json['total'];
    currentPage = json['currentPage'];
    lastPage = json['lastPage'];
    hasNextPage = json['hasNextPage'];
    perPage = json['perPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['__typename'] = sTypename;
    data['total'] = total;
    data['currentPage'] = currentPage;
    data['lastPage'] = lastPage;
    data['hasNextPage'] = hasNextPage;
    data['perPage'] = perPage;
    return data;
  }
}
