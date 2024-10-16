import 'package:flutter/material.dart';

import '../../Widget/edupay_appbar.dart';
import 'display_qr_widget.dart';

class BillPaymentPage extends StatelessWidget {
  const BillPaymentPage({super.key});

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
              width: size.width,
              // alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrderQRInfo(), SizedBox(height: 16),

                    // Scan QR Instruction
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.qr_code_scanner, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                            "Hãy chụp ảnh màn hình QR và\nmở App ngân hàng để thanh toán",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    // Payment Information Section
                    Container(
                      width: size.width,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPaymentDetailRow(
                              "Tài khoản nhận", "Trường THPT Nghĩa Tân"),
                          SizedBox(height: 8),
                          _buildPaymentDetailRow("Số tài khoản", "48390248239"),
                          SizedBox(height: 8),
                          _buildPaymentDetailRow("Ngân hàng", "HDBank"),
                          SizedBox(height: 8),
                          _buildPaymentDetailRow("Nội dung", "90248239"),
                          SizedBox(height: 8),
                          _buildPaymentDetailRow("Số tiền", "1.600.000 đ",
                              isBold: true, fontSize: 14, color: Colors.black),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    // Bank App Logos and More Button
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     _buildBankIcon('assets/hdbank.png'),
                    //     _buildBankIcon('assets/techcombank.png'),
                    //     _buildBankIcon('assets/vpbank.png'),
                    //     TextButton(
                    //       onPressed: () {},
                    //       child: Text(
                    //         "Xem thêm",
                    //         style: TextStyle(color: Colors.blue),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for displaying payment details
  Widget _buildPaymentDetailRow(String label, String value,
      {bool isBold = false, double fontSize = 16, Color color = Colors.black}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Wrap the text in a Flexible to handle long labels
        Flexible(
          child: Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 8), // Add some space between label and value
        // Wrap value in Flexible to handle long text and avoid overflow
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
            textAlign: TextAlign
                .right, // Align to the right for better visual separation
            overflow: TextOverflow.ellipsis, // Handle overflow by showing '...'
          ),
        ),
      ],
    );
  }

  // Helper method for displaying bank logos
  Widget _buildBankIcon(String assetPath) {
    return Image.asset(
      assetPath,
      width: 40,
      height: 40,
    );
  }
}
