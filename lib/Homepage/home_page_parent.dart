import 'package:cached_network_image/cached_network_image.dart';
import 'package:edupay/Homepage/PageView/SocialPage/social_page.dart';
import 'package:edupay/Homepage/PageView/dashboard_page.dart';
import 'package:edupay/Homepage/PageView/setting_page.dart';
import 'package:edupay/constants.dart';
import 'package:edupay/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/base/base_view_view_model.dart';
import '../routes/app_pages.dart';
import 'home_page_parent_controller.dart';

class HomePageParent extends BaseView<HomePageParentController> {
  @override
  Widget baseBuilder(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.changeTabIndex(index);
        },
        children: [
          SocialListView(),
          DashboardPage(),
          SizedBox(),
          SettingScreen()
        ],
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: kPrimaryColor,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeTabIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Trang chủ'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle), label: 'Tiện ích'),
              BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Hộp thư'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Cài đặt'),
            ],
          )),
    );
  }

  void _showStudentSelection(BuildContext context) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.listStudent.length,
          itemBuilder: (context, index) {
            final student = controller.listStudent.values
                .elementAt(index); // Lấy giá trị từ Map

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(student.faceImageURL),
              ),
              title: Text(student.studentName),
              subtitle:
                  Text('${student.className} | ${student.schoolYearName}'),
              onTap: () {
                // Cập nhật học sinh đã chọn khi nhấn
                controller.selectStudent(student);
                Get.back(); // Đóng bottom sheet
              },
            );
          },
        ),
      ),
      isScrollControlled: true,
    );
  }
}
