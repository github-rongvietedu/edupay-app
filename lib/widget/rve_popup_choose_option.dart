import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/profile.dart';
import '../models/student.dart';
import 'text_with_space.dart';

class RVEPopupChooseOption extends StatefulWidget {
  RVEPopupChooseOption(
      {Key? key,
      required this.label,
      required this.data,
      required this.selected,
      required this.onChange,
      required this.enable,
      required this.currentStudent})
      : super(key: key);
  final String label;
  final Map<int, Student> data;
  final ValueNotifier<int> selected;
  final Student currentStudent;
  bool enable = false;
  final Function(int) onChange;
  @override
  State<RVEPopupChooseOption> createState() => _RVEPopupChooseOptionState();
}

class _RVEPopupChooseOptionState extends State<RVEPopupChooseOption> {
  DateFormat formattedDate = DateFormat('dd/MM/yyyy');
  TextStyle _kTextStyleName = GoogleFonts.robotoCondensed(
      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
  late Student currentStudent;
  @override
  void initState() {
    // TODO: implement initState
    currentStudent = widget.currentStudent;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.selected,
        builder: (context, error, child) {
          return InkWell(
              onTap: () async {
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return Dialog(
                          backgroundColor: Colors.white,
                          insetAnimationDuration:
                              const Duration(milliseconds: 100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          insetPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          // contentPadding: EdgeInsets.all(5),
                          child: ValueListenableBuilder(
                              valueListenable: widget.selected,
                              builder: (context, error, child) {
                                return SingleChildScrollView(
                                    child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.label,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                        children: widget.data.entries
                                            .map((e) => InkWell(
                                                onTap: () async {
                                                  widget.selected.value = e.key;
                                                  currentStudent = e.value;
                                                  widget.onChange(e.key);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  // height: 60,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  margin: const EdgeInsets.only(
                                                      bottom: 10,
                                                      left: 10,
                                                      right: 10),
                                                  decoration: BoxDecoration(
                                                      color: kPrimaryColor
                                                          .withOpacity(0.3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              flex: 85,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    e.value
                                                                        .studentName
                                                                        .toUpperCase(),
                                                                    style:
                                                                        kTextStyleBlackBold,
                                                                  ),
                                                                  Text(
                                                                    formattedDate
                                                                        .format(e
                                                                            .value
                                                                            .dateOfBirth!),
                                                                    style:
                                                                        kTextStyleBlackBold,
                                                                  ),
                                                                ],
                                                              )),
                                                          Expanded(
                                                              flex: 15,
                                                              child: widget
                                                                          .selected
                                                                          .value ==
                                                                      e.key
                                                                  ? const Icon(
                                                                      Icons
                                                                          .check,
                                                                      size: 30,
                                                                      color: Colors
                                                                          .green,
                                                                    )
                                                                  : Container())
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )))
                                            .toList())
                                  ],
                                ));
                              }));
                    });
              },
              child: Card(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.white)),
                  margin: const EdgeInsets.only(top: 5, bottom: 2),
                  elevation: 2,
                  shadowColor: Colors.black,
                  color: Colors.white,
                  child: Row(children: [
                    Flexible(
                        flex: 28,
                        child: Container(
                            padding:
                                const EdgeInsets.only(left: 6, right: 4, bottom: 2),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: CachedNetworkImage(
                                placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                      child: ClipRRect(
                                        child: Image.asset(
                                            "images/img_avatar.png",
                                            fit: BoxFit.contain),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                        width: 50.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.contain))),
                                fit: BoxFit.contain,
                                imageUrl: currentStudent.faceImageURL)
                            // child: CircleAvatar(
                            //     foregroundColor: Colors.red,
                            //     child: ClipRRect(
                            //       child: Image.network(
                            //         Profile.currentStudent.faceImageURL,
                            //         fit: BoxFit.contain,
                            //         errorBuilder: (BuildContext context,
                            //             Object exception,
                            //             StackTrace? stackTrace) {
                            //           return Image.asset("images/img_avatar.png",
                            //               fit: BoxFit.contain);
                            //         },
                            //       ),
                            //       borderRadius: BorderRadius.circular(100),
                            //     )
                            //     // backgroundImage: NetworkImage(
                            //     //   Profile.currentStudent.faceImageURL,
                            //     // ),
                            //     // onBackgroundImageError:
                            //     //       fit: BoxFit.contain);

                            //     ),
                            )
                        //  SizedBox(
                        //     width: double.infinity,
                        //     child: Image.asset("images/img_avatar.png",
                        //         fit: BoxFit.contain))
                        ),
                    Flexible(
                        flex: 72,
                        child: Stack(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(5),
                                width: double.infinity,
                                child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: currentStudent.id != ""
                                        ? Padding(
                                            padding: const EdgeInsets.all(5.0),

                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    currentStudent.studentName
                                                        .toUpperCase(),
                                                    style: _kTextStyleName),
                                                TextWithSpace(
                                                    text1: "Ngày sinh:",
                                                    text2: formattedDate.format(
                                                        currentStudent
                                                            .dateOfBirth!),
                                                    textStyle1:
                                                        kTextStyleProfile,
                                                    textStyle2:
                                                        kTextStyleProfile,
                                                    flex1: 50,
                                                    flex2: 50,
                                                    space: 5),

                                                TextWithSpace(
                                                    text1: "Giới tính:",
                                                    text2: currentStudent
                                                                .gender ==
                                                            0
                                                        ? "Nữ"
                                                        : "Nam",
                                                    textStyle1:
                                                        kTextStyleProfile,
                                                    textStyle2:
                                                        kTextStyleProfile,
                                                    flex1: 50,
                                                    flex2: 50,
                                                    space: 5),
                                                // Profile.currentStudent.gender == 0
                                                //     ? Text("Nữ",
                                                //         style: kTextStyleProfile)
                                                //     : Text("Nam",
                                                //         style: kTextStyleProfile),
                                              ],
                                            ),

                                            // Flexible(
                                            //   flex: 1,
                                            //   child:
                                            //       Profile.listStudent.length >=
                                            //               2
                                            //           ? Icon(
                                            //               Icons.arrow_drop_down,
                                            //               color: Colors.white,
                                            //               size: 34,
                                            //             )
                                            //           : const SizedBox(),
                                            // ),
                                          )
                                        : const SizedBox())),
                            Positioned(
                                right: 0,
                                child: Profile.listStudent.length >= 2
                                    ? const Center(
                                        heightFactor: 3,
                                        child: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white,
                                          size: 34,
                                        ),
                                      )
                                    : const SizedBox())
                          ],
                        ))
                  ])));
        });
  }
}





