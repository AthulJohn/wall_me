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

class ChangeTextSelection extends NotesEvent {
  final int textIndex, textCollectionIndex;
  ChangeTextSelection(this.textCollectionIndex, this.textIndex);
}

class ChangeImageStyle extends NotesEvent {
  final ImageComponent imageComponent;
  ChangeImageStyle(this.imageComponent);
}

class ChangeText extends NotesEvent {
  final TextComponent textComponent;
  ChangeText(this.textComponent);
}
