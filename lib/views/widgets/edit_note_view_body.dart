import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/constants/date_time_function.dart';
import 'package:note/cubits/all_notes_cubit/all_notes_cubit.dart';
import 'package:note/models/note_model.dart';
import 'package:note/views/widgets/custom_app_bar.dart';
import 'package:note/views/widgets/custom_text_feild.dart';
import 'package:note/views/widgets/date_time_selector.dart';
import 'package:note/views/widgets/edit_note_color.dart';

class EditNoteViewbody extends StatefulWidget {
  const EditNoteViewbody({super.key, required this.note});
  final NoteModel note;
  @override
  State<EditNoteViewbody> createState() => _EditNoteViewbodyState();
}

class _EditNoteViewbodyState extends State<EditNoteViewbody> {
  String? title, content;
  late TextEditingController titleController;
  late TextEditingController contentController;
  // DateTime? showPickerTimeButton;
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    contentController = TextEditingController(text: widget.note.content);
    //showPickerTimeButton = widget.note.selectedTime;
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: 'Edit',
          icon: Icons.check,
          onPressed: () {
            widget.note.title = title ?? widget.note.title;
            widget.note.content = content ?? widget.note.content;
            widget.note.save();
            BlocProvider.of<AllNotesCubit>(context).getAllNotes();

            scheduleNotification(
              title: widget.note.title,
              content: widget.note.content,
            );
            Navigator.pop(context);
          },
        ),
        SizedBox(
          height: 20,
        ),
        //if (widget.note.selectedTime != null)
        DateTimeSelector(
          selectedDate: selectedDate,
          selectedTime: selectedTime,
          onDateTimeChanged: updateDateTime,
        ),
        CustomTextfield(
          controller: titleController,
          onChanged: (value) {
            title = value;
          },
        ),
        SizedBox(
          height: 12,
        ),
        CustomTextfield(
          controller: contentController,
          onChanged: (value) {
            content = value;
          },
          maxLine: 5,
        ),
        SizedBox(
          height: 12,
        ),
        EditNoteColor(note: widget.note),
      ],
    );
  }
}
