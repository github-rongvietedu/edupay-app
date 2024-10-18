import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class CaptureFaceController extends GetxController
    with GetTickerProviderStateMixin {
  late CameraController cameraController;
  // var selectedStudent = Rxn<Student>();
  var isCameraInitialized = false.obs; // Trạng thái camera đã khởi tạo
  var isFirstTimeUsingApp = true.obs;
  Rx<File?> capturedImage = Rx<File?>(null); // Quản lý ảnh đã chụp

  @override
  void onInit() {
    super.onInit();
    checkPermissions();
  }

  Future<void> checkPermissions() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      // Quyền đã được cấp, khởi tạo camera
      await initializeCamera();
    } else if (status.isDenied) {
      // Quyền bị từ chối
      _showPermissionDeniedDialog(Get.context!);
    } else if (status.isPermanentlyDenied) {
      // Quyền bị từ chối vĩnh viễn
      _showPermissionPermanentlyDeniedDialog(Get.context!);
    }
  }

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      cameraController = CameraController(cameras.first, ResolutionPreset.high);
      await cameraController.initialize();

      // Cập nhật trạng thái camera đã khởi tạo
      isCameraInitialized.value = true;
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> capturePhoto() async {
    try {
      if (!cameraController.value.isInitialized) {
        return;
      }
      final image = await cameraController.takePicture();
      capturedImage.value = File(image.path); // Lưu ảnh đã chụp
    } catch (e) {
      print('Error capturing photo: $e');
    }
  }

  void removeImage() {
    capturedImage.value = null;
  }

  void markAttendance() {
    if (capturedImage.value != null) {
      // Xử lý logic điểm danh với ảnh đã chụp
      Get.snackbar("Điểm danh", "Điểm danh thành công!");
    } else {
      Get.snackbar("Lỗi", "Vui lòng chụp ảnh trước khi điểm danh.");
    }
  }

  @override
  void onClose() {
    cameraController.dispose(); // Giải phóng camera khi đóng dialog
    super.onClose();
  }

  // Dialog báo quyền bị từ chối
  void _showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Quyền truy cập bị từ chối"),
        content: Text("Ứng dụng cần quyền truy cập camera để hoạt động."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  // Dialog báo quyền bị từ chối vĩnh viễn
  void _showPermissionPermanentlyDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Quyền truy cập bị từ chối vĩnh viễn"),
        content: Text("Vui lòng mở cài đặt để cấp quyền camera."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
