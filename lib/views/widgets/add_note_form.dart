import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:note/constants/const.dart';
import 'package:note/constants/date_time_function.dart';
import 'package:note/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:note/models/note_model.dart';
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

                    // var currentDate = DateTime.now();
                    var formattedDate =
                        DateFormat('dd-MM-yyyy').format(selectedDate);
                    int position = Hive.box<NoteModel>(kBoxName).length;

                    var note = NoteModel(
                      title: title!,
                      content: content!,
                      date: formattedDate,
                      color: BlocProvider.of<AddNoteCubit>(context).color.value,
                      position: position,
                      // selectedTime:
                      //     BlocProvider.of<AddNoteCubit>(context).reminderTime,
                    );

                    BlocProvider.of<AddNoteCubit>(context).addNote(note);
                    scheduleNotification(
                      title: title,
                      content: content,
                    );
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
