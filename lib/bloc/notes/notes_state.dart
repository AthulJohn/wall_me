part of 'notes_bloc.dart';

enum NotesStatus { loading, success, initial, error }

class NotesState extends Equatable {
  final List<SingleNote> notes;
  final int notesCount;
  final int currentNoteIndex;
  final NotesStatus notesStatus;

  const NotesState(
      {this.notes = const [],
      this.notesCount = 0,
      this.currentNoteIndex = 0,
      this.notesStatus = NotesStatus.initial});

  @override
  List<Object?> get props => [notes, notesCount, currentNoteIndex, notesStatus];

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

  SingleNote get currentNote => notes[currentNoteIndex];

  NotesState editCurrentNote(SingleNote singleNote) {
    notes[currentNoteIndex] = singleNote;
    return this;
  }

  NotesState addImageToCurrentNote({
    required String imagePath,
  }) {
    notes[currentNoteIndex].addImage(imagePath);
    return NotesState(
        notes: notes,
        notesCount: notesCount,
        currentNoteIndex: currentNoteIndex,
        notesStatus: NotesStatus.success);
  }
}
