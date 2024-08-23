import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/schoolYear/school_year.dart';

class RVEPopupChooseOptionDefault extends StatefulWidget {
  RVEPopupChooseOptionDefault(
      {Key? key,
      required this.label,
      required this.data,
      required this.selected,
      required this.onChange,
      required this.enable,
      required this.child})
      : super(key: key);
  final String label;
  final Map<int, dynamic> data;
  final ValueNotifier<int> selected;
  bool enable = false;
  final Function(int) onChange;
  final Widget child;
  @override
  State<RVEPopupChooseOptionDefault> createState() =>
      _RVEPopupChooseOptionDefaultState();
}

class _RVEPopupChooseOptionDefaultState
    extends State<RVEPopupChooseOptionDefault> {
  // DateFormat formattedDate = DateFormat('dd/MM/yyyy');

  TextStyle _kTextStyleBlackBold = GoogleFonts.robotoCondensed(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
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
                                                  height: 50,
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
                                                                    e.value.name ??
                                                                        "",
                                                                    style:
                                                                        _kTextStyleBlackBold,
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
              child: widget.child);
        });
  }
}
