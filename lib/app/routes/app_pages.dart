import 'package:get/get.dart';

import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/detail_anime/bindings/detail_anime_binding.dart';
import '../modules/detail_anime/views/detail_anime_view.dart';
import '../modules/watch_anime/bindings/watch_anime_binding.dart';
import '../modules/watch_anime/views/watch_anime_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ANIME,
      page: () => const DetailAnimeView(),
      binding: DetailAnimeBinding(),
    ),
    GetPage(
      name: _Paths.WATCH_ANIME,
      page: () => const WatchAnimeView(),
      binding: WatchAnimeBinding(),
    ),
  ];
}
