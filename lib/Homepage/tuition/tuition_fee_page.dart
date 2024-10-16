import 'package:edupay/Homepage/tuition/BillPay/bill_pay_page.dart';
import 'package:edupay/Homepage/tuition/tuition_fee_page_controller.dart';
import 'package:edupay/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../core/base/base_view_view_model.dart';
import '../Widget/edupay_appbar.dart';
import 'card_student_info.dart';

class TuitionFeePage extends BaseView<TuitionFeePageController> {
  @override
  Widget baseBuilder(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Text(
      //     'EduPay',
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontSize: 24,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffED5627), Colors.red.shade700],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: statusBarHeight,
            ),
            EdupayAppBar(
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
                    'Danh sách học phí tới đợt cần đóng',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: size.height * 0.82,
              // alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardStudentInfo(),
                  SizedBox(
                    height: 16,
                  ),
                  buildReceiptWidget(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReceiptWidget(context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BillPayPage()),
        );
      },
      child: Container(
        height: 65,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 15,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 236, 242, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.calendar_month_sharp,
                      size: 24, color: kDarkBlueColor),
                ),
              ),
            ),
            Expanded(
              flex: 70,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5, color: kDarkBlueColor),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Đang đóng',
                          style: textInter10.darkBlueColor.bold,
                        ),
                      ],
                    ),
                    Text(
                      'Phiếu thu kỳ 02-2022',
                      style: textInter12.blackColor,
                    ),
                    Text(
                      '44.398.345 đ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 15,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 236, 242, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.arrow_forward,
                    size: 24, color: kBackgroundBorder),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
