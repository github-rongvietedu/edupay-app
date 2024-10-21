import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:edupay/config/DataService.dart';
import 'package:edupay/core/base/base_view_view_model.dart';
import 'package:edupay/models/SchoolLeaveOfAbsence/student_leave_of_absence.dart';
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
 var allReasonAbsence;
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
  allReasonAbsence=await data.getAllReason(Profile.phoneNumber??'',Profile.companyCode??'');
  print('getall reason.................');
  print(allReasonAbsence);
  allReasonAbsence ??= [];
  update();
}
 createAbsence() async
 {  print('...............');
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
  return result.message??'';
}
  }}