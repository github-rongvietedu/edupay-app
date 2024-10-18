import 'package:get/get.dart';

import '../../config/DataService.dart';
import '../../core/base/base_controller.dart';
import '../../models/classRoom/class_lesson_detail.dart';

enum LessonStatus { loading, success, failure }

class LessonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LessonController());
  }
}

class LessonController extends BaseController {
  var status = LessonStatus.loading.obs;
  var listLesson = <ClassLessonDetail>[].obs;
  @override
  void onInit() {
    super.onInit();
    // Initialize your data here
    fetchLessons();
  }

  void fetchLessons() async {
    status.value = LessonStatus.loading;

    try {
      // Fetch your lessons here
      listLesson.value = await DataService().getAllLessonByGrade("");

      status.value = LessonStatus.success;
    } catch (e) {
      status.value = LessonStatus.failure;
    }
  }
}
