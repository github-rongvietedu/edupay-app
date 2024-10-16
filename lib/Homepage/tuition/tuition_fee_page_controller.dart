import 'package:edupay/Homepage/home_page_parent.dart';
import 'package:edupay/Homepage/home_page_parent_controller.dart';
import 'package:edupay/config/DataService.dart';
import 'package:edupay/models/invoice/invoice.dart';
import 'package:edupay/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../../core/base/base_controller.dart';
import '../../models/invoice/invoice_result.dart';

class TuitionFeePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TuitionFeePageController());
  }
}

class TuitionFeePageController extends BaseController {
  var controllerStudent = Get.find<HomePageParentController>();
  final invoices = <Invoice>[].obs;

  Future<void> getAllInvoice() async {
    try {
      InvoiceResult response = await DataService()
          .getAllInvoice(controllerStudent.selectedStudent.value.id);
      if (response.status == 2) {
        // print('Request success with status: ${respone['message']}.');
        invoices.value = (response.data as List)
            .map((item) => Invoice.fromJson(item))
            .toList();
      } else {
        // print('Request failed with status: ${respone['message']}.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() async {
    getAllInvoice();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
