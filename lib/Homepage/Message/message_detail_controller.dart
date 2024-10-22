import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../../core/base/base_controller.dart';

class MessageDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MessageDetailPageController());
  }
}

class MessageDetailPageController extends BaseController {
  var conversation;
  var state = 'init';
  @override
  void onInit() async {
    super.onInit();
  }

}
