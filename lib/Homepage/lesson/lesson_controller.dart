import 'package:get/get.dart';

import '../../core/base/base_controller.dart';

enum LessonStatus { loading, success, failure }

class LessonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LessonController());
  }
}

class LessonController extends BaseController {
  var status = LessonStatus.loading.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize your data here
    fetchLessons();
  }

  void fetchLessons() async {
    try {
      // Fetch your lessons here
      status.value = LessonStatus.success;
    } catch (e) {
      status.value = LessonStatus.failure;
    }
  }
}
