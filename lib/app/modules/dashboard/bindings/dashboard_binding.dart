import 'package:get/get.dart';
import 'package:otakudev/app/core/providers/api.dart';
import 'package:otakudev/app/modules/dashboard/service/dashboard_service.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(
        DashboardService(
          Get.find<Api>(),
        ),
      ),
    );
  }
}
