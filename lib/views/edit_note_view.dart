import 'package:flutter/material.dart';
import 'package:note/models/note_model.dart';
import 'package:note/views/widgets/edit_note_view_body.dart';

class EditNoteView extends StatelessWidget {
  const EditNoteView({super.key, required this.note});
  final NoteModel note;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: EditNoteViewbody(
            note: note,
          ),
        ),
      ),
    );
  }
}
