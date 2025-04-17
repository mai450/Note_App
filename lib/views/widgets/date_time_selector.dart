import 'package:flutter/material.dart';

class DateTimeSelector extends StatelessWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final Function(DateTime date, TimeOfDay time) onDateTimeChanged;
  const DateTimeSelector(
      {super.key,
      required this.selectedDate,
      required this.selectedTime,
      required this.onDateTimeChanged});

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));

    if (pickedDate != null && pickedDate != selectedDate) {
      onDateTimeChanged(pickedDate, selectedTime);
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: selectedTime);

    if (pickedTime != null && pickedTime != selectedTime) {
      onDateTimeChanged(selectedDate, pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () => selectDate(context),
            icon: Icon(Icons.calendar_month_outlined)),
        IconButton(
            onPressed: () => selectTime(context), icon: Icon(Icons.alarm)),
      ],
    );

    // Row(
    //   mainAxisAlignment: MainAxisAlignment.end,
    //   children: [
    //     IconButton(
    //         onPressed: () {
    //           DatePicker.showDateTimePicker(
    //             context,
    //             showTitleActions: true,

    //             onConfirm: (date) {
    //               setState(() {
    //                 selectedDate = date;
    //               });
    //             },
    //             onChanged: (date) {
    //               selectedDate = date;
    //             },
    //             // currentTime: DateTime.now(),
    //           );
    //         },
    //         icon: Icon(Icons.alarm)),
    //   ],
    // ),
  }
}
