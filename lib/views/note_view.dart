import 'package:flutter/material.dart';
import 'package:note/constants/const.dart';
import 'package:note/views/widgets/add_note_bootom_sheet.dart';
import 'package:note/views/widgets/note_view_body.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: NoteViewBody(),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: FloatingActionButton(
            shape: CircleBorder(),
            backgroundColor: kPrimaryColor,
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return AddNoteBottomSheet();
                },
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
