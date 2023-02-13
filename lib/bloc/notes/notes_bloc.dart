import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/workshop/singleNote_model.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesState()) {
    on<AddNotes>(_addNotesFunction);
    on<NextPage>(_nextPageFunction);
    on<PreviousPage>(_previousPageFunction);
  }
  void _addNotesFunction(event, emit) {
    emit(state.copyWith(notesStatus: NotesStatus.loading));
    try {
      //CAll the API here
      state.addNote(event.templateIndex);
      emit(state.copyWith(
          notesStatus: NotesStatus.success, notesCount: state.notes.length));
    } catch (e) {
      print(e);
      emit(state.copyWith(notesStatus: NotesStatus.error));
    }
  }

  void _nextPageFunction(event, emit) {
    emit(state.copyWith(notesStatus: NotesStatus.loading));
    try {
      if (state.currentNoteIndex < state.notes.length - 1) {
        emit(state.copyWith(
            notesStatus: NotesStatus.success,
            currentNoteIndex: state.currentNoteIndex + 1));
      } else {
        add(AddNotes());
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(notesStatus: NotesStatus.error));
    }
  }

  void _previousPageFunction(event, emit) {
    emit(state.copyWith(notesStatus: NotesStatus.loading));
    try {
      if (state.currentNoteIndex > 0) {
        emit(state.copyWith(
            notesStatus: NotesStatus.success,
            currentNoteIndex: state.currentNoteIndex - 1));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(notesStatus: NotesStatus.error));
    }
  }
}
