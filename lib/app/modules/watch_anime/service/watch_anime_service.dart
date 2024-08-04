import 'package:dio/dio.dart';
import '../../../core/providers/api.dart';

class WatchAnimeService {
  Api api;
  WatchAnimeService(this.api);

  Future<dynamic> getDetailWatchAnime(String? detail) {
    return api.getDetailWatchAnime(detail).then((value) {
      return value.data;
    }).catchError(
      (e) {
        throw Exception(e.runtimeType == DioException
            ? e.error.toString()
            : "Something went wrong");
      },
    );
  }
}
