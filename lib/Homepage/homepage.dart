import 'dart:io';

import 'package:edupay/Homepage/component/timeTable/bloc/time_table_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';
import '../firebase_options.dart';
import '../models/TimeTable/time_table.dart';
import '../models/profile.dart';
import '../models/secure_store.dart';
import '../models/student.dart';

import '../widget/drawer.dart';
import '../widget/rve_popup_choose_option.dart';
import 'component/BusToSchool/bloc/movement_bloc.dart';
import 'component/BusToSchool/bloc/movement_event.dart';
import 'component/BusToSchool/bus_to_school.dart';
import 'component/attendance/bloc/attendance_bloc.dart';
import 'component/attendance/bloc/attendance_event.dart';
import 'component/classInfo/bloc/class_bloc.dart';
import 'component/classInfo/bloc/class_event.dart';
import 'component/classInfo/class_infoV2.dart';
import 'component/foodMenu/menu_week.dart';
import 'component/lesson/bloc/lesson_bloc.dart';
import 'component/lesson/bloc/lesson_event.dart';
import 'component/lesson/lessonV2.dart';
import 'component/schoolYear/bloc/school_year_bloc.dart';
import 'component/schoolYear/bloc/school_year_event.dart';
import 'component/timeTable/bloc/time_table_bloc.dart';
import 'component/timeTable/time_table.dart';
import 'component/tuition/bloc/invoice_bloc.dart';
import 'component/tuition/bloc/invoice_event.dart';
import 'component/tuition/tuition_fee.dart';

class HomePageScreen extends StatefulWidget {
  final bool warningLog;
  const HomePageScreen({Key? key, required this.warningLog}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with WidgetsBindingObserver {
  bool screenOn = true;
  DateFormat formattedDate = DateFormat('dd/MM/yyyy');

  late final AttendanceBloc _attendanceBloc =
      AttendanceBloc(context, Profile.currentStudent, DateTime.now());

  late final LessonBloc _lessonBloc = LessonBloc(context, '');
  late final ClassBloc _classBloc = ClassBloc(context, Profile.currentStudent);

  late final SchoolYearBloc _schoolYearBloc =
      SchoolYearBloc(context, Profile.currentStudent.companyCode);

  late final InvoiceBloc _invoiceBloc =
      InvoiceBloc(context, Profile.currentStudent);

  late final MovementBloc _movementBloc = MovementBloc(context);

  late final TimeTableBloc _timeTableBloc = TimeTableBloc(context);

  final secureStore = SecureStore();
  late Student currentStudent;
  int _selectedIndex = 0;
  DateTime? date = DateTime.now();
  late PageController _pageController;
  ValueNotifier<int> selectedStudent =
      ValueNotifier<int>(Profile.selectedStudent);

  final _scrollControllerGroup = LinkedScrollControllerGroup();
  late ScrollController _scrollController1;
  late ScrollController _scrollController2;
  late ScrollController _scrollController3;
  late ScrollController _scrollController4;
  late ScrollController _scrollControllerBus;

  final TextStyle _textStyleTable =
      GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w400);

  final TextStyle _kTextStyleName = GoogleFonts.robotoCondensed(
      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edupay'),
        content: Text('Bạn có chắc là bạn muốn thoát ứng dụng'),
        actions: <Widget>[
          TextButton(
            child: Text("Quay lại"),
            onPressed: () async {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: Text("Thoát"),
            onPressed: () async {
              await SystemChannels.platform
                  .invokeMethod<void>('SystemNavigator.pop');
            },
          ),
        ],
      ),
    ).then((value) => value ?? false);
  }

