import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:note/constants/const.dart';
import 'package:note/models/note_model.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitial());

  Color color = kColors[0];
  DateTime? reminderTime;

  addNote(NoteModel note) async {
    note.color = color.value;

    emit(AddNoteLoading());
    try {
      var noteBox = Hive.box<NoteModel>(kBoxName);
      note.position = noteBox.length;
      //note.selectedTime = reminderTime;
      await noteBox.add(note);
      reminderTime = null;
      emit(AddNoteSuccess());
    } catch (e) {
      emit(AddNoteFailure(errMessage: e.toString()));
    }
  }
}
