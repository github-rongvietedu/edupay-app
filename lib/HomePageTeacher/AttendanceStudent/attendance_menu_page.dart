import 'package:edupay/HomePageTeacher/AttendanceStudent/box_animation_widget.dart';
import 'package:edupay/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Homepage/Widget/edupay_appbar.dart';
import '../../constants.dart';
import '../../core/base/base_view_view_model.dart';
import 'attendance_menu_controller.dart';

class AttendanceMenuPage extends BaseView<AttendanceMenuController> {
  @override
  Widget baseBuilder(BuildContext context) {
    // TODO: implement build

    Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                height: 40,
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Text('Điểm danh hàng loạt',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.QUICKATTENDANCESTUDENT);
                },
                child: Container(
                  height: 40,
                  margin: EdgeInsets.all(4),
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text('Điểm danh nhanh',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [Color(0xffED5627), Colors.red.shade700],
              // ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: statusBarHeight,
                ),
                EdupayAppBar(
                  titleWidget: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Điểm danh học viên lớp 10A1',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Ngày 16/10/2024",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  height: size.height * 0.77,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          // topLeft: Radius.circular(24),
                          // topRight: Radius.circular(24),
                          )),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      buildStudentItem(size, "", 0),
                      buildStudentItem(size, "", 0),
                      buildStudentItem(size, "", 0),
                      buildStudentItem(size, "", 0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: (size.height * 0.23) / 2, left: 0, child: buildTabBar(size)),
        ],
      ),
    );
  }

  Widget buildTabBar(
    Size size,
  ) {
    return Container(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // First container
          AttendanceBoxAnimation(
            index: 0,
            countStudent: 1,
            title: 'Chưa điểm danh',
          ),
          SizedBox(width: 20), // Khoảng cách giữa 2 container
          // Second container
          AttendanceBoxAnimation(
            index: 1,
            countStudent: 2,
            title: 'Có mặt',
            color: Colors.green,
          ),
          SizedBox(width: 20),
          AttendanceBoxAnimation(
              index: 2, countStudent: 3, title: 'Tất cả', color: Colors.blue)
        ],
      ),
    );
  }

  Container buildStudentItem(Size size, var display, int index) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 6.0),
            margin: EdgeInsets.only(
              left: 8,
              right: 8,
              top: 6,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.1),

                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(1, 2), // changes position of shadow
                  ),
                ]),
            height: 70,
            width: size.width,
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6.0),
                    bottomRight: Radius.circular(6.0)),
                color: Colors.white,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipOval(
                      child: Image.network(
                        'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif', // URL ảnh học sinh
                        width: 45,
                        height: 45,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        flex: 65,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Lê Hùng Quý",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "07/07/1999",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Trạng thái",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          "Chưa điểm danh",
                          style: TextStyle(fontSize: 10, color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 12,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),

                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ]),
                            child: Icon(
                              Icons.check,
                              color: Colors.green,
                            ),

                            // Text('Điểm danh',
                            //     style: TextStyle(
                            //         color: Colors.green,
                            //         fontSize: 12,
                            //         fontWeight: FontWeight.bold)),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
