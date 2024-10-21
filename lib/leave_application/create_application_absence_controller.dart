import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:edupay/config/DataService.dart';
import 'package:edupay/core/base/base_view_view_model.dart';
import 'package:edupay/models/SchoolLeaveOfAbsence/reason.dart';
import 'package:edupay/models/SchoolLeaveOfAbsence/student_leave_of_absence.dart';
import 'package:edupay/models/data_response.dart';
import 'package:edupay/models/profile.dart';
import 'package:edupay/models/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../models/student.dart';

class AbsenceDate
{
  DateTime? fromDate;
  DateTime? toDate;
  AbsenceDate() {}
}

class CreateAbsencePageController extends BaseController {
  var edit = false.obs;
 List<dynamic>? allReasonAbsence=[];
  List<AbsenceDate> listAbsence=[];
  DateTime? fromDate;
  DateTime? toDate;
  Student student;
  var reasonAbsence=''.obs;
  var reasonId=''.obs;
  CreateAbsencePageController(
      {bool edit = false,
       required  this.student,
      }) {
    this.edit.value = edit;
    if (this.edit.value) {
    }
  }
  @override
  void onInit() async {
    getAllReason();
    super.onInit();
  }

getAllReason() async
{DataService data=DataService();
List<Reason> result=await data.getAllReason(Profile.phoneNumber??'',Profile.companyCode??'');
allReasonAbsence=[];
  try {
    for(int i=0;i<result.length;i++) {
      allReasonAbsence!.add(result[i].toJson());
    }
  } catch (y) {
    }
  update();
}
 createAbsence() async
 {
DataService data=DataService();
 DateFormat dateFormatToJson = DateFormat("yyyy/MM/dd");
 StudentLeaveOfAbsenceModel temp =
   StudentLeaveOfAbsenceModel();
   temp.companyCode = Profile.companyCode;
   temp.reason = reasonId.value??'';
   temp.student = Profile.currentStudent.id;
    temp.fromDate =
    dateFormatToJson.format(fromDate!);
    temp.toDate =
    dateFormatToJson.format(toDate!);
    temp.parent = Profile.parentID;
    temp.reasonDescription =reasonAbsence.value??'';
 Result result= await data.createLeaveOfAbsence(temp);
if(result!=null &&result.status==2) {
  return '';
} else {
  print(result.message);
  return result.message??'';
}
  }}