import 'dart:async';

import 'package:camera/camera.dart';
import 'package:edupay/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/base/base_controller.dart';

class AttendanceMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceMenuController());
  }
}

class AttendanceMenuController extends BaseController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  var selectedTabIndex = 0.obs; // Observable variable
  late AnimationController controllerAnimation;
  late Animation<double> animation;
  var startAnimation = false.obs;

  var lengthAll = 0.obs;
  var lengthPresent = 0.obs;
  var lengthAbsent = 0.obs;

  Timer? _timer;

  final List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.cyan,
  ];
  var shuffledColors =
      <Color>[].obs; // Observable list to store shuffled colors

  var selectedIndex = 0.obs; // Initialize with -1 (no selection)
  void selectContainer(int index) {
    selectedIndex.value = index; // Update selected index
    // startAnimation.value = false;
    // filteredStudents.clear();
    startAnimation.value = false;

    if (index == 0) {
      filteredStudents.assignAll(students);
    } else if (index == 1) {
      filteredStudents.assignAll(
          students.where((element) => element.isPresent == false).toList());
    } else if (index == 2) {
      filteredStudents.assignAll(
          students.where((element) => element.isPresent == true).toList());
    }
    Future.delayed(Duration(milliseconds: 400), () {
      // startAnimation.value = true;
      startAnimation.value = true;
    });
  }

  bool isSelected(int index) =>
      selectedIndex.value == index; // Check if the container is selected
  final List<Student> students = [
    Student(
        id: 1,
        name: 'Nguyen Van Aaaaaaaaaaaaaa',
        className: 'Class 1',
        rollNo: 1,
        isPresent: false),
    Student(
        id: 2,
        name: 'Tran Thi B',
        className: 'Class 1',
        rollNo: 2,
        isPresent: false),
    Student(
        id: 3,
        name: 'Le Van C',
        className: 'Class 1',
        rollNo: 3,
        isPresent: true),
    Student(
        id: 1,
        name: 'Nguyen Van Aaaaaaaaaaaaaa',
        className: 'Class 1',
        rollNo: 1,
        isPresent: false),
    Student(
        id: 2,
        name: 'Tran Thi B',
        className: 'Class 1',
        rollNo: 2,
        isPresent: false),
    Student(
        id: 3,
        name: 'Le Van C',
        className: 'Class 1',
        rollNo: 3,
        isPresent: true),
    Student(
        id: 1,
        name: 'Nguyen Van Aaaaaaaaaaaaaa',
        className: 'Class 1',
        rollNo: 1,
        isPresent: false),
    Student(
        id: 2,
        name: 'Tran Thi B',
        className: 'Class 1',
        rollNo: 2,
        isPresent: false),
    Student(
        id: 3,
        name: 'Le Van C',
        className: 'Class 1',
        rollNo: 3,
        isPresent: true),
    Student(
        id: 1,
        name: 'Nguyen Van Aaaaaaaaaaaaaa',
        className: 'Class 1',
        rollNo: 1,
        isPresent: false),
    Student(
        id: 2,
        name: 'Tran Thi B',
        className: 'Class 1',
        rollNo: 2,
        isPresent: false),
    Student(
        id: 3,
        name: 'Le Van C',
        className: 'Class 1',
        rollNo: 3,
        isPresent: true),
    Student(
        id: 1,
        name: 'Nguyen Van Aaaaaaaaaaaaaa',
        className: 'Class 1',
        rollNo: 1,
        isPresent: false),
    Student(
        id: 2,
        name: 'Tran Thi B',
        className: 'Class 1',
        rollNo: 2,
        isPresent: false),
    Student(
        id: 3,
        name: 'Le Van C',
        className: 'Class 1',
        rollNo: 3,
        isPresent: true),
    Student(
        id: 1,
        name: 'Nguyen Van Aaaaaaaaaaaaaa',
        className: 'Class 1',
        rollNo: 1,
        isPresent: false),
    Student(
        id: 2,
        name: 'Tran Thi B',
        className: 'Class 1',
        rollNo: 2,
        isPresent: false),
    Student(
        id: 3,
        name: 'Le Van C',
        className: 'Class 1',
        rollNo: 3,
        isPresent: true),
    Student(
        id: 1,
        name: 'Nguyen Van Aaaaaaaaaaaaaa',
        className: 'Class 1',
        rollNo: 1,
        isPresent: false),
    Student(
        id: 2,
        name: 'Tran Thi B',
        className: 'Class 1',
        rollNo: 2,
        isPresent: false),
    Student(
        id: 3,
        name: 'Le Van C',
        className: 'Class 1',
        rollNo: 3,
        isPresent: true),
    Student(
        id: 1,
        name: 'Nguyen Van Aaaaaaaaaaaaaa',
        className: 'Class 1',
        rollNo: 1,
        isPresent: false),
    Student(
        id: 2,
        name: 'Tran Thi B',
        className: 'Class 1',
        rollNo: 2,
        isPresent: false),
    Student(
        id: 3,
        name: 'Le Van C',
        className: 'Class 1',
        rollNo: 3,
        isPresent: true),
    Student(
        id: 1,
        name: 'Nguyen Van Aaaaaaaaaaaaaa',
        className: 'Class 1',
        rollNo: 1,
        isPresent: false),
    Student(
        id: 2,
        name: 'Tran Thi B',
        className: 'Class 1',
        rollNo: 2,
        isPresent: false),
    Student(
        id: 3,
        name: 'Le Van C',
        className: 'Class 1',
        rollNo: 3,
        isPresent: true),
    Student(
        id: 1,
        name: 'Nguyen Van Aaaaaaaaaaaaaa',
        className: 'Class 1',
        rollNo: 1,
        isPresent: false),
    Student(
        id: 2,
        name: 'Tran Thi B',
        className: 'Class 1',
        rollNo: 2,
        isPresent: false),
    Student(
        id: 3,
        name: 'Le Van C',
        className: 'Class 1',
        rollNo: 3,
        isPresent: true),
    Student(
        id: 1,
        name: 'Nguyen Van Aaaaaaaaaaaaaa',
        className: 'Class 1',
        rollNo: 1,
        isPresent: false),
    Student(
        id: 2,
        name: 'Tran Thi B',
        className: 'Class 1',
        rollNo: 2,
        isPresent: false),
    Student(
        id: 3,
        name: 'Le Van C',
        className: 'Class 1',
        rollNo: 3,
        isPresent: true),
  ].obs;

  var filteredStudents = <Student>[].obs;

  void startColorChangeTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      // Shuffle the colors every second
      shuffledColors.shuffle();
    });
  }

  loadStudent() {
    lengthAll.value = students.length;
    lengthPresent.value =
        students.where((element) => element.isPresent == true).length;
    lengthAbsent.value =
        students.where((element) => element.isPresent == false).length;
  }

  @override
  void onInit() {
    // Shuffle the colors initially
    shuffledColors.addAll(colors); // Add all colors to shuffledColors
    shuffledColors.shuffle(); // Shuffle the list

    controllerAnimation = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    animation = Tween<double>(begin: 0.7, end: 1).animate(CurvedAnimation(
      parent: controllerAnimation,
      curve: Curves.linear,
    ));

    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    filteredStudents.assignAll(students);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startAnimation.value = true;
    });
    loadStudent();
    // startColorChangeTimer();
    // initializeCamera();
  }

  Future<void> checkPermissions() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      // Quyền đã được cấp, bạn có thể sử dụng camera
      // initializeCamera();
    } else if (status.isDenied) {
      // Quyền bị từ chối, hiển thị thông báo
      _showPermissionDeniedDialog(Get.context!);
    } else if (status.isPermanentlyDenied) {
      // Quyền bị từ chối vĩnh viễn, yêu cầu người dùng mở cài đặt
      _showPermissionPermanentlyDeniedDialog(Get.context!);
    }
  }

  void _showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quyền truy cập camera bị từ chối'),
          content: Text('Vui lòng cấp quyền truy cập camera để tiếp tục.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Đóng'),
            ),
            ElevatedButton(
              onPressed: () {
                // Chuyển đến cài đặt ứng dụng
                openAppSettings();
              },
              child: Text('Mở cài đặt'),
            ),
          ],
        );
      },
    );
  }

  void _showPermissionPermanentlyDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quyền bị từ chối vĩnh viễn'),
          content: Text(
              'Bạn đã từ chối quyền camera vĩnh viễn. Vui lòng mở cài đặt và cấp quyền.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Đóng'),
            ),
            ElevatedButton(
              onPressed: () {
                // Chuyển đến cài đặt ứng dụng
                openAppSettings();
              },
              child: Text('Mở cài đặt'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement disposed
    super.dispose();
  }
}

class Student {
  final int id;
  final String name;
  final String className;
  final int rollNo;
  bool isPresent;
  bool isMarked;
  Student(
      {required this.id,
      required this.name,
      required this.className,
      required this.rollNo,
      this.isPresent = false,
      this.isMarked = false});
}

class StudentListItem extends StatelessWidget {
  final Student student;

  const StudentListItem({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: student.isPresent ? Colors.green : Colors.red,
        child: Icon(
          student.isPresent ? Icons.check : Icons.close,
          color: Colors.white,
        ),
      ),
      title: Text(student.name),
      subtitle: Text('Lớp: ${student.className}, Số thứ tự: ${student.rollNo}'),
      trailing: student.isPresent
          ? Icon(Icons.check_circle, color: Colors.green)
          : Icon(Icons.cancel, color: Colors.red),
    );
  }
}
