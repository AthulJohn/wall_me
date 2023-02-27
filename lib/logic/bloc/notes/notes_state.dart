part of 'notes_bloc.dart';

enum NotesStatus { loading, success, initial, error }

enum ImageStatus { loading, success, error, empty }

enum TextStatus { loading, success, error }

class NotesState extends Equatable {
  final List<SingleNote> notes;
  // final int notesCount;
  final int currentNoteIndex,
      currentTextIndex,
      currentTextCollectionIndex,
      currentImageIndex;
  final NotesStatus notesStatus;
  final ImageStatus imageStatus;
  final TextStatus textStatus;

  const NotesState(
      {this.notes = const [],
      // this.notesCount = 0,
      this.currentNoteIndex = 0,
      this.notesStatus = NotesStatus.initial,
      this.imageStatus = ImageStatus.success,
      this.textStatus = TextStatus.success,
      this.currentTextCollectionIndex = 0,
      this.currentTextIndex = 0,
      this.currentImageIndex = 0});

  @override
  List<Object?> get props => [
        notes,
        // notesCount,
        currentNoteIndex,
        notesStatus,
        imageStatus,
        textStatus,
        currentTextCollectionIndex,
        currentTextIndex,
        currentImageIndex
      ];

  NotesState copyWith(
      {List<SingleNote>? notes,
      int? notesCount,
      NotesStatus? notesStatus,
      int? currentNoteIndex,
      ImageStatus? imageStatus,
      TextStatus? textStatus,
      int? currentTextCollectionIndex,
      int? currentTextIndex,
      int? currentImageIndex}) {
    return NotesState(
        notes: notes ?? this.notes,
        // notesCount: notesCount ?? this.notesCount,
        currentNoteIndex: currentNoteIndex ?? this.currentNoteIndex,
        notesStatus: notesStatus ?? this.notesStatus,
        imageStatus: imageStatus ?? this.imageStatus,
        textStatus: textStatus ?? this.textStatus,
        currentTextCollectionIndex:
            currentTextCollectionIndex ?? this.currentTextCollectionIndex,
        currentTextIndex: currentTextIndex ?? this.currentTextIndex,
        currentImageIndex: currentImageIndex ?? this.currentImageIndex);
  }

  SingleNote? get currentNote {
    if (notes.isEmpty) return null;
    return notes[currentNoteIndex];
  }

  ImageComponent? get currentImage {
    if (notes.isEmpty) return null;
    if (currentNote!.imageComponents.isEmpty) return null;
    return currentNote!.imageComponents[currentImageIndex];
  }

  TextComponent? get currentText {
    if (notes.isEmpty) return null;
    if (currentNote!.textComponents.length <= currentTextCollectionIndex) {
      return null;
    }
    if (currentNote!.textComponents[currentTextCollectionIndex].length <=
        currentTextIndex) return null;
    return currentNote!.textComponents[currentTextCollectionIndex]
        [currentTextIndex];
  }

  NotesState editCurrentNote(SingleNote singleNote) {
    notes[currentNoteIndex] = singleNote;
    return this;
  }

  NotesState addImageToCurrentNote({
    required String imagePath,
    required String mimeType,
  }) {
    notes[currentNoteIndex].addImage(imagePath, mimeType, currentImageIndex);
    return copyWith(
        notes: notes,
        // notesCount: notesCount,

        notesStatus: NotesStatus.success);
  }

  NotesState addBackgroundImageToCurrentNote() {
    notes[currentNoteIndex].addImage('', 'image/png',
        totalImagesPerTemplate[notes[currentNoteIndex].templateId] ?? 1);
    return copyWith(
        notes: notes,
        // notesCount: notesCount,
        currentImageIndex:
            (totalImagesPerTemplate[notes[currentNoteIndex].templateId] ?? 1),
        notesStatus: NotesStatus.success);
  }
}
