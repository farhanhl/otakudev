class AnimeList {
  String? id;
  String? title;
  String? image;
  String? url;

  AnimeList({this.id, this.title, this.image, this.url});

  AnimeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['url'] = url;
    return data;
  }
}
