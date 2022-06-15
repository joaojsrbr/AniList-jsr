class Title {
  String? sTypename;
  String? english;
  String? romaji;
  String? native;

  Title({this.sTypename, this.english, this.romaji, this.native});

  Title.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    english = json['english'];
    romaji = json['romaji'];
    native = json['native'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['__typename'] = sTypename;
    data['english'] = english;
    data['romaji'] = romaji;
    data['native'] = native;
    return data;
  }
}
