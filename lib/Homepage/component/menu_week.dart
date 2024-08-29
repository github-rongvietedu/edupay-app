import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../config/DataService.dart';
import '../../constants.dart';
import '../../models/foodmenu/foodmenu.dart';
import '../../models/foodmenu/foodmenu_detail.dart';
import '../../models/foodmenu/foodmenu_result.dart';
import '../../widget/text_with_space.dart';
import 'dart:math' as math;

class MenuWeek extends StatefulWidget {
  const MenuWeek({Key? key, this.scrollController}) : super(key: key);
  final scrollController;
  @override
  _MenuWeekState createState() => _MenuWeekState();
}

class _MenuWeekState extends State<MenuWeek> with TickerProviderStateMixin {
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
  late Future<FoodMenu> currentMenu;
  late Future<FoodMenuResult> foodMenuResult;
  late List<MenuFoodDetail> lstFoodDetail = [];
  final TextStyle _textStyleProfile =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  final TextStyle _textStyleTable = const TextStyle(
    fontSize: 16,
  );

  Future<FoodMenu> getMenuDayOfWeek(int currentDateOfWeek) async {
    FoodMenuResult listMenu = FoodMenuResult();
    await DataService().getAllMenu().then((value) => listMenu = value);
    FoodMenu temp = listMenu.data!
        .where((element) => element.menuName
            .toUpperCase()
            .contains(dayOfWeek[currentDateOfWeek] ?? "THỨ HAI"))
        .first;

    return temp;
  }

  void refreshMenu() {
    // reload
    setState(() {
      currentMenu = getMenuDayOfWeek(
        currentDateOfWeek,
      );
    });
  }

