import 'package:dio/dio.dart';

const baseUrl = 'https://otakudesu.cloud/';

class Api {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<Response> getListAnime(int? page) {
    return dio.get(
      "ongoing-anime/page/$page/",
    );
  }

  Future<Response> getDetailAnime(String? detail) {
    return dio.get("anime/$detail");
  }

  Future<Response> getDetailWatchAnime(String? episode) {
    return dio.get("episode/$episode");
  }
}
