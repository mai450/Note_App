import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/cubits/all_notes_cubit/all_notes_cubit.dart';
import 'package:note/views/search_view.dart';
import 'package:note/views/widgets/custom_app_bar.dart';
import 'package:note/views/widgets/note_list_view.dart';

class NoteViewBody extends StatefulWidget {
  const NoteViewBody({super.key});

  @override
  State<NoteViewBody> createState() => _NoteViewBodyState();
}

class _NoteViewBodyState extends State<NoteViewBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AllNotesCubit>(context).getAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          CustomAppBar(
            title: 'Notes',
            icon: Icons.search,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const SearchView(),
                ),
              );
            },
          ),
          Expanded(child: NotesList()),
        ],
      ),
    );
  }
}