class RVEPopupChooseOption1 extends StatefulWidget {
  RVEPopupChooseOption1(
      {Key? key,
        required this.label,
        required this.data,
        required this.selected,
        required this.onChange,
        required this.enable,
        required this.currentStudent})
      : super(key: key);
  final String label;
  final Map<int, Student> data;
  final ValueNotifier<int> selected;
  final Student currentStudent;
  bool enable = false;
  final Function(int) onChange;
  @override
  State<RVEPopupChooseOption1> createState() => _RVEPopupChooseOptionState1();
}

class _RVEPopupChooseOptionState1 extends State<RVEPopupChooseOption1> {
  DateFormat formattedDate = DateFormat('dd/MM/yyyy');
  TextStyle _kTextStyleName = GoogleFonts.robotoCondensed(
      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
  late Student currentStudent;
  @override
  void initState() {
    // TODO: implement initState
    currentStudent = widget.currentStudent;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.selected,
        builder: (context, error, child) {
          return InkWell(
              onTap: () async {
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return Dialog(
                          backgroundColor: Colors.white,
                          insetAnimationDuration:
                          const Duration(milliseconds: 100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          insetPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                          // contentPadding: EdgeInsets.all(5),
                          child: ValueListenableBuilder(
                              valueListenable: widget.selected,
                              builder: (context, error, child) {
                                return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              widget.label,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                            children: widget.data.entries
                                                .map((e) => InkWell(
                                                onTap: () async {
                                                  widget.selected.value = e.key;
                                                  currentStudent = e.value;
                                                  widget.onChange(e.key);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  // height: 60,
                                                  padding:
                                                  const EdgeInsets.all(10),
                                                  margin: const EdgeInsets.only(
                                                      bottom: 10,
                                                      left: 10,
                                                      right: 10),
                                                  decoration: BoxDecoration(
                                                      color: kPrimaryColor
                                                          .withOpacity(0.3),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              flex: 85,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text(
                                                                    e.value
                                                                        .studentName
                                                                        .toUpperCase(),
                                                                    style:
                                                                    kTextStyleBlackBold,
                                                                  ),
                                                                  Text(
                                                                    formattedDate
                                                                        .format(e
                                                                        .value
                                                                        .dateOfBirth!),
                                                                    style:
                                                                    kTextStyleBlackBold,
                                                                  ),
                                                                ],
                                                              )),
                                                          Expanded(
                                                              flex: 15,
                                                              child: widget
                                                                  .selected
                                                                  .value ==
                                                                  e.key
                                                                  ? const Icon(
                                                                Icons
                                                                    .check,
                                                                size: 30,
                                                                color: Colors
                                                                    .green,
                                                              )
                                                                  : Container())
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )))
                                                .toList())
                                      ],
                                    ));
                              }));
                    });
              },
              child: Card(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.white)),
                  margin: const EdgeInsets.only(top: 0, bottom: 0),
                  elevation: 2,
                  shadowColor: Colors.black,
                  color: Colors.white,
                  child: Row(children: [
                    // Flexible(
                    //     flex: 28,
                    //     child: Container(
                    //         //padding: EdgeInsets.only(left: 6, right: 4, bottom: 2),
                    //         width: MediaQuery.of(context).size.width,
                    //         height: MediaQuery.of(context).size.height,
                    //         child: CachedNetworkImage(
                    //             placeholder: (context, url) => const Center(
                    //               child: CircularProgressIndicator(),
                    //             ),
                    //             errorWidget: (context, url, error) =>
                    //                 CircleAvatar(
                    //                   child: ClipRRect(
                    //                     borderRadius: BorderRadius.circular(50),
                    //                     child: Image.asset(
                    //                         "images/img_avatar.png",
                    //                         fit: BoxFit.contain),
                    //                   ),
                    //                 ),
                    //             imageBuilder: (context, imageProvider) =>
                    //                 Container(
                    //                     width: 50.0,
                    //                     height: 50.0,
                    //                     decoration: BoxDecoration(
                    //                         shape: BoxShape.circle,
                    //                         image: DecorationImage(
                    //                             image: imageProvider,
                    //                             fit: BoxFit.contain))),
                    //             fit: BoxFit.contain,
                    //             imageUrl: currentStudent.faceImageURL)
                    //           )
                    //
                    // ),
                    // const SizedBox(width: 12),
                    Flexible(
                        flex: 72,
                        child: Stack(
                          children: [
                            SizedBox(
                               // padding: const EdgeInsets.all(5),
                                width: double.infinity,
                                child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Color(0xffED5627),
                                            Color(0xffED5627),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(12)),
                                    child: currentStudent.id != ""
                                        ?
                                    Container(
                                      padding: const EdgeInsets.only(left: 16,right: 16),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Container(alignment: Alignment.centerLeft,child:
                                          Text('Mã số  ${(currentStudent.studentCode??'')
                                                  .toUpperCase()}',
                                             style: const TextStyle(fontSize: 12,color: Colors.white)
                                          )),
                                          SizedBox(height: 2),
                                          Container(alignment: Alignment.centerLeft,child:
                                      Text(
                                          (currentStudent.studentName??"")
                                                  .toUpperCase(),
                                              style:  const TextStyle(fontSize: 16,color: Colors.white,fontWeight:FontWeight.bold))),
                                          SizedBox(height: 2),
                                          Container(alignment: Alignment.centerLeft,child:
                                            Text("Trường ${currentStudent
                                                  .companyName??'Chưa xác định'}",
                                              maxLines: 2,
                                              style:
                                              const TextStyle(fontSize: 12,color: Colors.white),
                                            ),

                                          ),
                                          SizedBox(height: 2),
                                          Container(alignment: Alignment.centerLeft,child:
                                          Row(children: [
                                            const Expanded(child:
                                            Text("Lớp:",
                                              style:
                                              TextStyle(fontSize: 12,color: Colors.white),
                                            )),
                                            Text(
                                              currentStudent
                                                  .className??'Chưa xác định',
                                              style:
                                              const TextStyle(fontSize: 12,color: Colors.white),
                                            ),
                                          ])
                                          ),
                                          SizedBox(height: 2),
                                          Container(alignment: Alignment.centerLeft,child:
                                          Row(children: [
                                            const Expanded(child:
                                            Text(
                                                "Ngày sinh:",
                                                style:  TextStyle(fontSize: 12,color: Colors.white))),
                                            Text(currentStudent.dateOfBirth==null?'Chưa xách định':
                                            formattedDate.format(
                                                currentStudent
                                                    .dateOfBirth!),
                                              style:  const TextStyle(fontSize: 12,color: Colors.white),
                                            )
                                          ]
                                          )),


                                          // Profile.currentStudent.gender == 0
                                          //     ? Text("Nữ",
                                          //         style: kTextStyleProfile)
                                          //     : Text("Nam",
                                          //         style: kTextStyleProfile),
                                        ],
                                      ),
                                    )
                                        : const SizedBox())),
                            Positioned(
                                right: 12,top: 12,
                                child: Profile.listStudent.length >= 2
                                    ?
                                  Container(
                                    padding: const EdgeInsets.only(top: 4,bottom: 4,left: 8,right: 8),
                                    decoration: BoxDecoration(
                                     color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  child:
                                  Transform.rotate(
                                    angle: 90 * (3.141592653589793 / 190), // Convert degrees to radians
                                    child: const Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Colors.redAccent,
                                      size: 15,
                                    ),
                                  )

                                  )
                                    : const SizedBox())
                          ],
                        ))
                  ])));
        });
  }
}
