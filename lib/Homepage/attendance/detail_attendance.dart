import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../../models/face_attendance_result.dart';
import '../../widget/text_with_dot.dart';
import '../Widget/edupay_appbar.dart';

class DetailAttendance extends StatelessWidget {
  final Attendance attendance;
  const DetailAttendance({Key? key, required this.attendance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateFormat dateFormat = DateFormat("HH:mm:ss");
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
        // backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: const Text("Điểm danh nhận diện khuôn mặt"),
        //   backgroundColor: kPrimaryColor,
        //   elevation: 0,
        // ),
        body: Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [Color(0xffED5627), Colors.red.shade700],
        // ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: statusBarHeight,
          ),
          EdupayAppBar(
            onBackPressed: () => Navigator.of(context).pop(),
            titleWidget: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Chi tiết điểm danh',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Spacer(),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(12),
                // height: size.height * 0.87,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 10, // 70%
                            child: attendance == null
                                ? Image.asset('images/noimage.jpg')
                                : Image.network(
                                    attendance.faceImageURL,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
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
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
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
                          )
                        ]),
                    buildWidgetAttendance(size, attendance)
                  ]),
                )),
          ),
        ],
      ),
    ));
  }

  Row _textWithSpace(String text1, String text2, Size size) {
    return Row(
      children: [
        Flexible(
            flex: 4,
            child: Container(
                width: size.width,
                child: Text(text1,
                    overflow: TextOverflow.ellipsis,
                    style: kTextStyleNomalBrown))),
        Flexible(
            flex: 6,
            child: Container(
                width: size.width,
                child: Text(text2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: kTextStyleBold)))
      ],
    );
  }

  Widget buildWidgetAttendance(Size size, Attendance attendance) {
    DateFormat dateFormat = DateFormat("HH:mm:ss");
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
                    dateFormatDay
                        .format(attendance.captureTime ?? DateTime.now()),
                    style: kTextStyleTable),
                _textWithSpace(
                    "Giờ điểm danh:",
                    dateFormat.format(attendance.captureTime ?? DateTime.now()),
                    size),
                _textWithSpace("Vị trí:", attendance.deviceName ?? "", size),
                // TextWithDot(
                //     text: "Giờ điểm danh: " +
                //         dateFormat.format(attendance[index].captureAt ??
                //             DateTime.now()),
                //     style: kTextStyleNomal),
                // _textWithSpace("Giờ đi học:", "07:15", size),
                // _textWithSpace("Giờ tan trường:", "16:30", size),
              ],
            )),
      ),
    );
  }
}
