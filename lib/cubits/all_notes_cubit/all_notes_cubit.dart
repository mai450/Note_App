import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:note/constants/const.dart';
import 'package:note/models/note_model.dart';

part 'all_notes_state.dart';

class AllNotesCubit extends Cubit<AllNotesState> {
  AllNotesCubit() : super(AllNotesInitial());
  List<NoteModel>? note;
  getAllNotes() {
    var noteBox = Hive.box<NoteModel>(kBoxName);

    note = noteBox.values.toList();
    emit(AllNotesSuccess());
  }
}
