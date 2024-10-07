import 'package:edupay/models/schoolYear/school_year_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../config/DataService.dart';
import '../constants.dart';
import '../models/StudentClassRoom/StudentClassInfo.dart';
import '../models/classRoom/class_info.dart';
import '../models/data_response.dart';
import '../models/profile.dart';
import '../models/schoolYear/school_year.dart';
import '../widget/drawer.dart';
import '../widget/rve_popup_choose_option_default.dart';
import 'MessengerScreen/messenger_screen_teacher.dart';

class HomePageTeacherScreen extends StatefulWidget {
  const HomePageTeacherScreen({Key? key}) : super(key: key);

  @override
  State<HomePageTeacherScreen> createState() => _HomePageTeacherScreenState();
}

class _HomePageTeacherScreenState extends State<HomePageTeacherScreen> {
  late SchoolYear _selectedSchoolYear;

  late ClassInfo currentClassroom = ClassInfo();
  TextEditingController searchController = TextEditingController();

  Map<int, SchoolYear> listSchoolYear = {};
  ValueNotifier<int> selectedSchoolYear = ValueNotifier<int>(0);
  ValueNotifier<String> schoolYearState = ValueNotifier('');

  ValueNotifier<String> screenState = ValueNotifier('Loading');
  ValueNotifier<String> searchText = ValueNotifier('');

  Map<int, ClassInfo> listClassRoomSelected = {};
  ValueNotifier<int> selectedClassRoom = ValueNotifier<int>(0);
  ValueNotifier<String> classRoomState = ValueNotifier('');

  List<StudentClassInfo> listStudent = [];

  Future<void> getAllSchoolYear() async {
    schoolYearState.value = 'Loading';
    DataService dataService = DataService();
    final SchoolYearResult dataResponse =
        await dataService.getAllSchoolYearByCompanyCode(Profile.companyCode);
    List<SchoolYear> tempList = [];
    if (dataResponse.schoolYear!.isNotEmpty) {
      tempList = dataResponse.schoolYear!;
      for (int i = 0; i < tempList.length; i++) {
        listSchoolYear[i] = tempList[i];
      }
    }
    _selectedSchoolYear =
        listSchoolYear[selectedSchoolYear.value] as SchoolYear;
    schoolYearState.value = 'Success';

    print(schoolYearState.value);
  }

  Future<void> getAllClassRoom() async {
    classRoomState.value = 'Loading';
    currentClassroom = ClassInfo();
    DataService dataService = DataService();
    final DataResponse dataResponse = await dataService.getClassInfoByTeacher(
        Profile.companyCode, Profile.employeeCode);
    // List<ClassInfo> tempList = [];
    List<ClassInfo> listClassRoom = [];
    if (dataResponse.data.isNotEmpty) {
      for (var item in dataResponse.data) {
        ClassInfo classRoom = ClassInfo.fromJson(item);
        listClassRoom.add(classRoom);
      }

      listClassRoom = listClassRoom
          .where((element) => element.schoolYear == _selectedSchoolYear.iD)
          .toList();

      for (int i = 0; i < listClassRoom.length; i++) {
        listClassRoomSelected[i] = listClassRoom[i];
      }
    }

    if (listClassRoom.isNotEmpty) {
      classRoomState.value = 'Success';
      currentClassroom = listClassRoom[0];
    } else {
      classRoomState.value = 'Failed';
    }
    refreshData(currentClassroom.iD);
  }

  Future<void> refreshData(String classRoomID) async {
    screenState.value = 'Loading';
    // print(screenState.value);
    // page = 1;
    listStudent = [];
    DataService dataService = DataService();

    final DataResponse dataResponse =
        await dataService.getAllStudentByClassRoom(classRoomID);
    List<StudentClassInfo> tempList = [];
    if (dataResponse.data != null) {
      for (var info in dataResponse.data) {
        tempList.add(StudentClassInfo.fromJson(info));
      }
    }
    listStudent = tempList;
    screenState.value = 'Success';
    print(screenState.value);
  }

