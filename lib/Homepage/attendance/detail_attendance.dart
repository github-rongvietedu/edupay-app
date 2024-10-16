import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../../models/face_attendance_result.dart';
import '../../widget/text_with_dot.dart';

class DetailAttendance extends StatelessWidget {
  final Attendance attendance;
  const DetailAttendance({Key? key, required this.attendance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateFormat dateFormat = DateFormat("HH:mm:ss");

    return Scaffold(
        appBar: AppBar(
          title: const Text("Điểm danh nhận diện khuôn mặt"),
          backgroundColor: kPrimaryColor,
          elevation: 0,
        ),
        body: Container(
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
                            attendance.uRLCaptureImage,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Image.asset('images/noimage.jpg');
                            },
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                  )
                ]),
            buildWidgetAttendance(size, attendance)
          ]),
        )));
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
                        .format(attendance.captureAt ?? DateTime.now()),
                    style: kTextStyleTable),
                _textWithSpace(
                    "Giờ điểm danh:",
                    dateFormat.format(attendance.captureAt ?? DateTime.now()),
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
