import 'dart:convert';
import 'dart:io';

import 'package:edupay/config/DataService.dart';
import 'package:edupay/constants.dart';
import 'package:edupay/models/SchoolLeaveOfAbsence/student_leave_of_absence.dart';
import 'package:edupay/widget/date_picker.dart';
import 'package:edupay/widget/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'models/SchoolLeaveOfAbsence/reason.dart';
import 'models/TimeTable/time_table.dart';
import 'models/profile.dart';
import 'models/secure_store.dart';
import 'models/student.dart';
import 'widget/rounded_password_field.dart';
import 'widget/rve_popup_choose_option.dart';

class LeaveApplicationScreen extends StatefulWidget {
  const LeaveApplicationScreen({Key? key}) : super(key: key);

  @override
  State<LeaveApplicationScreen> createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
  ValueNotifier<int> selectedStudent =
      ValueNotifier<int>(Profile.selectedStudent);
  Student currentStudent = Profile.currentStudent;
  final secureStore = SecureStore();
  DateFormat dateFormatDay = DateFormat("dd/MM/yyyy");
  DateFormat dateFormatToJson = DateFormat("yyyy/MM/dd");
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  bool _isHidden = true;
  bool _isEnableButton = false;
  TextEditingController _soNgayNghiController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Map<int, Student> data = Profile.listStudent;
  String endcodepassword = "";
  String plantextPassword = "";
  List<String> list = <String>['Nghỉ bệnh', "Nghỉ đi du lịch"];
  List<Reason> listReason = [];
  int countDate = 0;

  Reason? dropdownValue;

  // Future<List<Reason>> getDataReason() async {
  //   await DataService()
  //       .getAllReason(Profile.phoneNumber ?? "", Profile.companyCode)
  //       .then((value) => listReason = value);
  //   return listReason;
  // }

