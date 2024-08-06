import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:otakudev/app/core/providers/api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "Otaku Dev",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          initialBinding: BindingsBuilder(
            () async {
              Get.put(
                Api(),
                permanent: true,
              );
            },
          ),
        );
      },
    ),
  );
}
