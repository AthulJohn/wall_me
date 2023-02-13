part of 'notes_bloc.dart';

enum NotesStatus { loading, success, initial, error }

class NotesState {
  List<SingleNote> notes = [];
  int notesCount = 0;
  int currentNoteIndex = 0;
  NotesStatus notesStatus;

  NotesState(
      {this.notes = const [],
      this.notesCount = 0,
      this.currentNoteIndex = 0,
      this.notesStatus = NotesStatus.initial});

  NotesState copyWith(
      {List<SingleNote>? notes,
      int? notesCount,
      NotesStatus? notesStatus,
      int? currentNoteIndex}) {
    return NotesState(
      notes: notes ?? this.notes,
      notesCount: notesCount ?? this.notesCount,
      currentNoteIndex: currentNoteIndex ?? this.currentNoteIndex,
      notesStatus: notesStatus ?? this.notesStatus,
    );
  }

  void addNote(int template) {
    if (notes.isEmpty) {
      notes = [SingleNote(templateId: template)];
    } else {
      notes.add(SingleNote(templateId: template));
    }
    notesCount = notes.length;
    currentNoteIndex = notesCount - 1;
  }
}
