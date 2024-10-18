import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'attendance_menu_controller.dart';

class AttendanceBoxAnimation extends StatelessWidget {
  AttendanceBoxAnimation({
    super.key,
    required this.index,
    this.countStudent = 0,
    this.title = '',
    this.color = Colors.red,
  });
  final int index;
  final int countStudent;
  final String title;
  final Color color;
  final controller = Get.put(AttendanceMenuController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.selectContainer(index);
      },
      child: AnimatedBuilder(
        animation: controller.controllerAnimation,
        builder: (context, child) {
          return Container(
            height: 95,
            width: 95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              border: Border.all(
                color: Colors.transparent,
                width: 2,
              ),
            ),
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Glow effect only if this container is selected
                if (controller.isSelected(index)) ...[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          for (var color in controller.shuffledColors)
                            color.withOpacity(controller.animation.value),
                        ],
                        begin: Alignment(
                            -1 + (controller.animation.value * 2.5), -1),
                        end: Alignment(
                            1 - (controller.animation.value * 2.5), 1),
                      ),
                    ),
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ],
                // Main container
                Container(
                  margin: EdgeInsets.all(6),
                  height: 85,
                  width: 85,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // màu đổ bóng
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(0, 0), // hướng đổ bóng
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          countStudent.toString(), // Dòng 1: số
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 4), // Khoảng cách giữa 2 dòng
                      Text(
                        title, // Dòng 2: văn bản
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),

                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
