import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wall_me/logic/models/workshop/image_component_model.dart';
import 'package:wall_me/logic/models/workshop/text_component_model.dart';

import '../../data_providers/image_picker_provider.dart';
import '../../models/workshop/singlenote_model.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(const NotesState()) {
    on<AddNotes>(_addNotesFunction);
    on<SetTemplate>(_setNoteTemplate);
    on<NextPage>(_nextPageFunction);
    on<PreviousPage>(_previousPageFunction);
    on<GoToPage>(_goToPageFunction);
    on<AddImage>(_pickImageFunction);
    on<ChangeText>(_changeTextFunction);
    on<ChangeCurrentImage>(_changeCurrentImageFunction);
    on<ChangeTextSelection>(_changeTextSelectionFunction);
    on<ChangeImageStyle>(_changeImageStyleFunction);
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
        // notesCount: notes.length
      ));
    } catch (e) {
      debugPrint("In function _addNotesFunction of NotesBloc, $e");
      emit(state.copyWith(notesStatus: NotesStatus.error));
    }
  }

  void _setNoteTemplate(event, emit) {
    emit(state.copyWith(notesStatus: NotesStatus.loading));
    try {
      //CAll the API here
      List<SingleNote> notes = state.notes;
      if (notes.isEmpty) {
        notes = [
          SingleNote(templateId: event.templateIndex, noteid: notes.length)
        ];
      } else {
        notes[state.currentNoteIndex] = SingleNote(
            templateId: event.templateIndex, noteid: state.currentNoteIndex);
      }
      emit(state.copyWith(notesStatus: NotesStatus.success, notes: notes));
    } catch (e) {
      debugPrint("In function _addNotesFunction of NotesBloc, $e");
      emit(state.copyWith(notesStatus: NotesStatus.error));
    }
  }

  void _nextPageFunction(event, emit) {
    emit(state.copyWith(notesStatus: NotesStatus.loading));
    try {
      if (state.currentNoteIndex < state.notes.length - 1) {
        int nextTextIndex = 0;
        if (state.notes[state.currentNoteIndex + 1].textComponents.isNotEmpty) {
          nextTextIndex = state
              .notes[state.currentNoteIndex + 1].textComponents.first.length;
        }
        emit(NotesState(
            notes: state.notes,
            notesStatus: NotesStatus.success,
            currentNoteIndex: state.currentNoteIndex + 1,
            currentTextCollectionIndex: 0,
            currentTextIndex: nextTextIndex));
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
      int nextTextIndex = 0;
      if (state.notes[state.currentNoteIndex - 1].textComponents.isNotEmpty) {
        nextTextIndex =
            state.notes[state.currentNoteIndex - 1].textComponents.first.length;
      }
      if (state.currentNoteIndex > 0) {
        emit(NotesState(
            notes: state.notes,
            currentNoteIndex: state.currentNoteIndex - 1,
            notesStatus: NotesStatus.success,
            currentTextCollectionIndex: 0,
            currentTextIndex: nextTextIndex));
      }
    } catch (e) {
      debugPrint("In function _previousPageFunction of NotesBloc, $e");
      emit(state.copyWith(notesStatus: NotesStatus.error));
    }
  }

  void _goToPageFunction(event, emit) {
    emit(state.copyWith(notesStatus: NotesStatus.loading));
    try {
      int nextTextIndex = 0;
      if (state.notes[event.index].textComponents.isNotEmpty) {
        nextTextIndex = state.notes[event.index].textComponents.first.length;
      }
      if (event.index < state.notes.length) {
        emit(state.copyWith(
          currentNoteIndex: event.index,
          currentTextCollectionIndex: 0,
          currentTextIndex: nextTextIndex,
          notesStatus: NotesStatus.success,
        ));
      }
    } catch (e) {
      debugPrint("In function _gotoPageFunction of NotesBloc, $e");
      emit(state.copyWith(notesStatus: NotesStatus.error));
    }
  }

  void _pickImageFunction(event, emit) async {
    emit(state.copyWith(
        notesStatus: NotesStatus.loading, currentImageIndex: event.index));
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

  void _changeCurrentImageFunction(event, emit) {
    emit(state.copyWith(
        notesStatus: NotesStatus.success, currentImageIndex: event.index));
  }

  void _changeTextFunction(event, emit) {
    emit(state.copyWith(
        textStatus: TextStatus.loading, notesStatus: NotesStatus.loading));
    List<SingleNote> notes = state.notes;
    List<List<TextComponent>> textComponents = state.currentNote!
        .textComponents; // Current Note should not be null as it is called from a note itself
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
          event.textComponent;
      notes[state.currentNoteIndex].textComponents = List.of(textComponents);
    } catch (e) {
      debugPrint("In the _changeTextFunction function of NotesBloc, $e");
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

  void _changeImageStyleFunction(event, emit) {
    emit(state.copyWith(notesStatus: NotesStatus.loading));
    List<SingleNote> notes = state.notes;
    try {
      List<ImageComponent> imageComponents = state.currentNote!.imageComponents;
      imageComponents[state.currentImageIndex] = event.imageComponent;
      notes[state.currentNoteIndex].imageComponents = List.of(imageComponents);
      emit(state.copyWith(notes: notes, notesStatus: NotesStatus.success));
    } catch (e) {
      debugPrint("In function _changeImageFitFunction of NotesBloc, $e");
      emit(state.copyWith(notesStatus: NotesStatus.error));
    }
  }
}
