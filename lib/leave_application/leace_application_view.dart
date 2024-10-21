

import 'dart:math';

import 'package:edupay/Homepage/Widget/edupay_appbar.dart';
import 'package:edupay/Homepage/tuition/card_student_info.dart';
import 'package:edupay/config/DataService.dart';
import 'package:edupay/constants.dart';
import 'package:edupay/core/base/base_view_view_model.dart';
import 'package:edupay/leave_application/calendar_shift.dart';
import 'package:edupay/leave_application/create_application_absence_controller.dart';
import 'package:edupay/leave_application/create_application_absence_veiw.dart';
import 'package:edupay/leave_application/leace_application_controller.dart';
import 'package:edupay/models/SchoolLeaveOfAbsence/reason.dart';
import 'package:edupay/models/SchoolLeaveOfAbsence/student_leave_of_absence.dart';
import 'package:edupay/models/profile.dart';
import 'package:edupay/models/secure_store.dart';
import 'package:edupay/widget/gradientBitton.dart';
import 'package:edupay/widget/rounded_button.dart';
import 'package:edupay/widget/rve_popup_choose_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../models/student.dart';

class LeaveApplicationPage extends BaseView<LeavePageController> {
  ValueNotifier<int> selectedStudent =
  ValueNotifier<int>(Profile.selectedStudent);
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  HistoryBillWidget() {
    return
      SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const WaterDropHeader(waterDropColor: Colors.red),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            switch (mode) {
              case LoadStatus.idle:
                body = const Text("Pull up to load");
                break;
              case LoadStatus.loading:
                body = const CupertinoActivityIndicator();
                break;
              case LoadStatus.failed:
                body = const Text("Load Failed! Click to retry!");
                break;
              case LoadStatus.canLoading:
                body = const Text("Release to load more");
                break;
              default:
                body = const Text("No more Data");
                break;
            }
            return SizedBox(
              height: 5.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoadMore,
        child:
        controller.state=='init'?const SizedBox():
        (controller.historyTimeSheet == null )?
        const Center(child: Text('error',style: TextStyle(color: Colors.grey))):
        (controller.historyTimeSheet.length == 0)
            ? const Center(child: Text('Chưa có lịch sử chấm côngr',style: TextStyle(color: Colors.grey))):
        ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: controller.historyTimeSheet?.length ?? 0,
          itemBuilder: (context, index) {
            var shift = controller.historyTimeSheet[index];
            return
              Padding(padding: const EdgeInsets.only(bottom: 10,left: 12,right: 12),child:
              shiftItem(shift));
          },
        ),
      );
  }

  Widget shiftItem(Map<String, dynamic> shift) {
    var status=shift['Status']??'';
    var date;
    try {date= DateFormat('HH:mm dd/MM/yyyy')
        .format(DateTime.parse(shift['StartTime'].toString()));}
    catch (e) {}
    return
      SizedBox(
          height: 66,
          child:
          Container(
            padding: const EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.4)),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [//Text(shift.toString())
                Row(
                  children: [
                    status==''?SizedBox(width: 20,height: 20):
                    Image.asset(
                      status=='OnTime'?
                      'images/icon/icon1.png':
                      status=='Late'?'images/icon/icon2.png':
                      status=='Off'?'images/icon/icon3.png':
                      'images/icon/icon4.png',
                      fit: BoxFit.contain,
                      color:
                      status=='OnTime'?const Color.fromRGBO(11, 161, 88, 1):
                      status=='Late'?const Color.fromRGBO(220, 42, 60,1):
                      status=='Off'?const Color.fromRGBO(51, 65, 85, 1):
                      const Color.fromRGBO(9, 109, 217, 1),
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 12),
                    SizedBox(height: 20,
                        child: Text(
                          shift['ShiftName']??'',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          maxLines: 1,
                        )),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    SizedBox(width: 32, height: 8),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(date??'' ,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ));
  }
  void _onRefresh() async {
    if (controller.historyTimeSheet != null) {
      try {
        controller.historyTimeSheet.clear();
      } catch (e) {}
    }
    controller.currentPage = 0;
    await controller.getListShiftReport();
    _refreshController.refreshCompleted();
  }

  void _onLoadMore() async {
    print('get more');
    await controller.getListShiftReport();
    _refreshController.loadComplete();
  }
  void onCreateAbsencePressed(BuildContext context) async {
    var result = await showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        Get.lazyPut(() =>
            CreateAbsencePageController(student: Profile.currentStudent));
        var modal = CreateAbsencePage();
        return modal;
      },
    );
    if (result ?? false) {

    } else
      print('no action');
  }


  tab()
  {return
    Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () { controller.showType.value='list';
              controller.update();
              },
              child: SizedBox(
                height: 38,
                child: LinearGradientButton(
                  padding: 0,
                  text: 'Dạng thẻ',
                  textColor:controller.showType.value=='list'?Colors.black:Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color1: Colors.transparent,
                  color2: Colors.transparent,
                  borderColor:Colors.grey
                      .withOpacity(0.5),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () {
                controller.showType.value='calendar';
                    controller.update();
              },
              child: SizedBox(
                height: 38,
                child: LinearGradientButton(
                  padding: 0,
                  text: 'Dạng lịch',
                  fontSize: 14,
                  textColor:controller.showType.value=='list'?Colors.grey:Colors.black,
                  fontWeight: FontWeight.bold,
                  color1: Colors.transparent,
                  color2: Colors.transparent,
                  borderColor: Colors.grey
                      .withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  ListTypeView()
  {  DateTime _displayedMonth = DateTime.now();

  return
    Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back,size: 20,color: Color.fromRGBO(100, 116, 139, 1)),
            onPressed:() {},
          ),
          const Expanded(child: SizedBox()),
          Image.asset('images/icon/shift_item_icon.png',
            fit: BoxFit.contain,
            width: 22,
            height: 22,
          ),
          const SizedBox(width: 12),
          Text(
            'Tháng ${DateFormat('MM / yyyy').format(_displayedMonth)}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Expanded(child: SizedBox()),
          IconButton(
            icon: const Icon(Icons.arrow_forward,size: 20,color: Color.fromRGBO(100, 116, 139, 1)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget baseBuilder(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      // Prevent overflow issues when keyboard appears
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kPrimaryColor, Colors.red.shade700],
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: statusBarHeight,
                ),
                const EdupayAppBar(
                  titleWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'EduPay',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Thông tin học sinh nghỉ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded( // Use Expanded to make the container take available space
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: CustomScrollView(
                            slivers: [
                              SliverList(
                                delegate: SliverChildListDelegate([
                                  CardStudentInfo(),
                                ]),
                              ),
                              SliverPersistentHeader(
                                pinned: true, // Sticky header behavior
                                delegate: ShiftCalendarStatus(
                                  child:SizedBox(height: 48,child: tab()), // Sticky tab widget
                                ),
                              ),
                               SliverFillRemaining(
                                hasScrollBody: true,
                                child:
                                controller.showType.value=='list'?
                                HistoryBillWidget():CalendarShiftWidget(controller)
                                )
                            //]),
                         // ),
                      ],
                    ),
                  ),
                ])
              ))],
            ),
            // Bottom Button
            Positioned(
              bottom: 12, // Make the button float at the bottom
              left: 0,
              right: 0,
              child: InkWell(
                onTap: () => onCreateAbsencePressed(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 16),
                  width: size.width,
                  child: LinearGradientButton(
                    fontSize: 16,
                    text: 'Xin nghỉ',
                    textColor: Colors.black,
                    fontWeight: FontWeight.bold,
                    color2: const Color.fromRGBO(251, 192, 0, 1),
                    color1: const Color.fromRGBO(254, 239, 159, 1),
                    margin: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ShiftCalendarStatus extends SliverPersistentHeaderDelegate {
  final Widget child;
  ShiftCalendarStatus({required this.child});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white, // You can customize the background color
      child: child,
    );
  }
  @override
  double get maxExtent => 48.0; // The height when the header is fully expanded
  @override
  double get minExtent => 48.0; // The height when the header is collapsed
  @override
  bool shouldRebuild(ShiftCalendarStatus oldDelegate) {
    return oldDelegate.child != child;
  }
}