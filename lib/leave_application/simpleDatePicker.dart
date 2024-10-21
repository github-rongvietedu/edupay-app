import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<DateTime?> show3ColumnDatePickerBottomSheet(BuildContext context, DateTime initialDate) async {
  return await showModalBottomSheet<DateTime>(
    backgroundColor: Colors.white,
    context: context,
    builder: (BuildContext context) {
      return DatePickerWidget(
        initialDate: initialDate,
        onDateChanged: (DateTime date) {},
      );
    },
  );
}

class DatePickerWidget extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateChanged;

  const DatePickerWidget({
    required this.initialDate,
    required this.onDateChanged,
  });

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late int selectedDay;
  late int selectedMonth;
  late int selectedYear;

  late FixedExtentScrollController dayScrollController;
  late FixedExtentScrollController monthScrollController;
  late FixedExtentScrollController yearScrollController;
  final ValueNotifier<int> maxDaysNotifier = ValueNotifier<int>(31);

  @override
  void initState() {
    super.initState();
    selectedDay = widget.initialDate.day;
    selectedMonth = widget.initialDate.month;
    selectedYear = widget.initialDate.year;

    dayScrollController = FixedExtentScrollController(
      initialItem: selectedDay - 1,
    );
    monthScrollController = FixedExtentScrollController(
      initialItem: selectedMonth - 1,
    );
    yearScrollController = FixedExtentScrollController(
      initialItem: selectedYear - 2000,
    );
    maxDaysNotifier.value = _getDaysInMonth(selectedYear, selectedMonth);
  }

  void _onConfirm() {
    DateTime selectedDate = DateTime(selectedYear, selectedMonth, selectedDay);
    Navigator.of(context).pop(selectedDate); // Return the selected date
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onConfirm();
        return true;
      },
      child: Container(
        decoration: const BoxDecoration(
        ),
        height: 270, // Increase height for better visibility
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 40),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Chọn ngày',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: _onConfirm, // Confirm and close the bottom sheet
                  ),
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: CustomPaint(
                      painter: LinePainter(),
                      child: Container(
                        height: 160, // Increase height to match row heights
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListWheelScrollView.useDelegate(
                          controller: yearScrollController,
                          itemExtent: 60, // Increased height for each item
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedYear = 2000 + index;
                              maxDaysNotifier.value = _getDaysInMonth(selectedYear, selectedMonth);
                              if (selectedDay > maxDaysNotifier.value) {
                                selectedDay = maxDaysNotifier.value;
                              }
                              dayScrollController.jumpToItem(selectedDay - 1);
                              widget.onDateChanged(DateTime(selectedYear, selectedMonth, selectedDay));
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              final isSelected = selectedYear == 2000 + index;
                              return Center(
                                child: Text(
                                  "${2000 + index}",
                                  style: TextStyle(
                                    fontSize: 15, // Increased font size for better visibility
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: isSelected ? Colors.black : Colors.grey,
                                  ),
                                ),
                              );
                            },
                            childCount: 101, // 2000 to 2100
                          ),
                        ),
                      ),

                      // Month Picker
                      Expanded(
                        child: ListWheelScrollView.useDelegate(
                          controller: monthScrollController,
                          itemExtent: 60, // Increased height for each item
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedMonth = (index % 12) + 1;
                              maxDaysNotifier.value = _getDaysInMonth(selectedYear, selectedMonth);

                              // Adjust selected day if it exceeds the max days in the new month
                              if (selectedDay > maxDaysNotifier.value) {
                                selectedDay = maxDaysNotifier.value;
                              }
                              dayScrollController.jumpToItem(selectedDay - 1);
                              widget.onDateChanged(DateTime(selectedYear, selectedMonth, selectedDay));
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              final displayedIndex = index % 12;
                              final isSelected = selectedMonth == displayedIndex + 1;
                              return Center(
                                child: Text(
                                  "Tháng ${displayedIndex + 1}",
                                  style: TextStyle(
                                    fontSize: 15, // Increased font size for better visibility
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: isSelected ? Colors.black : Colors.grey,
                                  ),
                                ),
                              );
                            },
                            childCount: 10000, // Large number to simulate cyclic scrolling
                          ),
                        ),
                      ),
                      // Day Picker
                      Expanded(
                        child: ValueListenableBuilder<int>(
                          valueListenable: maxDaysNotifier,
                          builder: (context, maxDays, child) {
                            return ListWheelScrollView.useDelegate(
                              controller: dayScrollController,
                              itemExtent: 60, // Increased height for each item
                              physics: const FixedExtentScrollPhysics(),
                              onSelectedItemChanged: (index) {
                                setState(() {
                                  selectedDay = (index % maxDays) + 1;
                                  widget.onDateChanged(DateTime(selectedYear, selectedMonth, selectedDay));
                                });
                              },
                              childDelegate: ListWheelChildBuilderDelegate(
                                builder: (context, index) {
                                  final displayedIndex = index % maxDays;
                                  final isSelected = selectedDay == displayedIndex + 1;
                                  return Center(
                                    child: Text(
                                      "${displayedIndex + 1}",
                                      style: TextStyle(
                                        fontSize: 15, // Increased font size for better visibility
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                        color: isSelected ? Colors.black : Colors.grey,
                                      ),
                                    ),
                                  );
                                },
                                childCount: 10000, // Large number to simulate cyclic scrolling
                              ),
                            );
                          },
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12)
          ],
        ),
      ),
    );
  }

  int _getDaysInMonth(int year, int month) {
    if (month == 2) {
      return (DateTime(year, 2, 29).day == 29) ? 29 : 28;
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
      // April, June, September, November
      return 30;
    } else {
      return 31;
    }
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.4)
      ..strokeWidth = 1.0;

    double rowHeight = size.height / 3;
    canvas.drawLine(
      Offset(0, rowHeight),
      Offset(size.width, rowHeight),
      paint,
    );
    canvas.drawLine(
      Offset(0, 2.2 * rowHeight),
      Offset(size.width, 2.2 * rowHeight),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
String formatDate(DateTime date) {
  return DateFormat('yyyy/MM/dd').format(date);
}

Widget dateContainer(String date, String label) {
  return Container(height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color:(date.isEmpty)? Colors.grey.withOpacity(0.3):Colors.black),
    ),
    child: Center(
      child: Text(
        date,
        style: const TextStyle(fontSize: 14),
      ),
    ),
  );
}
