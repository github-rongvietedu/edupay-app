import 'package:edupay/HomePageTeacher/AttendanceStudent/box_animation_widget.dart';
import 'package:edupay/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Homepage/Widget/DialogCapture/dialog_capture_widget.dart';
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
                  onBackPressed: () => Get.back(),
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
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Expanded(
                          child: Obx(
                        () => ListView.builder(
                            padding: EdgeInsets.only(bottom: 5),
                            itemCount: controller.filteredStudents.length,
                            itemBuilder: (context, index) {
                              Student student =
                                  controller.filteredStudents[index];
                              return buildStudentItem(
                                  context, size, student, index);
                            }),
                      )),
                      SizedBox(
                        height: 5,
                      ),
                      // buildStudentItem(size, "", 0),
                      // buildStudentItem(size, "", 0),
                      // buildStudentItem(size, "", 0),
                      // buildStudentItem(size, "", 0),
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
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AttendanceBoxAnimation(
                index: 0,
                countStudent: controller.lengthAll.value,
                title: 'Tất cả',
                color: Colors.blue),
            SizedBox(width: 20),

            // First container
            AttendanceBoxAnimation(
              index: 1,
              countStudent: controller.lengthAbsent.value,
              title: 'Chưa điểm danh',
            ),
            SizedBox(width: 20), // Khoảng cách giữa 2 container
            // Second container
            AttendanceBoxAnimation(
              index: 2,
              countStudent: controller.lengthPresent.value,
              title: 'Có mặt',
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStudentItem(
      BuildContext context, Size size, Student student, int index) {
    Color color = Colors.red;
    String status = "Chưa điểm danh";
    Icon icon = Icon(Icons.check, color: Colors.green);
    if (student.isPresent) {
      color = Colors.green;
      status = "Có mặt";
      icon = Icon(Icons.close, color: Colors.red);
    }

    return Obx(
      () => AnimatedContainer(
        curve: Curves.easeInOut,
        duration: Duration(
            milliseconds:
                controller.startAnimation.value ? 300 + (index * 150) : 300),
        transform: Matrix4.translationValues(
            controller.startAnimation.value ? 0 : size.width, 0, 0),
        margin: EdgeInsets.only(top: 8),
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
                  color: color,
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.1),

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
                                student.name,
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
                            status,
                            style: TextStyle(fontSize: 10, color: color),
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
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogCaptureFaceWidget(); // Gọi dialog chụp ảnh điểm danh
                                  },
                                );

                                // DialogCaptureFaceWidget();
                              },
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
                                child: icon,

                                // Text('Điểm danh',
                                //     style: TextStyle(
                                //         color: Colors.green,
                                //         fontSize: 12,
                                //         fontWeight: FontWeight.bold)),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
