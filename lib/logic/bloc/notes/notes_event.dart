part of 'notes_bloc.dart';

class NotesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddNotes extends NotesEvent {
  final int templateIndex;
  AddNotes({this.templateIndex = 11});
}

class NextPage extends NotesEvent {}

class PreviousPage extends NotesEvent {}

class AddImage extends NotesEvent {
  // final List<ImageComponent> imageComponents;
  final int? index;
  AddImage({this.index});
}

class ChangeCurrentImage extends NotesEvent {
  final int? index;
  ChangeCurrentImage({this.index});
}

class AddText extends NotesEvent {
  final String text;
  AddText(this.text);
}

class ChangeTextSelection extends NotesEvent {
  final int textIndex, textCollectionIndex;
  ChangeTextSelection(this.textCollectionIndex, this.textIndex);
}

class ChangeImageColor extends NotesEvent {
  final Color color;
  ChangeImageColor(this.color);
}

class ChangeImageColorOpacity extends NotesEvent {
  final double value;
  ChangeImageColorOpacity(this.value);
}

class ChangeImageFit extends NotesEvent {
  final BoxFit fit;
  ChangeImageFit(this.fit);
}
