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
  final TextFieldCubit textFieldCubit;
  final WorkshopUiCubit workshopUiCubit;
  NextPage(this.singlenoteBloc, this.textFieldCubit, this.workshopUiCubit);
}

class PreviousPage extends NotesEvent {
  final SinglenoteBloc singlenoteBloc;
  final TextFieldCubit textFieldCubit;
  final WorkshopUiCubit workshopUiCubit;
  PreviousPage(this.singlenoteBloc, this.textFieldCubit, this.workshopUiCubit);
}

class GoToPage extends NotesEvent {
  final int index;
  final TextFieldCubit textFieldCubit;

  final SinglenoteBloc singlenoteBloc;
  final WorkshopUiCubit workshopUiCubit;
  GoToPage(
      {this.index = 11,
      required this.singlenoteBloc,
      required this.textFieldCubit,
      required this.workshopUiCubit});
}
