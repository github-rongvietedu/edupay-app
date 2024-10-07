import 'package:edupay/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../config/DataService.dart';
import '../../../constants.dart';
import '../../../models/foodmenu/foodmenu.dart';
import '../../../models/foodmenu/foodmenu_detail.dart';
import '../../../models/foodmenu/foodmenu_result.dart';
import '../../../widget/text_with_space.dart';
import 'dart:math' as math;

import 'food_menu_detail.dart';

class MenuWeek extends StatefulWidget {
  const MenuWeek({Key? key, this.scrollController}) : super(key: key);
  final scrollController;
  @override
  _MenuWeekState createState() => _MenuWeekState();
}

class _MenuWeekState extends State<MenuWeek> with TickerProviderStateMixin {
  ValueNotifier<String> stateNotifier = ValueNotifier<String>("loading");

  Map<int, String> dayOfWeek = {
    1: "THỨ HAI",
    2: "THỨ BA",
    3: "THỨ TƯ",
    4: "THỨ NĂM",
    5: "THỨ SÁU",
    6: "THỨ BẢY"
  };
  Map<int, String> session = {0: "Buổi sáng", 1: "Buổi trưa", 2: "Buổi chiều"};
  Map<int, Color> color = {
    0: Color(0xFFFF7F3F),
    1: Color(0xFFFF7777),
    2: Color(0xFFAAC4FF)
  };
  List<String> _columnNames = ["Buổi", "", "Món ăn"];
  int selectedIndex = 0;

  int currentDateOfWeek = DateTime.now().weekday;

  DateTime currentDate = DateTime.now();

  late TabController tabController;
  late ScrollController _scrollController;

  List<FoodMenu> listFoodMenu = [];

  getMenuDayOfWeek() async {
    stateNotifier.value = "loading"; // Hiển thị trạng thái loading
    try {
      // Gọi API lấy dữ liệu
      var respone = await DataService()
          .getAllMenu(CompanyCode: Profile.currentClassRoom.companyCode);
      if (respone["status"] == 2) {
        listFoodMenu = (respone['data'] as List)
            .map((item) => FoodMenu.fromJson(item))
            .toList();
        stateNotifier.value = "success";
      }
      if (listFoodMenu.isEmpty) {
        stateNotifier.value = "empty"; // Nếu danh sách trống
      } else {
        // Cập nhật danh sách menu và trạng thái thành công
        stateNotifier.value = "success";
      }
    } catch (e) {
      stateNotifier.value = "failed"; // Nếu có lỗi xảy ra
    }

    // return temp;
  }

  @override
  void initState() {
    getMenuDayOfWeek();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: kPrimaryColor,
          title: Text("Thực đơn tuần"),
          centerTitle: true),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     // Icon(Icons.person, size: 30, color: Colors.grey[500]),
            //     const SizedBox(
            //       width: 8,
            //     ),
            //     Text("Thực đơn:", style: kTextStyleTitle),
            //     const SizedBox(
            //       width: 8,
            //     ),
            //   ],
            // ),
            Expanded(
              child: ValueListenableBuilder<String>(
                valueListenable: stateNotifier,
                builder: (context, state, _) {
                  if (state == "loading") {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == "empty") {
                    return Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: Center(
                        child: Container(
                            height: 100,
                            width: size.width,
                            child: Center(
                              child: Text('Chưa có thực đơn',
                                  style: kTextStyleRowBlue),
                            )),
                      ),
                    );
                  } else if (state == "failed") {
                    return Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: Center(
                        child: Container(
                            height: 100,
                            width: size.width,
                            child: Center(
                              child: Text('Chưa có thực đơn',
                                  style: kTextStyleRowBlue),
                            )),
                      ),
                    );
                  } else {
                    // return SizedBox();
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: listFoodMenu.length,
                      itemBuilder: (context, index) {
                        FoodMenu menu = listFoodMenu[index];
                        return Container(
                          margin: EdgeInsets.only(
                              left: 12, right: 12, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(60, 64, 67, 0.3),
                                  spreadRadius: 0,
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                                BoxShadow(
                                  color: Color.fromRGBO(60, 64, 67, 0.15),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                )
                              ]),
                          child: Theme(
                            data: ThemeData()
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.all(8),
                              childrenPadding: EdgeInsets.zero,
                              title: Text("${menu.menuName}" ?? "",
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: kPrimaryColor)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Áp dụng từ ${DateFormat('dd/MM/yyyy').format(menu.fromDate ?? DateTime.now())} - ${DateFormat('dd/MM/yyyy').format(menu.toDate ?? DateTime.now())}"),
                                  menu.menuDescription != ""
                                      ? Text("Ghi chú: ${menu.menuDescription}")
                                      : SizedBox()
                                ],
                              ),
                              children: [
                                Container(
                                    height: size.height * 0.4,
                                    width: size.width,
                                    child: FoodMenuDetailView(
                                        menuDetails:
                                            menu.foodMenuDetail ?? [])),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
