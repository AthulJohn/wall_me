part of 'singlenote_bloc.dart';

enum LoadingStatus { loading, success, error }

class SinglenoteState extends Equatable {
  const SinglenoteState(this.note,
      {this.currentNoteIndex = 0,
      this.currentTextIndex = 0,
      this.currentTextCollectionIndex = 0,
      this.currentImageIndex = 0,
      this.noteStatus = LoadingStatus.success,
      this.imageStatus = LoadingStatus.success,
      this.textStatus = LoadingStatus.success});
  final SingleNote note;
  final int currentNoteIndex,
      currentTextIndex,
      currentTextCollectionIndex,
      currentImageIndex;
  final LoadingStatus noteStatus, imageStatus, textStatus;
  @override
  List<Object> get props => [
        note,
        currentNoteIndex,
        currentTextIndex,
        currentTextCollectionIndex,
        currentImageIndex,
        noteStatus,
        imageStatus,
        textStatus
      ];

  SinglenoteState copyWith({
    SingleNote? note,
    int? currentNoteIndex,
    int? currentTextIndex,
    int? currentTextCollectionIndex,
    int? currentImageIndex,
    LoadingStatus? noteStatus,
    LoadingStatus? imageStatus,
    LoadingStatus? textStatus,
  }) {
    return SinglenoteState(note ?? this.note,
        currentNoteIndex: currentNoteIndex ?? this.currentNoteIndex,
        currentTextIndex: currentTextIndex ?? this.currentTextIndex,
        currentTextCollectionIndex:
            currentTextCollectionIndex ?? this.currentTextCollectionIndex,
        currentImageIndex: currentImageIndex ?? this.currentImageIndex,
        noteStatus: noteStatus ?? this.noteStatus,
        imageStatus: imageStatus ?? this.imageStatus,
        textStatus: textStatus ?? this.textStatus);
  }

  bool get imageIsBackground {
    print(
        " $currentImageIndex with ${totalImagesPerTemplate[note.templateId]}");
    return currentImageIndex == (totalImagesPerTemplate[note.templateId] ?? 1);
  }

  SinglenoteState addImageToCurrentNote(
      {required String imagePath,
      required String mimeType,
      required int imageindex}) {
    note.addImage(imagePath, mimeType, imageindex);
    return copyWith(
        note: note,
        // notesCount: notesCount,
        currentImageIndex: imageindex,
        imageStatus: LoadingStatus.success);
  }

  SinglenoteState addBackgroundImageToCurrentNote() {
    note.addBackgroundImage();
    return copyWith(
        note: note,
        // notesCount: notesCount,
        currentImageIndex: (totalImagesPerTemplate[note.templateId] ?? 1),
        imageStatus: LoadingStatus.success);
  }

  ImageComponent? get currentImage {
    if (note.imageComponents.isEmpty) return null;
    return note.imageComponents[currentImageIndex];
  }

  TextComponent? get currentText {
    if (note.textComponents.length <= currentTextCollectionIndex) {
      return null;
    }
    if (note.textComponents[currentTextCollectionIndex].length <=
        currentTextIndex) return null;
    return note.textComponents[currentTextCollectionIndex][currentTextIndex];
  }
}

// class SinglenoteIdle extends SinglenoteState {
//   const SinglenoteIdle(SingleNote note) : super(note);
//   const SinglenoteIdle.copyNote() : super(SingleNote.empty());
// }

// class SinglenoteImageLoading extends SinglenoteState {
//   const SinglenoteImageLoading(SingleNote note) : super(note);
// }

// class SinglenoteError extends SinglenoteState {
//   final String error;

//   /// On error, give an empty note and the error message
//   const SinglenoteError(SingleNote note, this.error) : super(note);
// }
