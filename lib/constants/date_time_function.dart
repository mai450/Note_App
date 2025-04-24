import 'package:flutter/material.dart';
import 'package:note/services/notification_service.dart';

DateTime selectedDate = DateTime.now();
TimeOfDay selectedTime = TimeOfDay.now();

Future<void> scheduleNotification({
  String? title,
  content,
}) async {
  DateTime scheduledDateTime = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    selectedTime.hour,
    selectedTime.minute,
  );

  await NotificationService().scheduleNotification(
      scheduledDate: scheduledDateTime, title: title, body: content);
}

void updateDateTime(
  DateTime date,
  TimeOfDay time,
) {
  selectedDate = date;
  selectedTime = time;
}
