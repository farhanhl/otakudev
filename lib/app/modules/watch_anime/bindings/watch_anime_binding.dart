import 'package:get/get.dart';
import 'package:otakudev/app/core/providers/api.dart';
import 'package:otakudev/app/modules/watch_anime/service/watch_anime_service.dart';

import '../controllers/watch_anime_controller.dart';

class WatchAnimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WatchAnimeController>(
      () => WatchAnimeController(
        WatchAnimeService(
          Get.find<Api>(),
        ),
      ),
    );
  }
}
