import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:note/models/note_model.dart';
import 'package:note/services/notification_service.dart';
import 'package:note/views/widgets/custom_button.dart';
import 'package:note/views/widgets/custom_text_feild.dart';
import 'package:note/views/widgets/date_time_selector.dart';
import 'package:note/views/widgets/pick_color.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({
    super.key,
  });

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? title, content;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> scheduleNotification() async {
    final DateTime scheduledDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    await NotificationService().scheduleNotification(
        scheduledDate: scheduledDateTime, title: title, body: content);
  }

  void updateDateTime(DateTime date, TimeOfDay time) {
    setState(() {
      selectedDate = date;
      selectedTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          DateTimeSelector(
            selectedDate: selectedDate,
            selectedTime: selectedTime,
            onDateTimeChanged: updateDateTime,
          ),
          CustomTextfield(
            hintText: 'Title',
            onSave: (value) {
              title = value;
            },
          ),
          SizedBox(
            height: 12,
          ),
          CustomTextfield(
            hintText: 'Content',
            onSave: (value) {
              content = value;
            },
            maxLine: 5,
          ),
          SizedBox(
            height: 20,
          ),
          PickColor(),
          SizedBox(
            height: 20,
          ),
          // IconButton(
          //     onPressed: () => NotificationService().showNotification(
          //           title: 'shownotification',
          //           body: 'body',
          //         ),
          //     icon: Icon(Icons.calendar_month_outlined)),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              return CustomButton(
                buttonText: 'Add',
                isLoading: state is AddNoteLoading ? true : false,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    var currentDate = DateTime.now();
                    var formattedDate =
                        DateFormat('dd-MM-yyyy').format(currentDate);
                    var note = NoteModel(
                      title: title!,
                      content: content!,
                      date: formattedDate,
                      color: BlocProvider.of<AddNoteCubit>(context).color.value,
                    );
                    BlocProvider.of<AddNoteCubit>(context).addNote(note);
                    scheduleNotification();
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
