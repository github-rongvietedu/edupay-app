import 'package:camera/camera.dart';
import 'package:edupay/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/base/base_controller.dart';

class QuickAttendanceStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuickAttendanceStudentController());
  }
}

class QuickAttendanceStudentController extends BaseController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final List<Student> students = [
    Student(
        id: 1,
        name: 'Nguyen Van A',
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
  late CameraController cameraController;
  var selectedStudent = Rxn<Student>();
  // Observable to track camera initialized state
  var isCameraInitialized = false.obs;
  var isFirstTimeUsingApp = true.obs;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    initializeCamera();
  }

  Future<void> checkPermissions() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      // Quyền đã được cấp, bạn có thể sử dụng camera
      initializeCamera();
    } else if (status.isDenied) {
      // Quyền bị từ chối, hiển thị thông báo
      _showPermissionDeniedDialog(Get.context!);
    } else if (status.isPermanentlyDenied) {
      // Quyền bị từ chối vĩnh viễn, yêu cầu người dùng mở cài đặt
      _showPermissionPermanentlyDeniedDialog(Get.context!);
    }
  }

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      cameraController = CameraController(cameras.first, ResolutionPreset.high);
      await cameraController.initialize();

      // Set camera initialized state to true
      isCameraInitialized.value = true;
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  confirmIntroduce() {
    isFirstTimeUsingApp.value = false;
  }

  attendanceStudent() {
    if (selectedStudent.value == null) return;
    students.forEach((element) {
      if (element.id == selectedStudent.value!.id) {
        element.isPresent = true;
      }
    });
    update();
  }

  markedStudent(Student student) {
    selectedStudent.value = student;
    selectedStudent.value!.isMarked = true;
    // selectedStudent.value =
    //     students.firstWhere((element) => element.id == studentID);
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

  Future<void> takePicture() async {
    if (isCameraInitialized.value) {
      try {
        final image = await cameraController.takePicture();
        Get.snackbar('Hình ảnh đã chụp', image.path);
        // Handle the captured image path (e.g., display or save)
      } catch (e) {
        print('Error taking picture: $e');
      }
    } else {
      Get.snackbar('Camera chưa được khởi tạo', 'Vui lòng thử lại sau.');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

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
