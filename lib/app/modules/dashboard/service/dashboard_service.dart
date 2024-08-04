import 'package:dio/dio.dart';
import '../../../core/providers/api.dart';

class DashboardService {
  Api api;
  DashboardService(this.api);

  Future<dynamic> getListAnime(int? page) {
    return api.getListAnime(page).then((value) {
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
