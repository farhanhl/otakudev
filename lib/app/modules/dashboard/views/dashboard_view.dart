import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import '../controllers/dashboard_controller.dart';
import 'package:otakudev/app/theme/app_theme.dart';
import 'package:otakudev/app/core/providers/api.dart';
import 'package:otakudev/app/widgets/menu_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otakudev/app/data/dtos/anime_list_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:otakudev/app/modules/dashboard/service/dashboard_service.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(
        DashboardService(
          Get.find<Api>(),
        ),
      ),
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Otaku Dev',
              style: TextStyle(
                color: lightColor,
              ),
            ),
            backgroundColor: primaryColor,
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  controller.isLoading && controller.isFirstLoading
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
                                "Memuat daftar jadwal...",
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        )
                      : Expanded(
                          child: PagedGridView<int, AnimeList>(
                            scrollController: controller.animeListController,
                            pagingController: controller.pagingController,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10.w,
                              mainAxisSpacing: 10.h,
                              childAspectRatio:
                                  Get.width / Get.height.h * 1.4.h,
                              crossAxisCount: 2,
                            ),
                            builderDelegate:
                                PagedChildBuilderDelegate<AnimeList>(
                              itemBuilder: (context, item, index) =>
                                  Menu.homeMenu(item),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
