import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../../core/base/base_controller.dart';

class LeavePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeavePageController());
  }
}

class LeavePageController extends BaseController {
  DateTime displayedMonth = DateTime.now();
  var showType='list'.obs;
  var currentPage = 0;
  var historyTimeSheet;

  var state = 'init';
  @override
  void onInit() async {
    getListShiftReport();
    super.onInit();
  }

  getListShiftReport() async
  {
  historyTimeSheet=
  [
    {'ShiftName':'test1','Status':'OnTime'},
    {'ShiftName':'test1','Status':'OnTime'},
    {'ShiftName':'test1','Status':'OnTime'},
    {'ShiftName':'test1','Status':'OnTime'},
    {'ShiftName':'test1','Status':'OnTime'},
    {'ShiftName':'test1','Status':'OnTime'},
    {'ShiftName':'test1','Status':'OnTime'},
    {'ShiftName':'test1','Status':'OnTime'},
    {'ShiftName':'test1','Status':'OnTime'},
    {'ShiftName':'test1','Status':'OnTime'},
    {'ShiftName':'test1','Status':'OnTime'},
    {'ShiftName':'test1','Status':'OnTime'},
  ];
  state = 'ready';
  update();
  }

}