  Future<DateTime> _selectDate(BuildContext context, DateTime date,
      DateTime firstDate, DateTime lastDate) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.grey,
              colorScheme: ColorScheme.light(
                primary: kPrimaryColor,
                onSecondary: Colors.black,
                onPrimary: Colors.white,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child ?? const Text(""),
          );
        },
        locale: const Locale('vi', ''),
        initialDate: date,
        firstDate: firstDate,
        lastDate: lastDate);
    if (pickedDate != null) {
      date = pickedDate;

      print(date);
    }
    return date;
  }

  getPassword() async {
    await secureStore.readSecureData('password').then((value) {
      if (value != null && value != "") {
        endcodepassword = value;
      }
    });
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    if (endcodepassword != '') {
      plantextPassword = stringToBase64.decode(endcodepassword);
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    getPassword();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DataService()
          .getAllReason(Profile.phoneNumber ?? "", Profile.companyCode)
          .then((value) => listReason = value);
      // dropdownValue = listReason.first;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        // bottomOpacity: 0,
        backgroundColor: kPrimaryColor,
        title: Text(
          "Đơn xin nghỉ phép",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body:
          //
          SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            height: size.height * 0.85,
            width: size.width,
            child: Column(
              children: [
                Flexible(
                  flex: 20,
                  child: RVEPopupChooseOption(
                    currentStudent: currentStudent,
                    label: "Chọn học viên",
                    data: data,
                    selected: selectedStudent,
                    onChange: (value) async {
                      if (data.isNotEmpty) {
                        currentStudent = data[value] as Student;
                      }
                    },
                    enable: true,
                  ),
                ),

                Flexible(
                  flex: 80,
                  child: Container(
                    // padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8),
                    height: size.height * 0.85,
                    width: size.width,
                    child: Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 35,
                                          child: Container(
                                              child: Text("Từ ngày:",
                                                  style: GoogleFonts
                                                      .robotoCondensed(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight
                                                              .bold)))),
                                      Expanded(
                                          flex: 65,
                                          child: GestureDetector(
                                            onTap: () async {
                                              fromDate = await _selectDate(
                                                  context,
                                                  fromDate,
                                                  DateTime(DateTime.now().year),
                                                  DateTime(
                                                      DateTime.now().year + 1));
                                              // toDate =
                                              //     fromDate.add(Duration(days: 14));
                                              // countDate = toDate
                                              //         .difference(fromDate)
                                              //         .inDays +
                                              //     1;
                                              if (fromDate.isAfter(toDate)) {
                                                toDate = fromDate;
                                              }
                                              setState(() {});
                                              print(fromDate);
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                    '${dateFormatDay.format(fromDate)}',
                                                    style: GoogleFonts
                                                        .robotoCondensed(
                                                            fontSize: 18,
                                                            // fontWeight:
                                                            //     FontWeight.bold,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.7))),
                                                Icon(Icons.arrow_drop_down),
                                                // Spacer(),
                                              ],
                                            ),
                                          ))
                                    ]),
                                Divider(),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 35,
                                          child: Container(
                                              child: Text("Đến ngày:",
                                                  style: GoogleFonts
                                                      .robotoCondensed(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight
                                                              .bold)))),
                                      Expanded(
                                          flex: 65,
                                          child: GestureDetector(
                                            onTap: () async {
                                              toDate = await _selectDate(
                                                  context,
                                                  toDate,
                                                  fromDate,
                                                  DateTime(
                                                      DateTime.now().year + 1));
                                              // countDate = toDate
                                              //         .difference(fromDate)
                                              //         .inDays +
                                              //     1;
                                              setState(() {});
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                    '${dateFormatDay.format(toDate)}',
                                                    style: GoogleFonts
                                                        .robotoCondensed(
                                                            fontSize: 18,
                                                            // fontWeight:
                                                            //     FontWeight.bold,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.7))),
                                                Icon(Icons.arrow_drop_down),
                                              ],
                                            ),
                                          ))
                                    ]),
                                Divider(),
                                // Row(
                                //   children: [
                                //     Expanded(
                                //         flex: 35,
                                //         child: Container(
                                //             child: Text("Số ngày nghỉ:",
                                //                 style: GoogleFonts.robotoCondensed(
                                //                     fontSize: 18,
                                //                     fontWeight: FontWeight.bold)))),
                                //     Expanded(
                                //         flex: 65,
                                //         child: Container(
                                //             child: Text("$countDate",
                                //                 style: GoogleFonts.robotoCondensed(
                                //                   fontSize: 18,
                                //                 )))),
                                //   ],
                                // ),
                                // Divider(),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 35,
                                        child: Container(
                                            child: Text("Lý do nghỉ học:",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold)))),
                                    Expanded(
                                        flex: 65,
                                        child: Container(
                                            child:
                                                DropdownButtonFormField<Reason>(
                                          value: dropdownValue,
                                          decoration: InputDecoration.collapsed(
                                              hintText: "Vui lòng chọn lý do"),
                                          elevation: 16,
                                          style: GoogleFonts.robotoCondensed(
                                              fontSize: 18,
                                              color: Colors.black87),
                                          // underline: Container(
                                          //   height: 1,
                                          //   color: Colors.black38,
                                          // ),
                                          onChanged: (Reason? value) {
                                            // This is called when the user selects an item.
                                            setState(() {
                                              dropdownValue = value!;
                                            });
                                          },
                                          items: listReason
                                              .map<DropdownMenuItem<Reason>>(
                                                  (Reason value) {
                                            return DropdownMenuItem<Reason>(
                                              value: value,
                                              child: Text(
                                                  value.reasonName as String),
                                            );
                                          }).toList(),
                                        ))),
                                  ],
                                ),
                                Divider(),
                                Container(
                                    margin: EdgeInsets.only(top: 5),
                                    padding: EdgeInsets.all(8),
                                    // height: size.height * 0.2,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1)),
                                    child: TextField(
                                      controller: _soNgayNghiController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        // hintStyle:
                                        // TextStyle(color: Colors.black26),
                                        hintText:
                                            "Vui lòng nhập lý do xin nghỉ.",
                                      ),
                                      maxLines: 6,
                                    )),
                                Divider(),
                                // Container(
                                //   height: 50,
                                //   padding: EdgeInsets.all(5),
                                //   decoration: BoxDecoration(
                                //       border: Border.all(color: Colors.black45),
                                //       borderRadius: BorderRadius.circular(8)),
                                //   child: TextField(
                                //     obscureText: _isHidden,
                                //     controller: _passwordController,
                                //     onChanged: (value) {
                                //       setState(() {
                                //         if (value == plantextPassword) {
                                //           _isEnableButton = true;
                                //         } else {
                                //           _isEnableButton = false;
                                //         }
                                //       });
                                //     },
                                //     decoration: InputDecoration(
                                //         hintText: "Nhập mật khẩu để xác nhận.",
                                //         suffixIcon: IconButton(
                                //           onPressed: () {
                                //             setState(() {
                                //               _isHidden = !_isHidden;
                                //             });
                                //           },
                                //           icon: !_isHidden
                                //               ? const Icon(Icons.visibility_off)
                                //               : const Icon(Icons.visibility),
                                //           color: kPrimaryColor,
                                //         ),
                                //         border: InputBorder.none),
                                //   ),
                                // ),
                                // SizedBox(height: 20),
                                RoundedButton(
                                  text: "Xác nhận",
                                  press: () async {
                                    if (_isEnableButton == false) {
                                      _showSnackBar(
                                          context,
                                          "Mật khẩu không chính xác, vui lòng kiểm tra lại !!!",
                                          Colors.red);
                                      return;
                                    }
                                    StudentLeaveOfAbsenceModel temp =
                                        StudentLeaveOfAbsenceModel();
                                    temp.companyCode = Profile.companyCode;
                                    temp.reason = dropdownValue?.iD;
                                    temp.student = currentStudent.id;
                                    temp.fromDate =
                                        dateFormatToJson.format(fromDate);
                                    temp.toDate =
                                        dateFormatToJson.format(toDate);
                                    temp.parent = Profile.parentID;
                                    temp.reasonDescription =
                                        _soNgayNghiController.text;
                                    await DataService()
                                        .createLeaveOfAbsence(temp)
                                        .then((value) {
                                      if (value.status == 2) {
                                        Navigator.of(context).pop();
                                        _showSnackBar(
                                            context,
                                            "Tạo đơn xin nghỉ phép thành công !!!",
                                            Colors.green);
                                        return;
                                      } else {
                                        _showSnackBar(
                                            context,
                                            "Thông tin đơn xin nghỉ phép chưa hợp lệ, vui lòng kiểm tra lại !!!",
                                            Colors.red);
                                        return;
                                      }
                                    });
                                  },
                                  enable: true,
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                )
                // : Flexible(flex: 80, child: SizedBox())
              ],
            ),
          ),
        ),
      ),

      // })
    );
  }
}

void _showSnackBar(BuildContext context, String message, Color color) {
  final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: Duration(seconds: 3));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
