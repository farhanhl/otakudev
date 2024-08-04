import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:otakudev/app/widgets/shimmer.dart';
import 'package:otakudev/app/theme/app_theme.dart';
import 'package:otakudev/app/widgets/richtext.dart';
import '../controllers/detail_anime_controller.dart';
import 'package:otakudev/app/core/providers/api.dart';
import 'package:otakudev/app/widgets/menu_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:otakudev/app/modules/detail_anime/service/detail_anime_service.dart';

class DetailAnimeView extends GetView<DetailAnimeController> {
  const DetailAnimeView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailAnimeController>(
      init: DetailAnimeController(
        DetailAnimeService(
          Get.find<Api>(),
        ),
      ),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              controller.animeInfo.title ?? "Title",
              style: const TextStyle(
                color: lightColor,
              ),
            ),
            backgroundColor: primaryColor,
            centerTitle: true,
            leading: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
              child: IconButton(
                icon: const Icon(
                  FontAwesomeIcons.chevronLeft,
                  color: lightColor,
                  size: 20,
                ),
                onPressed: () => Get.back(),
                tooltip: "Back",
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  controller.isLoading
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                "assets/lotties/loading.json",
                                width: 200.w,
                                height: 200.h,
                              ),
                              const Text(
                                "Memuat detail anime...",
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        )
                      : Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CachedNetworkImage(
                                      imageUrl: '${controller.animeInfo.image}',
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) {
                                        return ShimmerWidget.rectangular(
                                          width: 50.w,
                                          height: 50.h,
                                        );
                                      },
                                      errorWidget: ((context, url, error) {
                                        return Lottie.asset(
                                          "assets/lotties/failed.json",
                                          width: 50.w,
                                          height: 50.h,
                                        );
                                      }),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        AnimeInfoText.text(
                                          "Japanese",
                                          "${controller.animeInfo.inJapanese}",
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        AnimeInfoText.text(
                                          "Status",
                                          "${controller.animeInfo.status}",
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        AnimeInfoText.text(
                                          "Score",
                                          "${controller.animeInfo.score}",
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        AnimeInfoText.text(
                                          "Episodes",
                                          "${controller.animeInfo.episodes}",
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        AnimeInfoText.text(
                                          "Duration",
                                          "${controller.animeInfo.duration}",
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        AnimeInfoText.text(
                                          "Genres",
                                          "${controller.animeInfo.genres}",
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Episodes",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const Divider(
                                indent: 2,
                                color: primaryColor,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.episodeList.length,
                                  padding: EdgeInsets.symmetric(vertical: 10.w),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Menu.episodeList(
                                      episodeList:
                                          controller.episodeList[index],
                                      animeInfo: controller.animeInfo,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