  SnackBar snackBar = SnackBar(
    backgroundColor: kPrimaryColor,
    content: Text('Đã có phiên bản mới!'),
    action: SnackBarAction(
      label: 'Cập nhật ngay',
      textColor: Colors.white,
      onPressed: () {
        if (Platform.isAndroid) {
          launchUrl(Uri.parse(
              "https://play.google.com/store/apps/details?id=com.hts.minhduc"));
        } else if (Platform.isIOS) {
          launchUrl(Uri.parse(
              "https://apps.apple.com/us/app/hts-minh-đức/id6443481820"));
        }
      },
    ),
    duration: Duration(seconds: 30),
  );

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      String title = message.notification!.title ?? "";
      print("titleeeeeee:" + title);
      if (title != "Message") {
        _showSnackBar(
            context, message.notification!.body ?? "", kPrimaryColor, 5);

        _movementBloc.add(LoadMovement(
            Profile.phoneNumber ?? "", Profile.companyCode, DateTime.now()));
      }
    });

    Future.delayed(Duration.zero, () {
      if (widget.warningLog == true && Profile.phoneNumber != "testapp") {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
    });
    if (Profile.listStudent.isNotEmpty) {
      Profile.currentStudent = Profile.listStudent[0] as Student;
    }
    _selectedIndex = 0;
    _classBloc
        .add(LoadClass(Profile.currentYear, student: Profile.currentStudent));
    _pageController = PageController(initialPage: _selectedIndex);

    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
    _scrollController3 = ScrollController();
    _scrollController4 = ScrollController();
    _scrollControllerBus = ScrollController();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused: // screen off/navigate away
        // this.screenOn = false;
        print("paused");
        break;
      case AppLifecycleState.resumed: // screen on/navigate to
        _movementBloc.add(LoadMovement(
            Profile.phoneNumber ?? "", Profile.companyCode, DateTime.now()));
        ;
        break;
      case AppLifecycleState.inactive: // screen off/navigate away

        break;
      case AppLifecycleState.detached:
        print("detached");
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController1.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();
    _scrollController4.dispose();
    _scrollControllerBus.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> _widgetOptions = <Widget>[
      ClassInfoV2(scrollController: _scrollController1),
      // BusToSchoolScreen(scrollController: _scrollControllerBus),
      LessonScreenV2(student: Profile.currentStudent),
      MenuWeek(scrollController: _scrollController3),
      // TimeTableScreen(),
      TuitionFeeScreen(scrollController: _scrollController4)
    ];

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (BuildContext context) => _attendanceBloc),
            BlocProvider(create: (BuildContext context) => _lessonBloc),
            BlocProvider(create: (BuildContext context) => _classBloc),
            BlocProvider(create: (BuildContext context) => _schoolYearBloc),
            BlocProvider(create: (BuildContext context) => _invoiceBloc),
            BlocProvider(create: (BuildContext context) => _movementBloc),
            BlocProvider(create: (BuildContext context) => _timeTableBloc),
          ],
          child: Scaffold(
            drawer: MyDrawer('HomePage'),
            appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                elevation: 0,
                // bottomOpacity: 0,
                backgroundColor: kPrimaryColor,
                centerTitle: true,
                title: Text(
                  "Học viên",
                  style: TextStyle(color: Colors.white),
                )),
            // appBarCustom(size),
            body: Container(
              width: size.width,
              height: size.height,
              child: Column(
                children: [
                  Flexible(
                    flex: 20,
                    child: RVEPopupChooseOption(
                      currentStudent: Profile.currentStudent,
                      label: "Chọn học viên",
                      data: Profile.listStudent,
                      selected: selectedStudent,
                      onChange: (value) async {
                        // setState(() {
                        if (Profile.listStudent.isNotEmpty) {
                          Profile.currentStudent =
                              Profile.listStudent[value] as Student;
                          Profile.listTimeTable = [];

                          // if (Profile.currentStudent.classRoom.isNotEmpty) {
                          //   if (Profile.currentStudent.classRoom[0]
                          //       .listTimeTable!.isNotEmpty) {
                          //     Profile.listTimeTable = Profile
                          //         .currentStudent
                          //         .classRoom[0]
                          //         .listTimeTable as List<TimeTable>;
                          //   }
                          //   _timeTableBloc.add(
                          //       LoadTimeTable(dayWeek: DateTime.now().weekday));
                          // }

                          secureStore.writeSecureData(
                              'selectedStudent', value.toString());
                          print(Profile.currentStudent.studentName);

                          if (_selectedIndex == 0) {
                            Profile.currentYear = "";
                            _schoolYearBloc.add(LoadSchoolYear());
                            _classBloc.add(LoadClass(Profile.currentYear,
                                student: Profile.currentStudent));
                            _attendanceBloc.add(LoadAttendance(
                                Profile.currentDateAtten,
                                student: Profile.currentStudent));
                          }

                          // if (_selectedIndex == 1) {
                          //   _movementBloc.add(LoadMovement(
                          //       Profile.phoneNumber ?? "",
                          //       Profile.companyCode,
                          //       DateTime.now()));
                          // }

                          if (_selectedIndex == 1) {
                            _lessonBloc.add(LoadLesson(
                                grade: Profile.currentClassRoom.gradeCode));
                          }

                          // if (_selectedIndex == 3) {
                          //   _timeTableBloc.add(
                          //       LoadTimeTable(dayWeek: DateTime.now().weekday));
                          // }
                          if (_selectedIndex == 3) {
                            _invoiceBloc.add(
                                LoadInvoice(student: Profile.currentStudent));
                          }
                        }
                        // _selectedIndex = _selectedIndex;
                        // });
                      },
                      enable: true,
                    ),
                  ),
                  Flexible(
                    flex: 80,
                    child: PageView(
                      controller: _pageController,
                      // scrollDirection: Axis.vertical,
                      onPageChanged: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },

                      children: _widgetOptions,
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              selectedLabelStyle:
                  GoogleFonts.montserrat(fontWeight: FontWeight.w600),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: _selectedIndex == 0
                      ? Image.asset(
                          "images/icon/diem_danh.png",
                          height: 30,
                          width: 30,
                        )
                      : ImageIcon(
                          AssetImage(
                            "images/icon/diem_danh.png",
                          ),
                          size: 30),

                  label: 'Điểm danh',
                  // backgroundColor: Colors.red,
                ),
                BottomNavigationBarItem(
                  icon: _selectedIndex == 1
                      ? Image.asset(
                          "images/icon/giao_trinh.png",
                          height: 30,
                          width: 30,
                        )
                      : Icon(Icons.book_outlined, size: 30),

                  label: 'Giáo trình',
                  // backgroundColor: Colors.pink,
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(
                //     Icons.directions_bus_sharp,
                //     size: 30,
                //   ),
                //   label: 'BUS',
                //   // backgroundColor: Colors.red,
                // ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("images/icon/TD.png"),
                    size: 30,
                  ),
                  label: 'Thực đơn',
                  // backgroundColor: Colors.pink,
                ),
                // BottomNavigationBarItem(
                //   icon: _selectedIndex == 3
                //       ? Image.asset(
                //           "images/icon/TKB.png",
                //           height: 30,
                //           width: 30,
                //         )
                //       : ImageIcon(
                //           AssetImage(
                //             "images/icon/TKB.png",
                //           ),
                //           size: 30),
                //   label: 'TKB',
                //   // backgroundColor: Colors.pink,
                // ),
                BottomNavigationBarItem(
                  icon: _selectedIndex == 4
                      ? Image.asset(
                          "images/icon/hoc_phi.png",
                          height: 30,
                          width: 30,
                        )
                      : Icon(Icons.currency_exchange_rounded),

                  label: 'Học phí',
                  // backgroundColor: Colors.pink,
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: kPrimaryColor,
              unselectedItemColor: Colors.grey[400],
              onTap: (index) {
                setState(() {
                  // _selectedIndex = index;s
                  _pageController.jumpToPage(
                    index,
                    // duration: const Duration(milliseconds: 500),
                    // curve: Curves.ease
                  );
                });
              },
            ),
          ),
        ));
  }
}

void _showSnackBar(
    BuildContext context, String message, Color color, int seconds) {
  final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: Duration(seconds: seconds));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
