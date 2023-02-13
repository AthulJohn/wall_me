import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/workshop/singleNote_model.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesState()) {
    on<AddNotes>(_addNotesFunction);
  }
  void _addNotesFunction(event, emit) {
    emit(state.copyWith(notesStatus: NotesStatus.loading));
    try {
      //CAll the API here
      state.notes.add(SingleNote());
      emit(state.copyWith(
          notesStatus: NotesStatus.success, notesCount: state.notes.length));
    } catch (e) {
      emit(state.copyWith(notesStatus: NotesStatus.error));
    }
  }
}
