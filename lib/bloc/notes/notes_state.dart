part of 'notes_bloc.dart';

enum NotesStatus { loading, success, initial, error }

class NotesState {
  List<SingleNote> notes = [];
  int notesCount = 0;
  NotesStatus notesStatus;

  NotesState(
      {this.notes = const [],
      this.notesCount = 0,
      this.notesStatus = NotesStatus.initial});

  NotesState copyWith(
      {List<SingleNote>? notes, int? notesCount, NotesStatus? notesStatus}) {
    return NotesState(
      notes: notes ?? this.notes,
      notesCount: notesCount ?? this.notesCount,
      notesStatus: notesStatus ?? this.notesStatus,
    );
  }
}
