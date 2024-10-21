import 'package:edupay/core/base/base_view_view_model.dart';
import 'package:edupay/leave_application/create_application_absence_controller.dart';
import 'package:edupay/leave_application/simpleDatePicker.dart';
import 'package:edupay/widget/DropdownCustom.dart';
import 'package:edupay/widget/gradientBitton.dart';
import 'package:edupay/widget/input.dart';
import 'package:edupay/widget/showSnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAbsencePage extends BaseView<CreateAbsencePageController> {

  Widget _buildHeader() {
    return const Row(
      children: [
        Text('Xin nghỉ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return InkWell(
      onTap: () async  {
        FocusScope.of(context).requestFocus( FocusNode());
        if (controller.fromDate ==null) {
        showCustomSnackbar(context,"Vui lòng chọn ngày bắt đầu",Colors.red);
  }
      else if (controller.toDate ==null) {
             showCustomSnackbar(context,"Vui lòng chọn ngày kết thúc",Colors.red);
      }
      else if ((controller.reasonId??'') =='') {
             showCustomSnackbar(context,"Vui lòng chọn/nhập lý do",Colors.red);
      }
      else
     {
        var result=await controller.createAbsence();
        if(result!=null&&result=='') {
          Navigator.of(context).pop();
          showCustomSnackbar(context,"Tạo đơn xin nghỉ phép thành công",Colors.white);
        } else
          if(result!=null) {
            showCustomSnackbar(context,result,Colors.red);
          }
      }
   },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child:LinearGradientButton(
            fontSize: 16,
            text: 'Xin nghỉ',
            textColor: Colors.black,
            fontWeight: FontWeight.bold,
            color2: const Color.fromRGBO(251, 192, 0, 1),
            color1: const Color.fromRGBO(254,239, 159, 1),
            )
      ),
    );
  }

  daySelection(context) {
    return SizedBox(
      height: 54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await show3ColumnDatePickerBottomSheet(
                  context,
                  controller.fromDate ?? DateTime.now(),
                );
                if (pickedDate != null) {
                  print(pickedDate);
                  controller.fromDate = pickedDate;
                  if (controller.toDate != null && controller.toDate!.isBefore(controller.fromDate!)) {
                    controller.toDate = null;
                  }
                  controller.update();
                }
              },
              child: controller.fromDate != null
                  ? dateContainer(formatDate(controller.fromDate!), 'Từ ngày')
                  : LinearGradientButton(
                borderColor: Colors.grey.withOpacity(0.5),
                borderRadius: 16.0,
                fontSize: 14,
                text: 'Từ ngày',
                textColor: const Color.fromRGBO(100, 116, 139, 1),
                fontWeight: FontWeight.bold,
                color2: Colors.transparent,
                color1: Colors.transparent,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                if (controller.fromDate != null) {
                  DateTime? pickedDate =await show3ColumnDatePickerBottomSheet(context,controller.toDate??DateTime.now());
                  if (pickedDate != null) {
                    if (pickedDate.isAfter(controller.fromDate!)
                        || controller.fromDate!.isAtSameMomentAs(pickedDate!)
                    ) {
                      controller.toDate = pickedDate;
                      controller.update();
                    } else {
                      print("Out date should be after In date");
                    }
                  }
                } else {
                  print("Please select the in-date first");
                }
              },
              child: controller.toDate != null
                  ? dateContainer(formatDate(controller.toDate!), 'Đến ngày')
                  : LinearGradientButton(
                borderColor: Colors.grey.withOpacity(0.5),
                borderRadius: 16.0,
              //  iconColor: const Color.fromRGBO(100, 116, 139, 1),
               // icon: 'images/icon/email.png',
               // iconSize: 24,
                fontSize: 14,
                text: 'Đến ngày',
                textColor: const Color.fromRGBO(100, 116, 139, 1),
                fontWeight: FontWeight.bold,
                color2: Colors.transparent,
                color1: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }



  @override
  Widget baseBuilder(BuildContext context) {
       return GestureDetector(onTap: () {
      FocusScope.of(context)
          .unfocus(); // Dismiss the keyboard when tapping outside
    }, child: LayoutBuilder(
      builder: (context, constraints) {
        double bottomPadding = MediaQuery.of(context).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 22,right: 22),
              child: Column(
                mainAxisSize:
                MainAxisSize.min, // Ensure column takes only needed height
                children: [
                  // CardStudentInfo(),

                  const SizedBox(height: 13),
                  _buildHeader(),
                  const SizedBox(height: 32),
                  Row(children: [
                    Text(controller.student.studentName??'',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),]),
                  const SizedBox(height: 4),
                   Row(children: [
                    Text(('Mã số '??'')+(controller.student.studentCode??''),style: const TextStyle(fontSize: 12))]),
                  const SizedBox(height: 4),
                  Row(children: [
                    Text(('Lớp '??'') + (controller.student.className??''),style: const TextStyle(fontSize: 12))]),
                  const SizedBox(height: 16),
                  daySelection(context),
                  const SizedBox(height: 12),
                  BottomSelection(
                      height: 400.0,
                      header:'Chọn lý do' ,
                      list:controller.allReasonAbsence ,
                      valueController: controller.reasonId,
                      hintText: 'Lý do',
                      hintTextColor: const Color.fromRGBO(100, 116, 139, 1),
                      valueNAme: 'ID',
                      displayNAme: 'ReasonName',
                      suffixIcon:Transform.rotate(
                        angle: 90 * 3.1415927 / 180, // Rotate 90 degrees
                        child: const Icon(Icons.arrow_forward_ios,size: 16),
                      )
                  ),
                   const SizedBox(height: 16),
                   Input(
                      borderColor: Colors.grey.withOpacity(0.7),
                      maxLine: 4,
                      fontsSze: 14.0,
                      hintTextColor: const Color.fromRGBO(100, 116, 139, 1),
                      hintText: 'Nhập lý do xin nghỉ',
                     valueController: controller.reasonAbsence,
                    ),
                  const SizedBox(height: 12),
                  _buildSubmitButton(context),
                  const SizedBox(height: 14),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
