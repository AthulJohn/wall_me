part of 'notes_bloc.dart';

enum NotesStatus { loading, success, initial, error }

enum ImageStatus { loading, success, error, empty }

enum TextStatus { loading, success, error, empty }

class NotesState extends Equatable {
  final List<SingleNote> notes;
  final int notesCount;
  final int currentNoteIndex, currentTextIndex, currentTextCollectionIndex;
  final NotesStatus notesStatus;
  final ImageStatus imageStatus;
  final TextStatus textStatus;

  const NotesState(
      {this.notes = const [],
      this.notesCount = 0,
      this.currentNoteIndex = 0,
      this.notesStatus = NotesStatus.initial,
      this.imageStatus = ImageStatus.success,
      this.textStatus = TextStatus.empty,
      this.currentTextCollectionIndex = 0,
      this.currentTextIndex = 0});

  @override
  List<Object?> get props => [
        notes,
        notesCount,
        currentNoteIndex,
        notesStatus,
        imageStatus,
        textStatus,
        currentTextCollectionIndex,
        currentTextIndex
      ];

  NotesState copyWith(
      {List<SingleNote>? notes,
      int? notesCount,
      NotesStatus? notesStatus,
      int? currentNoteIndex,
      ImageStatus? imageStatus,
      TextStatus? textStatus,
      int? currentTextCollectionIndex,
      int? currentTextIndex}) {
    return NotesState(
        notes: notes ?? this.notes,
        notesCount: notesCount ?? this.notesCount,
        currentNoteIndex: currentNoteIndex ?? this.currentNoteIndex,
        notesStatus: notesStatus ?? this.notesStatus,
        imageStatus: imageStatus ?? this.imageStatus,
        textStatus: textStatus ?? this.textStatus,
        currentTextCollectionIndex:
            currentTextCollectionIndex ?? this.currentTextCollectionIndex,
        currentTextIndex: currentTextIndex ?? this.currentTextIndex);
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
