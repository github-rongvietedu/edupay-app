import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:edupay/constants.dart';
import 'package:edupay/models/profile.dart';
import 'package:edupay/models/student.dart';
import 'package:edupay/widget/text_with_space.dart';

class RVEPopupChooseOption extends StatefulWidget {
  RVEPopupChooseOption(
      {Key? key,
      required this.label,
      required this.data,
      required this.selected,
      required this.onChange,
      required this.enable})
      : super(key: key);
  final String label;
  final Map<int, Student> data;
  final ValueNotifier<int> selected;
  bool enable = false;
  final Function(int) onChange;
  @override
  State<RVEPopupChooseOption> createState() => _RVEPopupChooseOptionState();
}

class _RVEPopupChooseOptionState extends State<RVEPopupChooseOption> {
  DateFormat formattedDate = DateFormat('dd/MM/yyyy');
  TextStyle _kTextStyleName = GoogleFonts.robotoCondensed(
      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
  @override
  void initState() {
    // TODO: implement initState

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
                                                  widget.onChange(e.key);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  height: 60,
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
                                                                            .dateOfBirth),
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
                              EdgeInsets.only(left: 6, right: 4, bottom: 2),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: CircleAvatar(
                              foregroundColor: Colors.red,
                              child: ClipRRect(
                                child: Image.asset("images/img_avatar.png",
                                    fit: BoxFit.contain),
                                borderRadius: BorderRadius.circular(50),
                              )),
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
                                    child: Profile.currentStudent.id != ""
                                        ? Padding(
                                            padding: const EdgeInsets.all(5.0),

                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    Profile.currentStudent
                                                        .studentName
                                                        .toUpperCase(),
                                                    style: _kTextStyleName),
                                                TextWithSpace(
                                                    text1: "Ngày sinh:",
                                                    text2: formattedDate.format(
                                                        Profile.currentStudent
                                                            .dateOfBirth),
                                                    textStyle1:
                                                        kTextStyleProfile,
                                                    textStyle2:
                                                        kTextStyleProfile,
                                                    flex1: 50,
                                                    flex2: 50,
                                                    space: 5),

                                                TextWithSpace(
                                                    text1: "Giới tính:",
                                                    text2: Profile
                                                                .currentStudent
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
                                    ? Center(
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
