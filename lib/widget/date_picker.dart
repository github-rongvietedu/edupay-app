import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({Key? key, required this.date, required this.onTap})
      : super(key: key);
  final DateTime date;
  final void Function() onTap;
  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateFormat dateFormatDay = DateFormat("dd/MM/yyyy");
  late DateTime date;

  @override
  void initState() {
    // TODO: implement initState
    date = widget.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.black12),
              borderRadius: BorderRadius.circular(8)),
          width: size.width,
          child: Row(
            // crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Image.asset(
                'images/icon/calendar-color.png',
                width: 36,
                height: 36,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10),
              Text('${dateFormatDay.format(date)}',
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.7))),
              Icon(Icons.arrow_drop_down),
              Spacer(),
            ],
          ),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(left: 8, right: 8, bottom: 5)),
    );
  }
}
