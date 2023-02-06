class SliderImageModel {
  SliderImageModel({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,});

  SliderImageModel.fromJson(dynamic json) {
    id = json['id'];
    author = json['author'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    downloadUrl = json['download_url'];
  }

  String? id;
  String? author;
  int? width;
  int? height;
  String? url;
  String? downloadUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['author'] = author;
    map['width'] = width;
    map['height'] = height;
    map['url'] = url;
    map['download_url'] = downloadUrl;
    return map;
  }

}