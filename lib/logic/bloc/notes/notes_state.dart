part of 'notes_bloc.dart';

enum NotesStatus { loading, success, initial, error }

enum ImageStatus { loading, success, error, empty }

enum TextStatus { loading, success, error }

class NotesState extends Equatable {
  final List<SingleNote> notes;
  // final int notesCount;

  final int currentNoteIndex;
  final NotesStatus notesStatus;

  const NotesState({
    this.notes = const [],
    // this.notesCount = 0,
    this.currentNoteIndex = 0,
    this.notesStatus = NotesStatus.initial,
  });

  @override
  List<Object?> get props => [
        notes,
        // notesCount,
        currentNoteIndex,
        notesStatus,
      ];

  NotesState copyWith({
    List<SingleNote>? notes,
    NotesStatus? notesStatus,
    int? currentNoteIndex,
  }) {
    return NotesState(
      notes: notes ?? this.notes,
      // notesCount: notesCount ?? this.notesCount,
      currentNoteIndex: currentNoteIndex ?? this.currentNoteIndex,
      notesStatus: notesStatus ?? this.notesStatus,
    );
  }

  SingleNote? get currentNote {
    if (notes.isEmpty) return null;
    return notes[currentNoteIndex];
  }

  NotesState editCurrentNote(SingleNote singleNote) {
    notes[currentNoteIndex] = singleNote;
    return this;
  }

  // NotesState addImageToCurrentNote({
  //   required String imagePath,
  //   required String mimeType,
  // }) {
  //   notes[currentNoteIndex].addImage(imagePath, mimeType, currentImageIndex);
  //   return copyWith(
  //       notes: notes,
  //       // notesCount: notesCount,

  //       notesStatus: NotesStatus.success);
  // }

  // NotesState addBackgroundImageToCurrentNote() {
  //   notes[currentNoteIndex].addImage('', 'image/png',
  //       totalImagesPerTemplate[notes[currentNoteIndex].templateId] ?? 1);
  //   return copyWith(
  //       notes: notes,
  //       // notesCount: notesCount,
  //       currentImageIndex:
  //           (totalImagesPerTemplate[notes[currentNoteIndex].templateId] ?? 1),
  //       notesStatus: NotesStatus.success);
  // }
}
