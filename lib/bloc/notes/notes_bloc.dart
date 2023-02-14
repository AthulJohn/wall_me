import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data_providers/image_picker_provider.dart';
import '../../models/workshop/singlenote_model.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesState()) {
    on<AddNotes>(_addNotesFunction);
    on<NextPage>(_nextPageFunction);
    on<PreviousPage>(_previousPageFunction);
    on<AddImage>(_pickImageFunction);
  }

  void _addNotesFunction(event, emit) {
    emit(state.copyWith(notesStatus: NotesStatus.loading));
    try {
      //CAll the API here
      List<SingleNote> notes = state.notes;
      if (notes.isEmpty) {
        notes = [
          SingleNote(templateId: event.templateIndex, noteid: notes.length)
        ];
      } else {
        notes.add(
            SingleNote(templateId: event.templateIndex, noteid: notes.length));
      }
      emit(NotesState(
          notesStatus: NotesStatus.success,
          notes: notes,
          currentNoteIndex: notes.length - 1,
          notesCount: notes.length));
    } catch (e) {
      debugPrint("In function _addNotesFunction of NotesBloc, $e");
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
      debugPrint("In function _nextPageFunction of NotesBloc, $e");
      emit(state.copyWith(notesStatus: NotesStatus.error));
    }
  }

  void _previousPageFunction(event, emit) {
    emit(state.copyWith(notesStatus: NotesStatus.loading));
    try {
      if (state.currentNoteIndex > 0) {
        emit(state.copyWith(
            currentNoteIndex: state.currentNoteIndex - 1,
            notesStatus: NotesStatus.success));
      }
    } catch (e) {
      debugPrint("In function _previousPageFunction of NotesBloc, $e");
      emit(state.copyWith(notesStatus: NotesStatus.error));
    }
  }

  void _pickImageFunction(event, emit) async {
    emit(state.copyWith(notesStatus: NotesStatus.loading));
    try {
      String? imagePath = await ImagePickerProvider.pickImage();
      if (imagePath == null) {
        emit(state.copyWith(notesStatus: NotesStatus.error));
        return;
      }
      emit(state.addImageToCurrentNote(imagePath: imagePath));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(notesStatus: NotesStatus.error));
    }
  }
}
