import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dialog_capture_controller.dart';

class DialogCaptureFaceWidget extends StatelessWidget {
  final CaptureFaceController controller = Get.put(CaptureFaceController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Chụp ảnh điểm danh",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Hiển thị ảnh đã chụp hoặc Camera preview
            Obx(() {
              return controller.capturedImage.value != null
                  ? Stack(
                      children: [
                        Image.file(
                          controller.capturedImage.value!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Icon(Icons.close, color: Colors.red),
                            onPressed: () {
                              controller.removeImage();
                            },
                          ),
                        ),
                      ],
                    )
                  : controller.isCameraInitialized.value
                      ? Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 4 / 3,
                              child: CameraPreview(controller.cameraController),
                            ),
                            Positioned(
                              left: 0,
                              bottom: 10,
                              child: GestureDetector(
                                onTap: () async {
                                  if (controller.capturedImage.value == null) {
                                    await controller
                                        .capturePhoto(); // Chụp ảnh nếu chưa có
                                  }
                                },
                                child: Icon(Icons.camera_alt_outlined,
                                    size: 40, color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      : CircularProgressIndicator(); // Hiển thị khi đang khởi tạo camera
            }),
            const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () async {
            //     if (controller.capturedImage.value == null) {
            //       await controller.capturePhoto(); // Chụp ảnh nếu chưa có
            //     }
            //   },
            //   child: Text(controller.capturedImage.value == null
            //       ? "Chụp ảnh"
            //       : "Chụp lại"),
            // ),
            // const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Đóng dialog
                  },
                  child: Text("Quay lại"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Đóng dialog

                    controller.markAttendance(); // Gọi hàm điểm danh
                  },
                  child: Text("Điểm danh"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
