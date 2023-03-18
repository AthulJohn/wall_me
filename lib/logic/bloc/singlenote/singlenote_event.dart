part of 'singlenote_bloc.dart';

abstract class SinglenoteEvent extends Equatable {
  const SinglenoteEvent();

  @override
  List<Object> get props => [];
}

class SetNote extends SinglenoteEvent {
  final SingleNote note;
  const SetNote(this.note);
}

class AddImage extends SinglenoteEvent {
  // final List<ImageComponent> imageComponents;
  final int? index;
  const AddImage({this.index});
}

class ChangeCurrentImage extends SinglenoteEvent {
  final int? index;
  const ChangeCurrentImage({this.index});
}

class ActivateBackgroundImagePanel extends SinglenoteEvent {}

class ChangeTextSelection extends SinglenoteEvent {
  final int textIndex, textCollectionIndex;
  const ChangeTextSelection(this.textCollectionIndex, this.textIndex);
}

class ChangeImageStyle extends SinglenoteEvent {
  final ImageComponent imageComponent;
  const ChangeImageStyle(this.imageComponent);
}

class ChangeImageColor extends SinglenoteEvent {
  final Color color;
  const ChangeImageColor(this.color);
}

class ChangeText extends SinglenoteEvent {
  final TextComponent textComponent;
  const ChangeText(this.textComponent);
}
