import 'package:edupay/Homepage/tuition/BillPay/bill_payment_page.dart';
import 'package:edupay/Homepage/tuition/tuition_fee_page_controller.dart';
import 'package:edupay/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../core/base/base_view_view_model.dart';
import '../../Widget/edupay_appbar.dart';

class BillPayDetail extends StatelessWidget {
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
                    "Phụ huynh hãy chọn đợt đóng",
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
                  buildTotalBillDisplay(
                      title: 'Tổng số tiền cần đóng',
                      price: '0đ / 34.398.345 đ'),
                  buildDetailBill(context),
                  buildDetailBill(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildTotalBillDisplay({String? title, String? price}) {
    double totalAmount = 44398345;
    double paidAmount = 14398345;

    // Tính toán phần trăm tiến độ
    double progressPercentage = paidAmount / totalAmount;
    return Container(
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
            flex: 85,
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
                  Row(
                    children: [
                      Text(
                        '14.398.345 đ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' / 44.398.345 đ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 90,
                        child: LinearProgressIndicator(
                          value: progressPercentage,
                          borderRadius: BorderRadius.circular(10),
                          minHeight: 7,
                          backgroundColor: Colors.grey[300],
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('${(progressPercentage * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailBill(context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BillPaymentPage(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 8),
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 85,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5, color: kOrangeCode),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Chưa đóng',
                          style: textInter10.bold.copyWith(color: kOrangeCode),
                        ),
                      ],
                    ),
                    Text(
                      'Đợt 1 (22/11/2023 - 23/11/2023)',
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
