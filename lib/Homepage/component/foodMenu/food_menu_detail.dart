import 'package:edupay/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/foodmenu/foodmenu.dart';

class FoodMenuDetailView extends StatefulWidget {
  final List<FoodMenuDetail> menuDetails;

  FoodMenuDetailView({required this.menuDetails});

  @override
  _FoodMenuDetailViewState createState() => _FoodMenuDetailViewState();
}

class _FoodMenuDetailViewState extends State<FoodMenuDetailView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late List<FoodMenuDetail> sortedDetails;
  int initialTabIndex = 0;

  @override
  void initState() {
    super.initState();
    sortedDetails = _sortMenuDetailsByDay(widget.menuDetails);
    initialTabIndex = _getInitialTabIndex(sortedDetails);
    _tabController = TabController(
        length: sortedDetails.length,
        vsync: this,
        initialIndex: initialTabIndex);
  }

  List<FoodMenuDetail> _sortMenuDetailsByDay(List<FoodMenuDetail> details) {
    return details..sort((a, b) => a.dayOfWeek!.compareTo(b.dayOfWeek!));
  }

  int _getInitialTabIndex(List<FoodMenuDetail> details) {
    DateTime currentDate = DateTime.now();
    for (int i = 0; i < details.length; i++) {
      if (details[i].dayOfWeek?.day == currentDate.day) {
        return i;
      }
    }
    return 0; // Mặc định hiển thị tab đầu tiên nếu không trùng ngày
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        TabBar(
          unselectedLabelColor: Colors.black.withOpacity(0.5),
          indicatorColor: kPrimaryColor,
          labelColor: kPrimaryColor,
          tabAlignment: TabAlignment.start,
          padding: EdgeInsets.zero,
          controller: _tabController,
          isScrollable: true,
          tabs: sortedDetails.map((detail) {
            return Tab(text: "${_getDayOfWeekString(detail.dayOfWeek)}");
          }).toList(),
        ),
        Expanded(
          child: sortedDetails.length == 0
              ? Center(
                  child: Container(
                      height: 100,
                      width: size.width,
                      child: Center(
                        child:
                            Text('Chưa có thực đơn ', style: kTextStyleRowBlue),
                      )),
                )
              : TabBarView(
                  controller: _tabController,
                  children: sortedDetails.map((detail) {
                    return _buildMenuDetailPage(detail);
                  }).toList(),
                ),
        ),
      ],
    );
  }

  String _getDayOfWeekString(DateTime? dateTime) {
    if (dateTime == null) return "N/A";
    switch (dateTime.weekday) {
      case DateTime.monday:
        return "Thứ Hai";
      case DateTime.tuesday:
        return "Thứ Ba";
      case DateTime.wednesday:
        return "Thứ Tư";
      case DateTime.thursday:
        return "Thứ Năm";
      case DateTime.friday:
        return "Thứ Sáu";
      case DateTime.saturday:
        return "Thứ Bảy";
      case DateTime.sunday:
        return "Chủ nhật";
      default:
        return "Thứ 0";
    }
  }

  Widget _buildMenuDetailPage(FoodMenuDetail detail) {
    return PageView(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Thực đơn ngày ${_formatDate(detail.dayOfWeek)}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Table(
                  border: const TableBorder(
                    horizontalInside: BorderSide(
                      color: kPrimaryColor,
                      width: 0.5,
                    ),
                    verticalInside: BorderSide(
                      color: kPrimaryColor,
                      width: 0.5,
                    ), // Remove vertical borders inside the table
                    top: BorderSide(
                      color: kPrimaryColor,
                      width: 0.5,
                    ),
                    bottom: BorderSide(
                      color: kPrimaryColor,
                      width: 0.5,
                    ),
                    left: BorderSide.none, // Remove left border
                    right: BorderSide.none, // Remove right border
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(0.45),
                    1: FlexColumnWidth(),
                  },
                  children: [
                    _buildTableRow(
                        "Bữa sáng", detail.morningTime, Color(0xFFFF7F3F)),
                    _buildTableRow(
                        "Bữa trưa", detail.noontime, Color(0xFFFF7777)),
                    _buildTableRow(
                        "Bữa chiều", detail.afterNoonTime, Color(0xFFAAC4FF)),
                    _buildTableRow("Bữa phụ", detail.otherTime,
                        Color.fromARGB(255, 10, 209, 245)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TableRow _buildTableRow(
      String mealTime, dynamic timeDetail, Color textColor) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            mealTime,
            style: GoogleFonts.robotoCondensed(
                fontSize: 16, color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            timeDetail ?? "Không có",
            style: GoogleFonts.robotoCondensed(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.7)),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime? dateTime) {
    if (dateTime == null) return "00/00/0000";
    return "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}";
  }
}
