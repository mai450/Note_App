import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/cubits/search_cubit/search_cubit.dart';
import 'package:note/views/widgets/custom_note_card.dart';

class SearchResultListview extends StatelessWidget {
  const SearchResultListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchSuccess) {
          return ListView.builder(
            itemCount: state.notes.length,
            itemBuilder: (context, index) {
              return CustomNoteCard(
                key: ValueKey(state.notes[index].hashCode),
                note: state.notes[index],
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }
}
