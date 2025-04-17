part of 'all_notes_cubit.dart';

@immutable
sealed class AllNotesState {}

final class AllNotesInitial extends AllNotesState {}

final class AllNotesSuccess extends AllNotesState {}
