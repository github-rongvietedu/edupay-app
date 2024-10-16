import 'package:edupay/HomePageTeacher/MessengerScreen/messenger_screen_student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';
import '../../../models/profile.dart';
import '../../../models/schoolYear/school_year.dart';
import '../../../widget/rve_popup_choose_option_default.dart';
import '../../../widget/text_with_space.dart';
import '../../attendance/attendanceV2.dart';
import '../schoolYear/bloc/school_year_bloc.dart';
import '../schoolYear/bloc/school_year_event.dart';
import '../schoolYear/bloc/school_year_state.dart';
import 'bloc/class_bloc.dart';
import 'bloc/class_event.dart';
import 'bloc/class_state.dart';

class ClassInfoV2 extends StatefulWidget {
  const ClassInfoV2({Key? key, this.scrollController}) : super(key: key);
  final scrollController;
  @override
  State<ClassInfoV2> createState() => _ClassInfoState();
}

class _ClassInfoState extends State<ClassInfoV2> {
  late ScrollController _scrollController;
  final TextStyle _textStyle =
      GoogleFonts.ptSansNarrow(fontSize: 18, fontWeight: FontWeight.w500);
  final TextStyle _textStyleTable =
      GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w400);
  late ClassBloc _classBloc;
  late String _selectedSchoolYear = "";
  bool isDisplayMessage = false;
  late SchoolYearBloc _schoolYearBloc;
  ValueNotifier<int> selectedSchoolYear = ValueNotifier<int>(0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = widget.scrollController;
    _classBloc = context.read<ClassBloc>();
    _schoolYearBloc = context.read<SchoolYearBloc>()..add(LoadSchoolYear());
    ;
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: size.height * 0.70,
          // color: kPrimaryColor
        ),
        SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height * 0.7,
              minWidth: size.width,
              maxHeight: double.infinity,
            ),
            child: Container(
                margin: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  top: 1,
                ),
                // height: size.height * 0.73,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4)),
                child: BlocBuilder<SchoolYearBloc, SchoolYearState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case SchoolYearStatus.failure:
                        break;
                      case SchoolYearStatus.initial:
                        break;
                      case SchoolYearStatus.changed:
                        break;
                      // return Center(
                      //     child: Container(
                      //         height: 50,
                      //         width: 50,
                      //         child: CircularProgressIndicator()));
                      case SchoolYearStatus.success:
                        _classBloc.add(LoadClass(
                            state.currentSchoolYear.iD ?? "",
                            student: Profile.currentStudent));
                        Map<int, SchoolYear> listSchoolYear = {};

                        for (int i = 0; i < state.schoolYear.length; i++) {
                          listSchoolYear[i] = state.schoolYear[i];
                        }
                        return buildClassInfoWidget(context, listSchoolYear,
                            state.currentSchoolYear, size);
                    }
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AttendanceScreenV2(),
                        ]);
                  },
                )),
          ),
        ),
      ],
    );
  }

  Widget buildClassInfoWidget(BuildContext context,
      Map<int, SchoolYear> listSchoolYear, SchoolYear currentYear, Size size) {
    return BlocListener<ClassBloc, ClassState>(
      listener: (context, state) {
        if (state.status == ClassStatus.success &&
            state.classInfo.teacherID.isNotEmpty) {
          isDisplayMessage = true;
        } else {
          isDisplayMessage = false;
        }
      },
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<ClassBloc, ClassState>(builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Icon(Icons.person, size: 30, color: Colors.grey[500]),
                  const SizedBox(
                    width: 8,
                  ),
                  Text("Niên khoá:", style: kTextStyleTitle),
                  // const SizedBox(
                  //   width: 8,
                  // ),
                  RVEPopupChooseOptionDefault(
                      label: "Chọn niên khoá",
                      data: listSchoolYear,
                      selected: selectedSchoolYear,
                      onChange: (value) async {
                        Profile.currentYear =
                            listSchoolYear[selectedSchoolYear.value]!.iD ?? "";
                        _schoolYearBloc.add(ChangeSchoolYear(
                            listSchoolYear[selectedSchoolYear.value]!.iD ??
                                ""));

                        _classBloc.add(LoadClass(
                            listSchoolYear[selectedSchoolYear.value]!.iD ?? "",
                            student: Profile.currentStudent));

                        // setState(() {
                        // _selectedIndex = _selectedIndex;
                        // });
                      },
                      enable: true,
                      child: Container(
                        margin: EdgeInsets.only(top: 3),
                        padding: EdgeInsets.only(left: 5),
                        width: size.width * 0.5,
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${currentYear.name}",
                                style: kTextStyleNomal22),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                        height: 50,
                      )),
                  Spacer(),
                  isDisplayMessage
                      ? InkWell(
                          onTap: () {
                            // student.parent!.isNotEmpty
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MessengerScreenStudent(
                                  info: state.classInfo,
                                  schoolYearID: currentYear.iD ?? "",
                                ),
                              ),
                            );
                            //     : null;
                          },
                          child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.message,
                                color: Colors.white,
                              )),
                        )
                      : SizedBox()
                ],
              );
            }),
            // ),

            BlocBuilder<ClassBloc, ClassState>(builder: (context, state) {
              switch (state.status) {
                case ClassStatus.failure:
                  return Container(
                      height: 100,
                      width: size.width,
                      child:
                          Center(child: Text('Chưa có thông tin lớp học !!!')));
                case ClassStatus.initial:
                  break;
                case ClassStatus.changed:
                  // Future.delayed(const Duration(milliseconds: 2000));
                  return Center(
                      child: Container(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator()));
                case ClassStatus.success:
                  return Flexible(
                      child: Card(
                    color: Colors.white,
                    elevation: 2,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 130,
                        minWidth: size.width,
                        maxHeight: double.infinity,
                      ),
                      child: Container(
                          padding: const EdgeInsets.only(
                              left: 12, top: 8, bottom: 8, right: 12),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Colors.black38))),
                                    child: _textWithSpace(
                                        "Lớp", state.classInfo.name)),
                                Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Colors.black38))),
                                    child: _textWithSpace(
                                        "Phòng", state.classInfo.roomName)),
                                Container(
                                  height: 30,
                                  child: _textWithSpace("Giáo viên phụ trách",
                                      state.classInfo.mainTeacherName),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ));
              }
              return Center(
                  child: Container(
                      height: 50,
                      width: 50,
                      child: const CircularProgressIndicator()));
            }),
            AttendanceScreenV2(),
          ]),
    );
  }

  Row _textWithSpace(String text1, String text2) {
    return Row(
      children: [
        Flexible(
            flex: 5,
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(text1,
                    overflow: TextOverflow.ellipsis,
                    style: kTextStyleNomalBrown))),
        Flexible(
            flex: 5,
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(text2,
                    overflow: TextOverflow.ellipsis, style: kTextStyleBold)))
      ],
    );
  }
}

Future<void> _buildModalBottomSheet(BuildContext context, List<SchoolYear> list,
    SchoolYearBloc _schoolYearBloc, ClassBloc _classBloc) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    builder: (BuildContext context) {
      return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(5),
          // decoration: BoxDecoration(
          //     color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text("Chọn niên khoá", style: kTextStyleTitle),
                  )),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: list
                    .map((e) => MaterialButton(
                          onPressed: () {
                            Profile.currentYear = e.iD ?? "";
                            _schoolYearBloc.add(ChangeSchoolYear(e.iD ?? ""));

                            _classBloc.add(LoadClass(e.iD ?? "",
                                student: Profile.currentStudent));
                            Navigator.pop(context);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: kPrimaryColor.withOpacity(0.3),
                                  // border: Border.all(),
                                  borderRadius: BorderRadius.circular(8)),
                              margin: const EdgeInsets.all(5),
                              height: 60,
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: ListTile(
                                    title: Text(e.name ?? "",
                                        style: kTextStyleNomal),
                                    //subtitle: Text(e.description),
                                  ))
                                ],
                              )),
                        ))
                    .toList(),
              ),
            ],
          ));
    },
  );
}
