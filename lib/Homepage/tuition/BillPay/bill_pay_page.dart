import 'package:edupay/Homepage/tuition/tuition_fee_page_controller.dart';
import 'package:edupay/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../core/base/base_view_view_model.dart';
import '../../Widget/edupay_appbar.dart';
import 'bill_pay_detail.dart';

class BillPayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    "Phụ huynh có thể chon đợt đóng phù hợp",
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
                  buildReceiptWidget(context,
                      title: 'Đóng 01 đợt', price: '34.398.345 đ'),
                  buildReceiptWidget(context,
                      title: 'Đóng 02 đợt', price: '44.398.345 đ'),
                  buildReceiptWidget(context,
                      title: 'Đóng 03 đợt', price: '64.398.345 đ'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReceiptWidget(context, {String? title, String? price}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BillPayDetail(),
          ),
        );
      },
      child: Container(
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 15,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: kOrangeCode.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.calendar_month_sharp,
                      size: 24, color: kOrangeCode),
                ),
              ),
            ),
            Expanded(
              flex: 70,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "",
                      style: textInter12.blackColor,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      price ?? "",
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