  _buildSearchField(
      {required ValueNotifier<String> searchText,
      required TextEditingController controller,
      required Function(String) onChanged}) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(5),
      alignment: Alignment.centerLeft,
      height: 50,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(45))),
              //width: size.width,

              //height: 40,
              alignment: Alignment.centerLeft,
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  if (onChanged != null) {
                    onChanged.call(value);
                  }

                  searchText.value = value;
                },
                style: textInter14.blackColor,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10, right: 10),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0)),
                  hintText: 'Nhập tên học viên hoặc SDT phụ huynh',
                  hintStyle: textInter14..copyWith(color: Colors.black54),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 32.0),
                      borderRadius: BorderRadius.circular(25.0)),
                  suffixIcon: ValueListenableBuilder(
                    valueListenable: searchText,
                    builder:
                        (BuildContext context, dynamic value, Widget? child) {
                      if (searchText.value.isEmpty) {
                        return const Icon(
                          // onPressed: () {
                          // widget.controller.clear();
                          // searchText.value = '';
                          // _onSearchChanged('');
                          // },
                          Icons.search, color: kPrimaryColor,
                        );
                      }
                      return InkWell(
                          onTap: () async {
                            controller.clear();
                            searchText.value = '';
                            onChanged('');
                          },
                          child: Icon(
                            Icons.clear,
                            color: kPrimaryColor,
                          ));
                    },
                  ),
                ),
              ),
            ))
          ]),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getAllSchoolYear();
    getAllClassRoom();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: MyDrawer('HomePageTeacher'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Danh sách lớp",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        color: Colors.white,
        width: size.width,
        height: size.height,
        child: Column(children: [
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Icon(Icons.person, size: 30, color: Colors.grey[500]),
                  const SizedBox(
                    width: 8,
                  ),
                  Text("Niên khoá:", style: kTextStyleTitle),
                  ValueListenableBuilder(
                      valueListenable: schoolYearState,
                      builder:
                          (BuildContext context, dynamic value, Widget? child) {
                        if (schoolYearState.value == 'Loading') {
                          return SizedBox();
                        }
                        if (schoolYearState.value == 'Success') {
                          return RVEPopupChooseOptionDefault(
                              label: "Chọn niên khoá",
                              data: listSchoolYear,
                              selected: selectedSchoolYear,
                              onChange: (value) async {
                                schoolYearState.value = 'Loading';
                                _selectedSchoolYear =
                                    listSchoolYear[selectedSchoolYear.value]
                                        as SchoolYear;
                                schoolYearState.value = 'Success';
                                getAllClassRoom();
                              },
                              enable: true,
                              child: Container(
                                margin: EdgeInsets.only(top: 3),
                                padding: EdgeInsets.only(left: 5),
                                width: size.width * 0.3,
                                // color: Colors.red,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(_selectedSchoolYear.name ?? "",
                                        style: kTextStyleNomal),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                                height: 35,
                              ));
                        }
                        return SizedBox();
                      }),
                ],
              ),
              // Expanded(
              //   child:
              ValueListenableBuilder(
                  valueListenable: classRoomState,
                  builder:
                      (BuildContext context, dynamic value, Widget? child) {
                    if (classRoomState.value == 'Loading') {
                      return SizedBox();
                    }
                    if (classRoomState.value == 'Success') {
                      return RVEPopupChooseOptionDefault(
                          label: "Chọn lớp",
                          data: listClassRoomSelected,
                          selected: selectedClassRoom,
                          onChange: (value) async {
                            classRoomState.value = 'Loading';
                            currentClassroom =
                                listClassRoomSelected[selectedClassRoom.value]
                                    as ClassInfo;
                            classRoomState.value = 'Success';

                            refreshData(currentClassroom.iD);
                          },
                          enable: true,
                          child: Container(
                            margin: EdgeInsets.only(top: 3),
                            padding: EdgeInsets.only(left: 5),
                            // width: size.width * 0.3,
                            // color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(currentClassroom.name,
                                    style: textInter16.primaryColor.bold),
                                // Icon(Icons.arrow_drop_down)
                              ],
                            ),
                            height: 35,
                          ));
                    }

                    return SizedBox();
                  }),
              // ),
            ],
          ),
          _buildSearchField(
              controller: searchController,
              searchText: searchText,
              onChanged: (value) {
                print(value);
              }),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: screenState,
                builder: (BuildContext context, dynamic value, Widget? child) {
                  if (screenState.value == 'Loading') {
                    return SizedBox();
                  }
                  if (screenState.value == 'Success') {
                    return ListView.builder(
                        itemCount: listStudent.length,
                        itemBuilder: (context, index) {
                          return buildContact(listStudent[index]);
                        });
                  }
                  return SizedBox();
                }),
          ),
        ]),
      ),
    );
  }

  Container buildContact(StudentClassInfo student) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.12,
      child: Card(
        shape: RoundedRectangleBorder(
            // side: BorderSide(color: Colors.black.withOpacity(0.1), width: 2.0),
            borderRadius: BorderRadius.circular(4.0)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 25,
                child: ClipOval(
                  child: Container(
                      // padding: const EdgeInsets.all(5),
                      width: 65,
                      height: 65,
                      //color: Colors.red,
                      child: Image.network(
                        student.faceImageURL ?? "",
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  flex: 80,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // alignment: Alignment.,
                        //color: Colors.red,
                        Text(
                          "${student.studentName}",
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "${student.phone}",
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Phụ huynh:${student.partnerName}",
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        )
                        // Container(
                        //   alignment: Alignment.topLeft,
                        //   //color: Colors.green,
                        //   child: const Text(
                        //     'Last message',
                        //     textAlign: TextAlign.start,
                        //   ),
                        // )
                      ],
                    ),
                  )),
              Flexible(
                  flex: 15,
                  child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                      child: Icon(
                        Icons.call,
                        color: Colors.white,
                      ))),
              SizedBox(
                width: 5,
              ),
              Flexible(
                  flex: 15,
                  child: InkWell(
                    onTap: () {
                      student.parent!.isNotEmpty
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MessengerScreenTeacher(
                                  schoolYearID:
                                      _selectedSchoolYear.iD as String,
                                  info: student,
                                ),
                              ),
                            )
                          : null;
                    },
                    child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.lightBlue, shape: BoxShape.circle),
                        child: Icon(
                          Icons.message,
                          color: Colors.white,
                        )),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
