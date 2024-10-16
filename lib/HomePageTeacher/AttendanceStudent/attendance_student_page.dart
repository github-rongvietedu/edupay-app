import 'dart:math';

import 'package:camera/camera.dart';
import 'package:edupay/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Homepage/Widget/edupay_appbar.dart';
import '../../core/base/base_view_view_model.dart';
import 'attendance_student_controller.dart';

class AttendanceStudentPage extends BaseView<AttendanceStudentController> {
  @override
  Widget baseBuilder(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      // appBar: AppBar(
      //     foregroundColor: Colors.white,
      //     backgroundColor: kPrimaryColor,
      //     title: Text("Điểm danh học viên", style: TextStyle(fontSize: 16)),
      //     centerTitle: true),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: statusBarHeight,
            ),
            EdupayAppBar(
              titleWidget: Center(
                child: Text(
                  'Điểm danh học viên',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                // height: size.height * 0.87,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    )),
                child: Column(
                  children: [
                    // Top section: Attendance tabs
                    TabBar(
                      controller: controller.tabController,
                      tabs: [
                        Tab(text: 'Chưa điểm danh'),
                        Tab(text: 'Đã điểm danh'),
                      ],
                    ),
                    // Student list and first-time guide
                    Expanded(
                      flex: 45,
                      child: Obx(() {
                        if (controller.isFirstTimeUsingApp.value) {
                          return _buildFirstTimeGuide(); // Hiển thị hướng dẫn lần đầu
                        } else {
                          return TabBarView(
                            controller: controller.tabController,
                            children: [
                              buildStudentGrid(
                                  context, size, false), // Chưa điểm danh
                              buildStudentGrid(
                                  context, size, true), // Đã điểm danh
                            ],
                          );
                        }
                      }),
                    ),
                    // Bottom section: Camera interface
                    Expanded(
                      flex: 55,
                      child: Obx(() {
                        if (controller.isCameraInitialized.value) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1,
                                      child: CameraPreview(
                                          controller.cameraController),
                                    ),
                                    Positioned(
                                      left: size.width / 2 - 25,
                                      bottom: 25,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (controller
                                                  .selectedStudent.value !=
                                              null) {
                                            controller.takePicture().then((_) {
                                              _showConfirmationDialog(
                                                  context); // Hiển thị dialog sau khi chụp
                                            });
                                          } else {
                                            Get.snackbar('Chọn học sinh',
                                                'Vui lòng chọn học sinh trước khi chụp ảnh.');
                                          }
                                        },
                                        child: Icon(Icons.camera_alt_outlined,
                                            size: 40, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstTimeGuide() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hướng dẫn chụp ảnh điểm danh',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Bước 1: Đưa camera đến gần khuôn mặt của học sinh.'),
            Text('Bước 2: Chọn biểu tượng chụp ảnh để bắt đầu.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.confirmIntroduce(); // Đánh dấu đã xem hướng dẫn
              },
              child: Text('Tôi đã hiểu'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStudentGrid(context, Size size, bool isPresent) {
    List<Student> listDisplay = controller.students
        .where((element) => element.isPresent == isPresent)
        .toList();
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: listDisplay.length,
      itemBuilder: (context, index) {
        var student = controller.students
            .where((element) => element.id == listDisplay[index].id)
            .first;

        bool isSelected = controller.selectedStudent.value?.id == student.id;

        return (student.isPresent == isPresent) // Kiểm tra điểm danh
            ? GestureDetector(
                onTap: () {
                  // controller.markedStudent(student);
                  // student.isMarked = !student.isMarked;
                  controller.markedStudent(student);
                  controller.update();
                },
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      decoration: BoxDecoration(
                        // color: Colors.amber,
                        border: controller.selectedStudent.value?.id ==
                                student.id
                            ? Border.all(
                                color: kPrimaryColor,
                                width: 2) // Hiệu ứng viền đỏ khi chọn học sinh
                            : null,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.network(
                              'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif', // URL ảnh học sinh
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(student.name,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox();
      },
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận điểm danh'),
          content:
              Text('Bạn có muốn xác nhận điểm danh cho học sinh này không?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.snackbar('Chụp lại', 'Vui lòng chụp lại ảnh.');
              },
              child: Text('Chụp lại'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.attendanceStudent();

                Navigator.of(context).pop();
                Get.snackbar(
                    'Đã điểm danh', 'Học sinh đã được điểm danh thành công.');
              },
              child: Text('Xác nhận'),
            ),
          ],
        );
      },
    );
  }
}
