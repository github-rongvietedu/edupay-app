import 'package:edupay/Homepage/home_page_parent_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class CardStudentInfo extends StatelessWidget {
  CardStudentInfo({
    super.key,
  });
  var controller = Get.put(HomePageParentController());
  final ValueNotifier<bool> isExpand = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    double spaceText = 12;
    return ValueListenableBuilder<bool>(
      valueListenable: isExpand,
      builder: (context, value, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            // AnimatedContainer for smooth transition
            duration: Duration(milliseconds: 300), // Set animation duration
            curve: Curves.easeInOut, // Set animation curve
            width: 310,
            height: value ? 175 : 175 / 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffE0432C), Color(0xffEF5A27)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 40,
                  left: -25,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Color(0xffEA511C),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -25,
                  right: -25,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xffF6662D),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: -25,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xffF6662D),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(1, 4),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 25,
                  right: 15,
                  child: GestureDetector(
                    onTap: () => isExpand.value = !isExpand.value,
                    child: Container(
                      height: 35,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        value ? Icons.expand_less : Icons.expand_more,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mã số ${controller.selectedStudent.value.studentCode}',
                          style: textInter12.whiteColor,
                        ),
                        SizedBox(height: spaceText),
                        Text(
                          '${controller.selectedStudent.value.studentName}',
                          style: textInter16.whiteColor.bold,
                        ),
                        if (value)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(height: spaceText),
                              Text(
                                '${controller.selectedStudent.value.companyName}',
                                style: textInter12.whiteColor,
                              ),
                              SizedBox(height: spaceText),
                              Row(
                                children: [
                                  Text(
                                    '${controller.selectedStudent.value.className}',
                                    style: textInter12.whiteColor,
                                  ),
                                ],
                              ),
                              SizedBox(height: spaceText),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Ngày sinh',
                                    style: textInter12.whiteColor,
                                  ),
                                  Text(
                                    '${DateFormat('dd/MM/yyyy').format(controller.selectedStudent.value.dateOfBirth ?? DateTime(2000, 1, 1))}',
                                    style: textInter12.whiteColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
