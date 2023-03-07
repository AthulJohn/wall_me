part of 'notes_bloc.dart';

class NotesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddNotes extends NotesEvent {
  final int templateIndex;
  AddNotes({this.templateIndex = 11});
}

class SetSingleNote extends NotesEvent {
  final SingleNote note;
  SetSingleNote(this.note);
}

class SetTemplate extends NotesEvent {
  final int templateIndex;
  final SinglenoteBloc singlenoteBloc;
  SetTemplate({this.templateIndex = 11, required this.singlenoteBloc});
}

class NextPage extends NotesEvent {
  final SinglenoteBloc singlenoteBloc;
  NextPage(this.singlenoteBloc);
}

class PreviousPage extends NotesEvent {
  final SinglenoteBloc singlenoteBloc;
  PreviousPage(this.singlenoteBloc);
}

class GoToPage extends NotesEvent {
  final int index;

  final SinglenoteBloc singlenoteBloc;
  GoToPage({this.index = 11, required this.singlenoteBloc});
}
