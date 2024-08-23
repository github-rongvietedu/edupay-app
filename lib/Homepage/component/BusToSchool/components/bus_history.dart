import 'package:flutter/material.dart';

import '../../../../constants.dart';

class BusHistory extends StatefulWidget {
  const BusHistory({Key? key}) : super(key: key);

  @override
  State<BusHistory> createState() => _BusHistoryState();
}

class _BusHistoryState extends State<BusHistory> with TickerProviderStateMixin {
  late TabController _tabController;
  List<Widget> tabs = [
    Tab(
      text: 'Tất cả',
    ),
    Tab(text: "Thành công"),
    Tab(
      text: 'Sự cố',
    ),
  ];
  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:

          // filterData('all');
          break;
        case 1:
          // filterData('experienceConsulting');
          break;
        case 2:
          // filterData('frontOfficeTransformation');
          break;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _tabController = TabController(
      length: tabs.length,
      initialIndex: 0,
      vsync: this,
    );

    // Here is the addListener!
    _tabController.addListener(_handleTabSelection);
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          // actions: [Icon(Icons.filter_alt)],
          title: Text("Lịch sử chuyến đi"),
          elevation: 0,
          backgroundColor: kPrimaryColor,
        ),
        body: Column(children: [
          TabBar(
            padding: EdgeInsets.only(top: 8, left: 8, right: 8),
            tabs: tabs,
            // indicator: BoxDecoration(
            //     color: Colors.green,
            //     border: Border.symmetric(
            //       vertical: BorderSide(color: Colors.grey.shade300),
            //     )),
            // indicatorSize: TabBarIndicatorSize.label,
            controller: _tabController,
            indicatorColor: Colors.transparent,
            labelColor: Colors.blue,
            isScrollable: true,
            unselectedLabelColor: Colors.grey,
            splashBorderRadius: BorderRadius.circular(8),
          ),
          Flexible(
              child: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(8)),
                height: size.height * 0.3,
                width: size.width,
              )
            ],
          ))
        ]));
  }
}
