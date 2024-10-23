import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarShiftWidget extends StatefulWidget {
  final controller;
  CalendarShiftWidget(this.controller);

  @override
  _CalendarShiftWidgetState createState() => _CalendarShiftWidgetState();
}

class _CalendarShiftWidgetState extends State<CalendarShiftWidget> {

  @override
  Widget build(BuildContext context) {
    late DateTime _currentDate ;
    late List<DateTime?> singleDatePickerValueWithDefaultValue = [widget.controller.displayedMonth];
    final config = CalendarDatePicker2Config(
      disableModePicker: true,
      disableMonthPicker: true,
      lastMonthIcon: const SizedBox(), // Hide previous month icon
      nextMonthIcon: const SizedBox(), // Hide next month icon
      selectedDayHighlightColor: Colors.white,
      dayBorderRadius: const BorderRadius.all(Radius.circular(6)),
      selectedDayTextStyle: const TextStyle(
        color: Colors.black,
        //  fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      weekdayLabels: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      firstDayOfWeek: 1,
      controlsHeight: 0, // Hide the default header and icons
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 0,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        //color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      selectableDayPredicate: (day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 365)))
          .isNegative,
      dayBuilder: ({
        required DateTime date,
        BoxDecoration? decoration,
        bool? isDisabled,
        bool? isSelected,
        bool? isToday,
        TextStyle? textStyle,
      }) {
        var status = getDayStatus(date);
        return Container(
          decoration: decoration,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date.day.toString(),
                  style: textStyle,
                ),
                listCircle(status)
              ],
            ),
          ),
        );
      },
    );
    return Column(
      children: [
        CalendarDatePicker2(
          key: ValueKey(widget.controller.displayedMonth), // Use key to force rebuild
          config: config,
          value: singleDatePickerValueWithDefaultValue,
          onDisplayedMonthChanged: (dateTime) {
              widget.controller.displayedMonth = dateTime;
              _currentDate = DateTime(dateTime.year, dateTime.month, 1);
              singleDatePickerValueWithDefaultValue = [_currentDate];
              widget.controller.update();
          },
          onValueChanged: (values) {
              singleDatePickerValueWithDefaultValue = values;
              widget.controller.update();
          },
        ),
        calendarStatus(),
      ],
    );
  }
  listCircle(_list)
  {if(_list==null) return [];
  List<Widget> l=[];
  for(var i=_list.length-1;i>=0;i--) {
    Color? color;
    if (_list[i] == 'OnTime') color = const Color.fromRGBO(11, 162, 89, 1);
    else
    if (_list[i] == 'Late') color = const Color.fromRGBO(250,173, 20,1);
    else
    if (_list[i] == 'Off') color = const Color.fromRGBO(148, 163,184, 1);
    else color=Colors.transparent;
    l.add(
        Container(padding: const EdgeInsets.only(left: 2, right: 2), child:
        Circle(size: 4.5, color: color)));
  }
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: l);
  }
  getDayStatus(DateTime date) {
    var _list=[];
    try{
      for (var v in widget.controller.historyTimeSheet) {
        if (DateTime.parse(v['StartTime'].toString()).day == date.day &&
            DateTime.parse(v['StartTime'].toString()).month == date.month &&
            DateTime.parse(v['StartTime'].toString()).year == date.year) {
          _list.add(v['Status'] ??'');
        }
      }
      return _list;
    }
    catch (e) {}
    return []; // Modify this as per your logic
  }
}

// Custom Circle widget
class Circle extends StatelessWidget {
  final double size;
  final Color color;

  Circle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class calendarStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Center(child:       Container(
        decoration: const BoxDecoration(
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                borderRadius : BorderRadius.only(
                  topLeft: Radius.circular(5.867924213409424),
                  topRight: Radius.circular(5.867924213409424),
                  bottomLeft: Radius.circular(5.867924213409424),
                  bottomRight: Radius.circular(5.867924213409424),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color : Color.fromRGBO(11, 162, 89, 1),
                              borderRadius : BorderRadius.all(Radius.elliptical(6, 6)),
                            )
                        ),
                      ],
                    ),
                  ), const SizedBox(width : 6),
                  const Text('Đúng giờ', textAlign: TextAlign.left, style: TextStyle(
                      color: Color.fromRGBO(51, 65, 85, 1),
                      fontFamily: 'Inter',
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1.5 /*PERCENT not supported*/
                  ),),
                ],
              ),
            ), const SizedBox(width : 12),
            Container(
              decoration: const BoxDecoration(
                borderRadius : BorderRadius.only(
                  topLeft: Radius.circular(5.867924213409424),
                  topRight: Radius.circular(5.867924213409424),
                  bottomLeft: Radius.circular(5.867924213409424),
                  bottomRight: Radius.circular(5.867924213409424),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color : Color.fromRGBO(250, 173, 20, 1),
                              borderRadius : BorderRadius.all(Radius.elliptical(6, 6)),
                            )
                        ),
                      ],
                    ),
                  ), const SizedBox(width : 6),
                  const Text('Đi trễ', textAlign: TextAlign.left, style: TextStyle(
                      color: Color.fromRGBO(51, 65, 85, 1),
                      fontFamily: 'Inter',
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1.5 /*PERCENT not supported*/
                  ),),
                ],
              ),
            ), const SizedBox(width : 12),
            Container(
              decoration: const BoxDecoration(
                borderRadius : BorderRadius.only(
                  topLeft: Radius.circular(5.867924213409424),
                  topRight: Radius.circular(5.867924213409424),
                  bottomLeft: Radius.circular(5.867924213409424),
                  bottomRight: Radius.circular(5.867924213409424),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color : Color.fromRGBO(148, 163, 184, 1),
                              borderRadius : BorderRadius.all(Radius.elliptical(6, 6)),
                            )
                        ),
                      ],
                    ),
                  ), const SizedBox(width : 6),
                  const Text('Nghỉ', textAlign: TextAlign.left, style: TextStyle(
                      color: Color.fromRGBO(51, 65, 85, 1),
                      fontFamily: 'Inter',
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1.5 /*PERCENT not supported*/
                  ),),
                ],
              ),
            ),

          ],
        ),
      ));
  }
}
///