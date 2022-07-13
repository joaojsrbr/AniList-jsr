class CoverImage {
  String? large;
  String? extraLarge;
  String? medium;
  String? color;

  CoverImage({this.large, this.extraLarge, this.medium, this.color});

  CoverImage.fromJson(Map<String, dynamic> json) {
    large = json['large'];
    extraLarge = json['extraLarge'];
    medium = json['medium'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['large'] = large;
    data['extraLarge'] = extraLarge;
    data['medium'] = medium;
    data['color'] = color;
    return data;
  }
}
