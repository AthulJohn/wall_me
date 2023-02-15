import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wall_me/logic/models/workshop/text_component_model.dart';

import '../../data_providers/image_picker_provider.dart';
import '../../models/workshop/singlenote_model.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(const NotesState()) {
    on<AddNotes>(_addNotesFunction);
    on<NextPage>(_nextPageFunction);
    on<PreviousPage>(_previousPageFunction);
    on<AddImage>(_pickImageFunction);
    on<AddText>(_addTextFunction);
    on<ChangeTextSelection>(_changeTextSelectionFunction);
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
        emit(NotesState(
            notes: state.notes,
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
        emit(NotesState(
            notes: state.notes,
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

  void _addTextFunction(event, emit) {
    emit(state.copyWith(
        textStatus: TextStatus.loading, notesStatus: NotesStatus.loading));
    List<SingleNote> notes = state.notes;
    List<List<TextComponent>> textComponents = state.currentNote.textComponents;
    if (textComponents.first.isEmpty && textComponents.length == 1) {
      textComponents = [[]];
    }
    try {
      while (textComponents.length <= state.currentTextCollectionIndex) {
        textComponents.add([]);
      }
      while (textComponents[state.currentTextCollectionIndex].length <=
          state.currentTextIndex) {
        textComponents[state.currentTextCollectionIndex].add(TextComponent());
        break;
      }
      textComponents[state.currentTextCollectionIndex][state.currentTextIndex] =
          textComponents[state.currentTextCollectionIndex]
                  [state.currentTextIndex]
              .copyWith(text: event.text, textId: state.currentTextIndex);
      notes[state.currentNoteIndex].textComponents = List.of(textComponents);
    } catch (e) {
      debugPrint("In the _addTextFunction function of NotesBloc, $e");
    }
    emit(state.copyWith(
        notes: notes,
        currentTextIndex:
            textComponents[state.currentTextCollectionIndex].length,
        textStatus: TextStatus.success,
        notesStatus: NotesStatus.success));
  }

  void _changeTextSelectionFunction(event, emit) {
    emit(state.copyWith(textStatus: TextStatus.loading));
    try {
      emit(state.copyWith(
          currentTextCollectionIndex: event.textCollectionIndex,
          currentTextIndex: event.textIndex,
          textStatus: TextStatus.success));
    } catch (e) {
      debugPrint("In function _changeTextSelectionFunction of NotesBloc, $e");
      emit(state.copyWith(textStatus: TextStatus.error));
    }
  }
}
