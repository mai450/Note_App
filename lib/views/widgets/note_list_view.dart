import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/cubits/cubit/all_notes_cubit.dart';
import 'package:note/models/note_model.dart';
import 'package:note/views/widgets/custom_note_card.dart';

class NotesList extends StatelessWidget {
  const NotesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllNotesCubit, AllNotesState>(
      builder: (context, state) {
        List<NoteModel> notes = BlocProvider.of<AllNotesCubit>(context).note!;
        return ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return CustomNoteCard(
              note: notes[index],
            );
          },
        );
      },
    );
  }
}
