// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import '../constants.dart';
// import '../models/profile.dart';

// class CustomDropdown extends StatefulWidget {
//   const CustomDropdown({Key? key}) : super(key: key);

//   @override
//   State<CustomDropdown> createState() => _CustomDropdownState();
// }

// class _CustomDropdownState extends State<CustomDropdown> {
//   late GlobalKey actionKey;
//   late double height, width, xPosition, yPosition;
//   late OverlayEntry floatingDropdown;

//   final TextStyle _textStyleProfile =
//       const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);
//   bool isDropDown = false;
//   void findDropdownData() {
//     RenderBox renderBox =
//         actionKey.currentContext!.findRenderObject()! as RenderBox;
//     height = renderBox.size.height;
//     width = renderBox.size.width;
//     Offset offset = renderBox.localToGlobal(Offset.zero);
//     xPosition = offset.dx;
//     yPosition = offset.dy;
//     print(height);
//     print(width);
//     print(xPosition);
//     print(yPosition);
//   }

//   OverlayEntry _createFloatingDropdown() {
//     return OverlayEntry(builder: ((context) {
//       return Positioned(
//           left: xPosition,
//           top: yPosition + height,
//           width: width,
//           height: 2 * height,
//           child: Container(color: Colors.red, height: 150));
//     }));
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     actionKey = LabeledGlobalKey("Change Student");
//   }

//   @override
//   Widget build(BuildContext context) {
//     DateFormat formattedDate = DateFormat('dd/MM/yyyy');
//     return GestureDetector(
//         key: actionKey,
//         onTap: () {
//           if (isDropDown) {
//             floatingDropdown.remove();
//           } else {
//             findDropdownData();
//             floatingDropdown = _createFloatingDropdown();
//             Overlay.of(context)!.insert(floatingDropdown);
//           }

//           isDropDown = !isDropDown;
//         },
//         child: Card(
//             shape: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(6),
//                 borderSide: const BorderSide(color: Colors.white)),
//             margin: const EdgeInsets.only(top: 5, bottom: 2),
//             elevation: 2,
//             shadowColor: Colors.black,
//             color: Colors.white,
//             child: Row(children: [
//               Flexible(
//                   flex: 25,
//                   child: SizedBox(
//                       width: double.infinity,
//                       child: Image.asset("images/logo_minhduc.png",
//                           fit: BoxFit.contain))),
//               Flexible(
//                   flex: 75,
//                   child: Container(
//                       padding: const EdgeInsets.all(5),
//                       width: double.infinity,
//                       child: Container(
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                               color: kPrimaryColor,
//                               borderRadius: BorderRadius.circular(8)),
//                           child: Profile.currentStudent != null
//                               ? Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(Profile.currentStudent!.studentName,
//                                           style: _textStyleProfile),
//                                       Text(
//                                           formattedDate.format(Profile
//                                               .currentStudent!.dateOfBirth),
//                                           style: _textStyleProfile),
//                                     ],
//                                   ),
//                                 )
//                               : const SizedBox())))
//             ])));
//   }
// }
