import 'package:edupay/models/profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../firebase_options.dart';
import '../../../models/BusToSchool/movement.dart';
import '../../../models/BusToSchool/movement_guest_detail.dart';
import 'bloc/movement_bloc.dart';
import 'bloc/movement_event.dart';
import 'bloc/movement_state.dart';
import 'components/bus_history.dart';

class BusToSchoolScreen extends StatefulWidget {
  final ScrollController scrollController;
  const BusToSchoolScreen({Key? key, required this.scrollController})
      : super(key: key);

  @override
  State<BusToSchoolScreen> createState() => _BusToSchoolScreenState();
}

class _BusToSchoolScreenState extends State<BusToSchoolScreen> {
  late ScrollController scrollController;
  DateFormat dateFormatDay = DateFormat("dd/MM/yyyy");
  DateFormat hourFormat = DateFormat("HH:mm:ss");

  late MovementBloc _movementBloc = MovementBloc(context);
  final TextStyle _textStyle = GoogleFonts.ptSansNarrow(
      fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blue);
  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.grey,
              colorScheme: const ColorScheme.light(
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
        initialDate: currentDate,
        firstDate: DateTime(2018),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      // print(pickedDate.toString());
      // _attendanceBloc
      //     .add(LoadAttendance(pickedDate, student: Profile.currentStudent));
      setState(() {
        currentDate = pickedDate;
      });

      _movementBloc.add(LoadMovement(
          Profile.phoneNumber ?? "", Profile.companyCode, pickedDate));
      // Profile.currentDateAtten = pickedDate; // set value to homePage
    }
  }

  @override
  void initState() {
    super.initState();

    scrollController = widget.scrollController;
    // _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _movementBloc = context.read<MovementBloc>()
      ..add(LoadMovement(
          Profile.phoneNumber ?? "", Profile.companyCode, currentDate));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(flex: 12, child: selectCalendarBtn(size)),
        Flexible(
          flex: 88,
          child: Stack(
            children: [
              // SingleChildScrollView(
              // controller: scrollController,
              // child:
              Column(
                children: [
                  BlocBuilder<MovementBloc, MovementState>(
                      builder: (context, state) {
                    switch (state.status) {
                      case MovementStatus.failure:
                        return buildWidgetNotHasMovement();

                      case MovementStatus.initial:
                        break;
                      case MovementStatus.changed:
                        return Center(
                            child: Container(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator()));

                      case MovementStatus.success:
                        return state.listMovement.isNotEmpty
                            ? Flexible(
                                child: Container(
                                  height: size.height * 0.6,
                                  child: ListView.builder(
                                      // controller: scrollController,
                                      // physics:
                                      //     const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.listMovement.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return buildMovementInfo(
                                            state.listMovement, index);
                                      }),
                                ),
                              )
                            : buildWidgetNotHasMovement();
                    }
                    return Center(
                        child: Container(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator()));
                  }),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  GestureDetector selectCalendarBtn(Size size) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.black12),
              borderRadius: BorderRadius.circular(8)),
          width: size.width,
          child: Row(
            // crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Image.asset(
                'images/icon/calendar-color.png',
                width: 36,
                height: 36,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10),
              Text('${dateFormatDay.format(currentDate)}',
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.7))),
              Icon(Icons.arrow_drop_down),
              Spacer(),
              // TextButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => BusHistory(),
              //         ),
              //       );
              //     },
              //     style: TextButton.styleFrom(
              //       foregroundColor: Colors.black.withOpacity(0.5),
              //     ),
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text('Lịch sử chuyến đi'),
              //         SizedBox(width: 5),
              //         Icon(Icons.arrow_forward_ios,
              //             size: 16, color: Colors.black.withOpacity(0.5)),
              //       ],
              //     )),
            ],
          ),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(left: 8, right: 8, bottom: 5)),
    );
  }

  Widget buildWidgetNotHasMovement() {
    Size size = MediaQuery.of(context).size;
    DateFormat dateFormatDay = DateFormat("dd/MM/yyyy");
    return Card(
      color: Colors.white,
      elevation: 2,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 140,
          minWidth: size.width,
          maxHeight: double.infinity,
        ),
        child: Container(
            padding:
                const EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 12),
            child: Column(
              children: [
                Image.asset(
                  'images/icon/bus_sleep.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                Text(
                  "Oops, không có chuyến xe nào.",
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.7)),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "",
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
      ),
    );
  }

  Card buildMovementInfo(List<Movement> movement, int index) {
    Size size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 2,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: size.height * 0.2),
        child: Container(
          // padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 0.5, color: Colors.black12)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 25,
                          child: Container(
                            height: size.width * 0.2,
                            width: size.width,
                            margin: EdgeInsets.only(right: 8, left: 8, top: 8),
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    "${movement[index].vehicleInfo!.vehicleRegistrationNumber}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 22,
                                    )),
                                Text(
                                    "Số hiệu: ${movement[index].vehicleInfo!.vehicleName}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 14,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _textDisplay(
                                    "Tình trạng: ",
                                    "${movement[index].statusName}",
                                    kTextStyleBold,
                                    kTextStyleNomalBrown),
                                // _textDisplay("Thời gian dự kiến:", "07:50 - 08:00",
                                //     kTextStyleBold, kTextStyleNomalBrown),
                                SizedBox(height: 8),
                                _textDisplay(
                                    "Tài xế:",
                                    "${movement[index].driverInfo!.fullName}",
                                    kTextStyleBold,
                                    kTextStyleNomalBrown),
                                SizedBox(height: 5),
                                _textDisplay(
                                    "SDT TX:",
                                    "${movement[index].driverInfo!.phoneNumber}",
                                    kTextStyleBold,
                                    kTextStyleNomalBrown),
                                SizedBox(height: 8),
                                _textDisplay(
                                    "Phụ trách:",
                                    "${movement[index].assistantInfo!.fullName}",
                                    kTextStyleBold,
                                    kTextStyleNomalBrown),
                                SizedBox(height: 5),
                                _textDisplay(
                                    "SDT PT:",
                                    "${movement[index].assistantInfo!.phoneNumber}",
                                    kTextStyleBold,
                                    kTextStyleNomalBrown),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 50,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: movement[index]
                                    .gts_MovementGuestDetail
                                    ?.length,
                                itemBuilder: (BuildContext context, int i) {
                                  return buildStudentInfo(
                                      movement[index].gts_MovementGuestDetail!,
                                      i);
                                }),
                          )
                        ],
                      ),
                    ),
                    //
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildStudentInfo(
      List<GTS_MovementGuestDetail> listStudent, int index) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(
            // top: 8,
            right: 5,
            bottom: 5,
            left: 5),
        height: 100,
        width: size.width,
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Flexible(
                flex: 30,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15, left: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Image border
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(48), // Image radius
                      child: Image.network(
                          listStudent[index].faceImageURL ?? "",
                          fit: BoxFit.cover),
                    ),
                  ),
                )),
            Flexible(
                flex: 70,
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5, left: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 50,
                        child: _textDisplay("${listStudent[index].studentName}",
                            "", kTextStyleBold, kTextStyleNomalBrown),
                      ),
                      Flexible(
                        flex: 25,
                        child: _textDisplay(
                            "Lên:",
                            listStudent[index].checkInDate == null
                                ? ""
                                : hourFormat.format(
                                    listStudent[index].checkInDate as DateTime),
                            kTextStyleBold,
                            kTextStyleNomalBrown),
                      ),
                      Flexible(
                        flex: 25,
                        child: _textDisplay(
                            "Xuống:",
                            "${listStudent[index].checkOutDate == null ? "" : hourFormat.format(listStudent[index].checkOutDate as DateTime)}",
                            kTextStyleBold,
                            kTextStyleNomalBrown),
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }

  // }
  RichText _textDisplay(
      String text1, String text2, TextStyle style1, TextStyle style2) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(text: text1, style: style1),
          TextSpan(text: " "),
          TextSpan(text: text2, style: style2),
        ],
      ),
    );
  }

  Row _textWithSpace(String text1, String text2, int flex1, int flex2) {
    return Row(
      children: [
        Flexible(
            flex: flex1,
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(text1,
                    // overflow: TextOverflow.ellipsis,
                    style: kTextStyleNomalBrown))),
        Flexible(
            flex: flex2,
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(text2,
                    overflow: TextOverflow.ellipsis, style: kTextStyleBold)))
      ],
    );
  }
}
