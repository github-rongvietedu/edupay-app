import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../widget/icon_with_text_widget.dart';
import '../home_page_parent_controller.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});
  var controller = Get.find<HomePageParentController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          bottom: PreferredSize(
              preferredSize: Size(size.width, 60),
              child: Obx(
                () => studentDisplayWidget(context),
              )),
          // title: Text('Danh sách tiện ích',
          //     style: TextStyle(color: Colors.white, fontSize: 16)),
          // centerTitle: false,
          // backgroundColor: kPrimaryColor,
          leading: SizedBox()),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              IconWithTextWidget(
                  size: size,
                  margin: const EdgeInsets.only(bottom: 10),
                  image: "images/svg/icon-category-2.svg",
                  text: Text(
                    'Tiện ích học đường',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
              controller.items.length == 0
                  ? SizedBox()
                  : Container(
                      child: GridView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics:
                            NeverScrollableScrollPhysics(), // To ensure the GridView does not scroll independently
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Number of columns
                          // crossAxisSpacing: 4.0, // Space between columns
                          childAspectRatio:
                              1.2, // change this value for different results

                          // mainAxisSpacing: 4.0, // Space between rows
                        ),
                        itemCount: controller.items.length,
                        // Display only 6 items if not expanded
                        itemBuilder: (context, index) {
                          final item = controller.items[index];
                          return itemDashboard(
                            size: size,
                            item: item,
                            onTap: () {},
                          );
                        },
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget itemDashboard({required size, item, void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.width * 0.25,
        width: size.width * 0.3,
        child: Card(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              item['icon'] != ''
                  ? Image.asset(
                      item['icon'],
                      height:
                          size.width * 0.13, // Ensure the height is a double
                      width: size.width * 0.13, // Ensure the width is a double
                    )
                  : SizedBox(),
              SizedBox(height: 5),
              Text(
                item['title'],
                style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget studentDisplayWidget(context) {
    return GestureDetector(
      onTap: () => _showStudentSelection(context),
      child: ClipPath(
        clipper: BottomLeftInBottomRightOutClipper(),
        child: Container(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
          // margin: const EdgeInsets.all(8),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                kPrimaryColor,
                kPrimaryColor.withOpacity(0.8)
              ], // Replace with your desired colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            // border: Border.all(color: Colors.grey),
            // borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Hình đại diện học sinh
              Expanded(
                flex: 20,
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.white, width: 2.0), // White border
                  ),
                  child: CachedNetworkImage(
                      width: 100.0,
                      height: 100.0,
                      placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                      errorWidget: (context, url, error) => CircleAvatar(
                            child: ClipRRect(
                              child: Image.asset("images/img_avatar.png",
                                  fit: BoxFit.contain),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                      imageBuilder: (context, imageProvider) => Container(
                          // width: 100.0,
                          // height: 100.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.contain))),
                      fit: BoxFit.contain,
                      imageUrl: controller.selectedStudent.value.faceImageURL),
                ),
              ),
              const SizedBox(width: 10),
              // Tên học sinh, lớp và trường
              Expanded(
                flex: 80,
                child: Container(
                  // height: 100,
                  padding: EdgeInsets.zero,
                  width: double.infinity,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.selectedStudent.value.studentName,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        '${controller.selectedStudent.value.companyName ?? ""}',
                        style: const TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        '${controller.selectedStudent.value.className} | ${controller.selectedStudent.value.schoolYearName}',
                        style: const TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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

class BottomLeftInBottomRightOutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double radius = 25.0;

    double rightEdgeAdjustment = 15.0; // Trừ đi 15 đơn vị chiều rộng bên phải

    // Bắt đầu từ góc trên bên trái
    path.moveTo(0, 0);

    // Vẽ cạnh trên
    path.lineTo(size.width, 0);

    // Cạnh phải thẳng xuống nhưng trừ đi 15 đơn vị từ cạnh dưới
    path.lineTo(size.width, size.height);
    path.arcToPoint(
      Offset(size.width - radius, size.height - rightEdgeAdjustment),
      radius: Radius.circular(radius),
      clockwise: false, // Cong ra ngoài
    );

    path.lineTo(radius, size.height - rightEdgeAdjustment);
    path.arcToPoint(
      Offset(0, size.height - rightEdgeAdjustment - radius),
      radius: Radius.circular(radius),
      clockwise: true, // Cong vào trong
    );

    // // Cạnh trái thẳng
    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
