import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/cubits/all_notes_cubit/all_notes_cubit.dart';
import 'package:note/models/note_model.dart';
import 'package:note/views/widgets/custom_note_card.dart';

class NotesList extends StatefulWidget {
  const NotesList({
    super.key,
  });

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllNotesCubit, AllNotesState>(
      builder: (context, state) {
        List<NoteModel> notes = BlocProvider.of<AllNotesCubit>(context).note;
        return ReorderableListView(
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex -= 1;
                final item = notes.removeAt(oldIndex);
                notes.insert(newIndex, item);
              });
              BlocProvider.of<AllNotesCubit>(context)
                  .updateOrder(updateNotes: notes);
            },
            children: [
              for (int index = 0; index < notes.length; index++)
                CustomNoteCard(
                  key: ValueKey(notes[index].hashCode), // use hashCode as id
                  note: notes[index],
                ),
            ]);
        //  ListView.builder(
        //   itemCount: notes.length,
        //   itemBuilder: (context, index) {
        //     return CustomNoteCard(
        //       note: notes[index],
        //     );
        //   },
        // );
      },
    );
  }
}
