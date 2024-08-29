// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:edupay/constants.dart';
// import 'package:edupay/widget/text_with_dot.dart';
// import 'package:edupay/widget/text_with_space.dart';

// class TuitionFeeScreen extends StatefulWidget {
//   const TuitionFeeScreen({Key? key, this.scrollController}) : super(key: key);
//   final scrollController;
//   @override
//   State<TuitionFeeScreen> createState() => _ClassInfoState();
// }

// class _ClassInfoState extends State<TuitionFeeScreen> {
//   late ScrollController _scrollController;
//   final TextStyle _textStyle =
//       GoogleFonts.ptSansNarrow(fontSize: 18, fontWeight: FontWeight.w500);

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _scrollController = widget.scrollController;
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Stack(
//       children: [
//         Container(
//             width: double.infinity,
//             height: size.height * 0.62,
//             color: kPrimaryColor),
//         SingleChildScrollView(
//           // physics: const BouncingScrollPhysics(),
//           controller: _scrollController,
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               minHeight: size.height * 0.70,
//               minWidth: size.width,
//               maxHeight: double.infinity,
//             ),
//             child: Container(
//                 height: size.height * 0.73,
//                 margin: const EdgeInsets.only(
//                   left: 8,
//                   right: 8,
//                   top: 1,
//                 ),
//                 // height: size.height * 0.73,
//                 decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           // Icon(Icons.person, size: 30, color: Colors.grey[500]),
//                           const SizedBox(
//                             width: 8,
//                           ),
//                           Text("Niên khoá:", style: kTextStyleTitle),
//                           const SizedBox(
//                             width: 8,
//                           ),
//                           // Container(
//                           //   margin: EdgeInsets.only(top: 3),
//                           //   decoration: BoxDecoration(
//                           //       color: Colors.white,
//                           //       border: Border.all(color: Colors.blue),
//                           //       borderRadius: BorderRadius.circular(3)),
//                           //   width: size.width * 0.4,
//                           //   child: Center(
//                           //       child:
//                           //           Text("2022-2023", style: kTextStyleTable)),
//                           //   height: 26,
//                           // )

//                           // const Spacer(),
//                           // Icon(Icons.arrow_drop_down,
//                           //     size: 40, color: Colors.grey[500]),
//                         ],
//                       ),
//                       Card(
//                         color: Colors.white,
//                         elevation: 2,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(14.0),
//                         ),
//                         child: ConstrainedBox(
//                           constraints: BoxConstraints(
//                             minHeight: 120,
//                             minWidth: size.width,
//                             maxHeight: double.infinity,
//                           ),
//                           child: Container(
//                               padding: const EdgeInsets.only(
//                                   left: 12, top: 8, bottom: 8, right: 12),
//                               child: Column(
//                                 // mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   TextWithDot(
//                                       text: "Học phí tháng 09/2022",
//                                       style: kTextStyleTable),
//                                   const TextWithSpace(
//                                       text1: "Tổng:",
//                                       text2: "4.000.000 VNĐ",
//                                       style: TextStyle(
//                                           color: Colors.blueAccent,
//                                           fontSize: 20),
//                                       space: 5),
//                                   const TextWithSpace(
//                                       text1: "Đã thanh toán:",
//                                       text2: "2.000.000 VNĐ",
//                                       style: TextStyle(
//                                           color: Colors.green, fontSize: 20),
//                                       space: 5),
//                                   const TextWithSpace(
//                                       text1: "Còn lại:",
//                                       text2: "2.000.000 VNĐ",
//                                       style: TextStyle(
//                                           color: Colors.redAccent,
//                                           fontSize: 20),
//                                       space: 5),
//                                 ],
//                               )),
//                         ),
//                       )
//                     ])
//                 // Stack(
//                 //   children: [],
//                 // )
//                 ),
//           ),
//         ),
//       ],
//     );
//   }
// }
