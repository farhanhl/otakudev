class EpisodeList {
  String? id;
  String? title;
  String? date;
  String? url;

  EpisodeList({this.id, this.title, this.date, this.url});

  EpisodeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['date'] = date;
    data['url'] = url;
    return data;
  }
}
