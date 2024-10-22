

import 'dart:math';

import 'package:edupay/Homepage/Message/message_detail_controller.dart';
import 'package:edupay/Homepage/Widget/edupay_appbar.dart';
import 'package:edupay/Homepage/tuition/card_student_info.dart';
import 'package:edupay/config/DataService.dart';
import 'package:edupay/constants.dart';
import 'package:edupay/core/base/base_view_view_model.dart';
import 'package:edupay/leave_application/calendar_shift.dart';
import 'package:edupay/leave_application/create_application_absence_controller.dart';
import 'package:edupay/leave_application/create_application_absence_veiw.dart';
import 'package:edupay/leave_application/leace_application_controller.dart';
import 'package:edupay/models/SchoolLeaveOfAbsence/reason.dart';
import 'package:edupay/models/SchoolLeaveOfAbsence/student_leave_of_absence.dart';
import 'package:edupay/models/profile.dart';
import 'package:edupay/models/secure_store.dart';
import 'package:edupay/widget/gradientBitton.dart';
import 'package:edupay/widget/rounded_button.dart';
import 'package:edupay/widget/rve_popup_choose_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../models/student.dart';

class MessageDetailPage extends BaseView<MessageDetailPageController> {

  @override
  Widget baseBuilder(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return Scaffold(
        appBar:
      AppBar(
      foregroundColor: Colors.white,
      backgroundColor: kPrimaryColor,
          title:
          GestureDetector(
         onTap: () { },
         child:
            const Text(
              "Nguyen van A",
              style: TextStyle(fontSize: 16, color: Colors.white),
            )),
       ),
      body: Container(
      ),
    );
  }
}
