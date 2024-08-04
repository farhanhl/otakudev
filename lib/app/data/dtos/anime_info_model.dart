class AnimeInfo {
  String? title;
  String? image;
  String? inJapanese;
  String? status;
  String? score;
  String? episodes;
  String? duration;
  String? genres;

  AnimeInfo(
      {this.title,
      this.image,
      this.inJapanese,
      this.status,
      this.score,
      this.episodes,
      this.duration,
      this.genres});

  AnimeInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    inJapanese = json['in_japanese'];
    status = json['status'];
    score = json['score'];
    episodes = json['episodes'];
    duration = json['duration'];
    genres = json['genres'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['image'] = image;
    data['in_japanese'] = inJapanese;
    data['status'] = status;
    data['score'] = score;
    data['episodes'] = episodes;
    data['duration'] = duration;
    data['genres'] = genres;
    return data;
  }
}
