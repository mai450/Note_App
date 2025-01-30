import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/cubits/cubit/all_notes_cubit.dart';
import 'package:note/models/note_model.dart';
import 'package:note/views/widgets/custom_app_bar.dart';
import 'package:note/views/widgets/custom_text_feild.dart';
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

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    contentController = TextEditingController(text: widget.note.content);
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
            Navigator.pop(context);
          },
        ),
        SizedBox(
          height: 20,
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
