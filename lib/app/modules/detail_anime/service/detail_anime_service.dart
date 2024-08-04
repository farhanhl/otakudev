import 'package:dio/dio.dart';
import '../../../core/providers/api.dart';

class DetailAnimeService {
  Api api;
  DetailAnimeService(this.api);

  Future<dynamic> getDetailAnime(String? detail) {
    return api.getDetailAnime(detail).then((value) {
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
