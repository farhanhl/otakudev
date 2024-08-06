import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:otakudev/app/theme/app_theme.dart';
import '../controllers/watch_anime_controller.dart';
import 'package:otakudev/app/core/providers/api.dart';
import 'package:otakudev/app/widgets/menu_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:otakudev/app/modules/watch_anime/service/watch_anime_service.dart';

class WatchAnimeView extends GetView<WatchAnimeController> {
  const WatchAnimeView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WatchAnimeController>(
      init: WatchAnimeController(
        WatchAnimeService(
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
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: TabBar(
                controller: controller.tabController,
                labelColor: lightColor,
                unselectedLabelColor: shadowColor,
                dividerColor: transparent,
                indicatorColor: transparent,
                tabs: const [
                  Tab(text: 'Streaming'),
                  Tab(text: 'Download'),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              controller: controller.tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
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
                                    "Memuat anime...",
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            )
                          : Expanded(
                              child: HtmlWidget(
                                controller.iframeUrl,
                              ),
                            )
                    ],
                  ),
                ),
                Padding(
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
                                    "Memuat anime...",
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.downloadModel.length,
                                padding: EdgeInsets.symmetric(vertical: 10.w),
                                itemBuilder: (BuildContext context, int index) {
                                  return Menu.downloadList(
                                      controller.downloadModel[index]);
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
