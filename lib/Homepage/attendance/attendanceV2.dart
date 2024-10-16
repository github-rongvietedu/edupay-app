import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../../models/face_attendance_result.dart';
import '../../models/profile.dart';
import 'bloc/attendance_bloc.dart';
import 'bloc/attendance_event.dart';
import 'bloc/attendance_state.dart';
import 'detail_attendance.dart';

class AttendanceScreenV2 extends StatefulWidget {
  const AttendanceScreenV2({Key? key}) : super(key: key);
  // final Student? student;
  // final scrollController;
  @override
  State<AttendanceScreenV2> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreenV2> {
  // late Student? student;
  late AttendanceBloc _attendanceBloc;
  DateTime currentDate = Profile.currentDateAtten;

  final TextStyle _textStyle = GoogleFonts.ptSansNarrow(
      fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blue);

  DateTimeRange _dateRangePickerDialog =
      DateTimeRange(start: Profile.firstDayOfWeek, end: Profile.lastDayOfWeek);
  Future pickDateRange() async {
    final picked = await showDateRangePicker(
      // initialEntryMode: DatePickerEntryMode.calendar,
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
      initialDateRange: _dateRangePickerDialog,
      // currentDate: Profile.currentDateAtten,
      locale: const Locale('vi', ''),
      firstDate: DateTime(2019),
      lastDate: DateTime(DateTime.now().year + 2),
    );
    if (picked != null) {
      _dateRangePickerDialog =
          DateTimeRange(start: picked.start, end: picked.end);

      Profile.firstDayOfWeek = picked.start;
      Profile.lastDayOfWeek = picked.end;
      _attendanceBloc.add(LoadAttendanceDateRange(
          firstDate: picked.start,
          lastDate: picked.end,
          student: Profile.currentStudent));
    }
  }

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
      _attendanceBloc
          .add(LoadAttendance(pickedDate, student: Profile.currentStudent));
      currentDate = pickedDate;
      Profile.currentDateAtten = pickedDate; // set value to homePage
    }
  }

  @override
  void initState() {
    super.initState();
    // student = widget.student;
    // _attendanceBloc = context.read<AttendanceBloc>()
    //   ..add(LoadAttendance(Profile.currentDateAtten,
    //       student: Profile.currentStudent));
    _attendanceBloc = context.read<AttendanceBloc>()
      ..add(LoadAttendanceDateRange(
          firstDate: Profile.firstDayOfWeek,
          lastDate: Profile.lastDayOfWeek,
          student: Profile.currentStudent));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<AttendanceBloc, AttendanceState>(
      listener: (context, state) {
        switch (state.status) {
          case AttendanceStatus.failure:
            // _showSnackBar(context, state.message, Colors.red);
            break;
          case AttendanceStatus.initial:
            // TODO: Handle this case.
            break;
          case AttendanceStatus.changed:
            // TODO: Handle this case.
            break;
          case AttendanceStatus.success:
            // TODO: Handle this case.
            break;
        }
      },
      child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: size.height * 0.1,
            minWidth: size.width,
            maxHeight: double.infinity,
          ),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // _selectDate(context);

                        pickDateRange();
                      },
                      child: Container(
                        height: 40,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Icon(Icons.person, size: 30, color: Colors.grey[500]),
                            const SizedBox(
                              width: 8,
                            ),
                            Text("Điểm danh:", style: kTextStyleTitle),
                            const Spacer(),
                            const Icon(Icons.calendar_month,
                                size: 36, color: Colors.blue),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<AttendanceBloc, AttendanceState>(
                        builder: (context, state) {
                      // do stuff here based on BlocA's state

                      switch (state.status) {
                        case AttendanceStatus.failure:
                          return Center(
                              child: Text('failed to fetch Attendance'));

                        case AttendanceStatus.initial:
                          break;
                        case AttendanceStatus.changed:
                          return Center(
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator()));

                        case AttendanceStatus.success:
                          return state.listAttendance.isNotEmpty
                              ? Flexible(
                                  child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.listAttendance.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return buildWidgetAttendance(
                                            size, state.listAttendance, index);
                                      }),
                                )
                              : buildWidgetNotAttendance(size);
                      }
                      return Center(
                          child: Container(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator()));
                    }),
                  ]))),
    );
  }

  Widget buildWidgetNotAttendance(Size size) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "${dateFormatDay.format(Profile.firstDayOfWeek)} - ${dateFormatDay.format(Profile.lastDayOfWeek)}",
                    style: kTextStyleTitleColor),

                // Text(dateFormatDay.format(currentDate), style: kTextStyleTable),
                _textWithSpace("Tình trạng:", "Chưa điểm danh", 5, 5),
                // _textWithSpace("Giờ đi học:", "07:15", 5, 5),
                // _textWithSpace("Giờ tan trường:", "16:30", 5, 5),
              ],
            )),
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
                    overflow: TextOverflow.ellipsis,
                    style: kTextStyleNomalBrown))),
        Flexible(
            flex: flex2,
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(text2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: kTextStyleBold)))
      ],
    );
  }

  Widget buildWidgetAttendance(
      Size size, List<Attendance> attendance, int index) {
    DateFormat dateFormat = DateFormat("HH:mm:ss");
    DateFormat dateFormatDay = DateFormat("dd/MM/yyyy");
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailAttendance(
                      attendance: attendance[index],
                    )));
      },
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
              padding: const EdgeInsets.only(left: 12, bottom: 8, right: 12),
              child: Row(
                children: [
                  Flexible(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            dateFormatDay.format(
                                attendance[index].captureAt ?? DateTime.now()),
                            style: kTextStyleTitleColor),
                        _textWithSpace(
                            "Giờ điểm danh:",
                            dateFormat.format(
                                attendance[index].captureAt ?? DateTime.now()),
                            5,
                            5),
                        _textWithSpace("Vị trí:",
                            attendance[index].deviceName ?? "", 5, 5),

                        // _textWithSpace("Giờ đi học:", "07:15", 6, 4),
                        // _textWithSpace("Giờ tan trường:", "16:30", 6, 4),
                        // TextWithDot(
                        //     text: "Giờ điểm danh: " +
                        //         dateFormat.format(attendance[index].captureAt ??
                        //             DateTime.now()),
                        //     style: kTextStyleNomal),
                        // TextWithDot(
                        //     text: "Giờ đi học: 07:15", style: kTextStyleNomal),
                        // TextWithDot(
                        //     text: "Giờ tan trường: 16:30 ",
                        //     style: kTextStyleNomal)
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: attendance == null
                            ? Image.asset('images/noimage.jpg')
                            : Image.network(
                                attendance[index].uRLCaptureImage,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Image.asset('images/noimage.jpg');
                                },
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                      ))
                ],
              )),
        ),
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String message, Color color) {
  final snackBar = SnackBar(content: Text(message), backgroundColor: color);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
