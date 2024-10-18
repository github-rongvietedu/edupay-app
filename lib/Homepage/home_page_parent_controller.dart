import 'package:edupay/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../../core/base/base_controller.dart';
import '../models/secure_store.dart';
import '../models/student.dart';
import '../routes/app_pages.dart';

class HomePageParentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageParentController());
  }
}

class HomePageParentController extends BaseController {
  final secureStore = SecureStore();
  var listStudent = <int, Student>{}.obs;
  var selectedStudent = Student().obs;
  var isLoading = true.obs;
  // Method to select student and save ID to secure storage
  var selectedIndex = 0.obs;

  // PageController to manage PageView
  final PageController pageController = PageController();

  void changeTabIndex(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  static TextEditingController userNameController =
      TextEditingController(text: '');
  static TextEditingController passwordController =
      TextEditingController(text: '');

  final List<Map<String, dynamic>> items = [
    {
      'key': 'attendance',
      'title': 'Điểm danh',
      'icon': "images/icon/diem_danh.png",
      'color': Colors.red,
      'route': Routes.ATTENDANCE
    },
    {
      'key': 'leaveapplication',
      'title': 'Xin nghỉ phép',
      'icon': 'images/icon/checklist.png',
      'color': Colors.orange,
      'route': Routes.LEAVEAPPLICATION
    },
    {
      'key': 'lesson',
      'title': 'Giáo trình',
      'icon': 'images/icon/giao_trinh.png',
      'color': Colors.blue,
      'route': Routes.LESSON
    },
    {
      'key': 'foodmenu',
      'title': 'Thực đơn',
      'icon': 'images/icon/TD.png',
      'color': Colors.green,
      'route': Routes.FOODMENU
    },
    {
      'key': 'tuition',
      'title': 'Học phí',
      'icon': 'images/icon/hoc_phi.png',
      'color': Colors.yellow,
      'route': Routes.TUITION
    },
    {
      'key': 'attendance',
      'title': 'Điểm danh học viên',
      'icon': "images/icon/diem_danh.png",
      'color': Colors.red,
      'route': Routes.ATTENDANCEMENU
    },

    // Add more items if needed
  ].obs;

  @override
  void onInit() async {
    loadStudent();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  void selectStudent(Student student) async {
    selectedStudent.value = student;
    // Save the student ID to secure storage
    await secureStore.writeSecureData("selectedStudent", student.id);
    Profile.currentStudent = student;
  }

  Future<void> loadStudent() async {
    listStudent.value = Profile.listStudent;
    // Try to restore selected student ID from secure storage
    String? savedStudentId =
        await secureStore.readSecureData('selectedStudentId');
    if (savedStudentId != null) {
      // Find the student with the saved ID
      selectedStudent.value = listStudent.values.firstWhere(
        (e) => e.id.toUpperCase() == savedStudentId?.toUpperCase(),
        orElse: () => listStudent
            .values.first, // Trả về phần tử đầu tiên nếu không tìm thấy
      );
    } else {
      // Default to the first student if no ID is found
      selectedStudent.value = listStudent.values.first;
    }
    Profile.currentStudent = selectedStudent.value;

    isLoading.value = false;
  }
}
