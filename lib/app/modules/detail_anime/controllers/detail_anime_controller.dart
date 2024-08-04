import 'package:get/get.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:otakudev/app/data/dtos/anime_info_model.dart';
import 'package:otakudev/app/data/dtos/episode_list_model.dart';
import 'package:otakudev/app/modules/detail_anime/service/detail_anime_service.dart';

class DetailAnimeController extends GetxController {
  final DetailAnimeService service;
  DetailAnimeController(this.service);
  AnimeInfo animeInfo = AnimeInfo();
  List<EpisodeList> episodeList = [];
  final arguments = Get.arguments;
  bool isLoading = false;
  bool isSuccess = true;

  @override
  void onInit() {
    super.onInit();
    List<String> parts = arguments.split("anime/");
    String detail = parts.length > 1 ? parts[1] : "";
    getDetailAnime(detail);
  }

  Future<void> getDetailAnime(String? detail) async {
    isLoading = true;
    update();

    try {
      final data = await service.getDetailAnime(detail);
      Document document = parser.parse(data);

      final image =
          document.querySelector('.fotoanime img')?.attributes['src'] ?? '';
      String title = '';
      String inJapanese = '';
      String score = '';
      String status = '';
      String totalEpisodes = '';
      String duration = '';
      List<String> genres = [];
      document.querySelectorAll('.infozingle p').forEach((element) {
        final text = element.text.split(':');
        if (text.length > 1) {
          final value = text.sublist(1).join(':').trim();
          switch (text[0].trim()) {
            case 'Judul':
              title = value;
              break;
            case 'Japanese':
              inJapanese = value;
              break;
            case 'Skor':
              score = value;
              break;
            case 'Status':
              status = value;
              break;
            case 'Total Episode':
              totalEpisodes = value;
              break;
            case 'Durasi':
              duration = value;
              break;
          }
        }
      });

      final genreElements = document.querySelectorAll('.infozingle p span a');
      genres = genreElements.map((e) => e.text.trim()).toList();
      String formattedGenres =
          genres.toString().substring(1, genres.toString().length - 1);

      animeInfo = AnimeInfo(
        title: title,
        image: image,
        inJapanese: inJapanese,
        status: status,
        score: score,
        episodes: totalEpisodes,
        duration: duration,
        genres: formattedGenres,
      );

      List<EpisodeList> episodes = [];
      document.querySelectorAll('.episodelist li').forEach((element) {
        final episodeTitle = element.querySelector('a')?.text.trim() ?? '';
        final url = element.querySelector('a')?.attributes['href'] ?? '';
        final dateParts =
            element.querySelector('.zeebr')?.text.trim().split(',') ?? [];
        final formattedDate =
            dateParts.length >= 2 ? '${dateParts[0]}, ${dateParts[1]}' : '';

        episodes.add(EpisodeList(
          id: episodes.length.toString(),
          title: episodeTitle,
          url: url,
          date: formattedDate,
        ));
      });

      episodeList.addAll(episodes);
      isLoading = false;
      isSuccess = true;
      update();
    } catch (error) {
      isLoading = false;
      isSuccess = false;
      update();
    }
  }
}
