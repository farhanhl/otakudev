import 'package:get/get.dart';
import 'package:otakudev/app/core/providers/api.dart';
import 'package:otakudev/app/modules/detail_anime/service/detail_anime_service.dart';

import '../controllers/detail_anime_controller.dart';

class DetailAnimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailAnimeController>(
      () => DetailAnimeController(
        DetailAnimeService(
          Get.find<Api>(),
        ),
      ),
    );
  }
}