  @override
  void initState() {
    super.initState();

    if (currentDateOfWeek == 7) {
      currentDateOfWeek = currentDateOfWeek - 1;
      currentDate = currentDate.subtract(const Duration(days: 1));
    }
    _scrollController = widget.scrollController;

    tabController = TabController(
        initialIndex: currentDateOfWeek - 1,
        length: dayOfWeek.length,
        vsync: this);
    tabController.addListener(() {
      selectedIndex = tabController.index;
      int dateChange = currentDateOfWeek - (selectedIndex + 1);
      if (dateChange > 0) {
        currentDate = currentDate.subtract(Duration(days: dateChange));
      } else if (dateChange < 0) {
        currentDate = currentDate.add(Duration(days: dateChange.abs()));
      }
      currentDateOfWeek = selectedIndex + 1;
      refreshMenu();
    });

    currentMenu = getMenuDayOfWeek(currentDateOfWeek);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<FoodMenu>(
        future: currentMenu,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            lstFoodDetail = snapshot.data?.menuFoodDetail ?? [];
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: size.height * 0.70,
                  // color: kPrimaryColor
                ),
                SingleChildScrollView(
                  // physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: size.height * 0.7,
                      minWidth: size.width,
                      maxHeight: double.infinity,
                    ),
                    child: Container(
                        // height: size.height * 0.73,
                        margin: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          top: 1,
                        ),
                        // height: size.height * 0.73,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: size.height * 0.065,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8)),
                                child: PreferredSize(
                                    preferredSize: const Size.fromHeight(30.0),
                                    child: Center(
                                      child: TabBar(
                                          isScrollable: true,
                                          unselectedLabelColor:
                                              Colors.blue.withOpacity(0.3),
                                          indicatorColor: Colors.blue,
                                          labelColor: Colors.blue,
                                          controller: tabController,
                                          tabs: dayOfWeek.values
                                              .map(
                                                (e) => Tab(
                                                  child: Text(
                                                    e,
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              )
                                              .toList()),
                                    )),
                              ),
                              Flexible(
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(14.0),
                                      ),
                                      color: Colors.white,
                                      elevation: 2,
                                      // child: ConstrainedBox(
                                      //     constraints: BoxConstraints(
                                      //       minHeight: size.height * 0.3,
                                      //       minWidth: size.width,
                                      //       // maxHeight: double.infinity,
                                      //     ),
                                      child: Container(
                                          height: size.height * 0.4,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(14)),
                                          padding: const EdgeInsets.only(
                                              left: 12,
                                              top: 8,
                                              bottom: 8,
                                              right: 12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Center(
                                                  child: Text(
                                                      "Thực đơn ngày: ${DateFormat("dd-MM-yyyy").format(currentDate)}",
                                                      style:
                                                          kTextStyleTitleColor),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 9,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          lstFoodDetail.length,
                                                      itemBuilder:
                                                          ((context, index) {
                                                        return Container(
                                                          // height: size.height *
                                                          //     0.09,
                                                          decoration:
                                                              const BoxDecoration(
                                                                  border:
                                                                      Border(
                                                            top: BorderSide(
                                                                width: 0.5,
                                                                color: Colors
                                                                    .black38),
                                                          )),
                                                          child: Row(children: [
                                                            Flexible(
                                                              flex: 3,
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            8),
                                                                width:
                                                                    size.width,
                                                                child: Text(
                                                                    "${session[lstFoodDetail[index].menuSession]}",
                                                                    style: GoogleFonts.robotoCondensed(
                                                                        fontSize:
                                                                            18,
                                                                        color: color[lstFoodDetail[index]
                                                                            .menuSession],
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ),
                                                            ),
                                                            Flexible(
                                                              flex: 7,
                                                              child: Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8),
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                          border:
                                                                              Border(
                                                                    left: BorderSide(
                                                                        width:
                                                                            0.5,
                                                                        color: Colors
                                                                            .black38),
                                                                  )),
                                                                  width: size
                                                                      .width,
                                                                  child: Text(
                                                                      "${lstFoodDetail[index].menuDescription}",
                                                                      style:
                                                                          kTextStyleBold)),
                                                            )
                                                          ]),
                                                        );
                                                      })),
                                                ),
                                              )
                                            ],
                                          ))
                                      // ),
                                      )),
                            ])),
                  ),
                ),
              ],
            );
          }
          return const Center(
              child: SizedBox(child: CircularProgressIndicator()));
        });
  }

  Widget buildTableMenu(List<MenuFoodDetail> listOfData) {
    List<DataRow> rows = [];
    Widget _verticalDivider = const VerticalDivider(
      color: Colors.black38,
      thickness: 1 / 2,
    );

    listOfData.forEach((stat) {
      rows.add(DataRow(cells: [
        DataCell(Container(
            color: Colors.red,
            width: (MediaQuery.of(context).size.width / 10) * 2,
            child: Text("${session[stat.menuSession]}",
                style: GoogleFonts.robotoCondensed(
                    fontSize: 18,
                    color: color[stat.menuSession],
                    fontWeight: FontWeight.bold)))),
        DataCell(Container(
            width: (MediaQuery.of(context).size.width / 10) * 0.1,
            child: _verticalDivider)),
        DataCell(Container(
            color: Colors.red,
            width: (MediaQuery.of(context).size.width / 10) * 5,
            child: Text("${stat.menuDescription}", style: kTextStyleBold))),
      ]));
    });

    return DataTable(
      // horizontalMargin: 0,
      // columnSpacing: 6 ,
      // sortColumnIndex: 1,
      columnSpacing: 0,
      dataRowHeight: 80,
      columns: _columnNames.map((columnName) {
        return DataColumn(
          label: Center(
            widthFactor: 1.4,
            child: Text(
              "",
              textAlign: TextAlign.center,
              style: kTextStyleRowBlue,
            ),
          ),
        );
      }).toList(),
      rows: rows,
    );
  }

  Row _textWithDot(String text) {
    return Row(
      children: [
        const SizedBox(width: 30),
        const Icon(Entypo.dot_single),
        Text(text, style: _textStyleTable)
      ],
    );
  }

  Row _textWithIcon(IconData icon, Color colorIcon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(icon, color: colorIcon),
        const SizedBox(width: 6),
        Text(text, style: _textStyleProfile)
      ],
    );
  }
}

//
