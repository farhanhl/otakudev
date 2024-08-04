import 'package:get/get.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:otakudev/app/data/dtos/anime_info_model.dart';
import 'package:otakudev/app/data/dtos/download_model.dart';
import 'package:otakudev/app/modules/watch_anime/service/watch_anime_service.dart';

class WatchAnimeController extends GetxController {
  bool isLoading = false;
  List<DownloadOption> downloadModel = [];
  AnimeInfo animeInfo = AnimeInfo();
  final arguments = Get.arguments;
  final WatchAnimeService service;
  WatchAnimeController(this.service);
  late String iframeUrl;

  @override
  void onInit() {
    super.onInit();
    animeInfo = arguments['animeInfo'];
    List<String> parts = arguments['episodeUrl'].split("episode/");
    String episode = parts.length > 1 ? parts[1] : "";
    getDetailWatchAnime(episode);
  }

  Future<void> getDetailWatchAnime(String episode) async {
    isLoading = true;
    update();
    try {
      final data = await service.getDetailWatchAnime(episode);
      Document document = parser.parse(data);

      final embedElement = document.querySelector('.player-embed');
      if (embedElement != null) {
        iframeUrl = embedElement.outerHtml;
      }

      final List<DownloadOption> downloadOption = [];
      final elements = document.querySelectorAll('.download ul li');
      for (var element in elements) {
        final qualityText = element.querySelector('strong')?.text ?? '';
        final parts = qualityText.split(' ');
        final format = parts.isNotEmpty ? parts[0] : '';
        final quality = parts.length > 1 ? parts[1] : '';

        final List<Link> links = [];
        element.querySelectorAll('a').forEach((el) {
          links.add(Link(
            server: el.text.trim(),
            url: el.attributes['href'] ?? '',
          ));
        });

        final size = element.querySelector('i')?.text ?? '';
        downloadOption.add(DownloadOption(
          format: format,
          quality: quality,
          links: links,
          size: size,
        ));
      }

      downloadModel.addAll(downloadOption);
      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
    }
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
