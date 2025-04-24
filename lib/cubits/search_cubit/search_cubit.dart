import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:note/constants/const.dart';
import 'package:note/models/note_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  List<NoteModel> searchnote = [];
  void search({required String searchText}) {
    var noteBox = Hive.box<NoteModel>(kBoxName);
    final allNotes = noteBox.values.toList();
    final searchNotes = allNotes
        .where(
          (note) =>
              note.title.toLowerCase().contains(searchText) ||
              note.content.toLowerCase().contains(searchText),
        )
        .toList();
    searchnote = searchNotes;
    emit(SearchSuccess(notes: searchnote));
  }

  void getNotes({
    required String searchText,
  }) {
    if (searchText.isNotEmpty) {
      search(
        searchText: searchText,
      );
    } else {
      emit(SearchSuccess(notes: []));
    }
  }
}
