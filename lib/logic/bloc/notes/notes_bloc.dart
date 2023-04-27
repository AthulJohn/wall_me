import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wall_me/constants/global_variables.dart';
import 'package:wall_me/logic/bloc/singlenote/singlenote_bloc.dart';
import 'package:wall_me/logic/bloc/workshop_ui/workshop_ui_cubit.dart';
import 'package:wall_me/logic/models/workshop/image_component_model.dart';
import 'package:wall_me/logic/models/workshop/text_component_model.dart';

import '../../data_providers/image_picker_provider.dart';
import '../../models/workshop/singlenote_model.dart';
import '../textfield/textfield_cubit.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(const NotesState()) {
    on<AddNotes>(_addNotesFunction);
    on<SetSingleNote>(_setSingleNoteFunction);
    on<SetTemplate>(_setNoteTemplate);
    on<NextPage>(_nextPageFunction);
    on<PreviousPage>(_previousPageFunction);
    on<GoToPage>(_goToPageFunction);
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

  void _setSingleNoteFunction(SetSingleNote event, emit) {
    emit(state.copyWith(notesStatus: NotesStatus.loading));
    try {
      if (event.note.noteid < state.notes.length) {
        List<SingleNote> notes = state.notes;
        notes[event.note.noteid] = event.note;
        emit(NotesState(
          notesStatus: NotesStatus.success,
          notes: notes,
          currentNoteIndex: event.note.noteid,
        ));
      } else {
        emit(const NotesState(
          notesStatus: NotesStatus.success,
        ));
      }
    } catch (e) {
      debugPrint("In function _setSingleNoteFunction of NotesBloc, $e");
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

      event.singlenoteBloc.add(SetNote(state.currentNote ?? SingleNote()));
    } catch (e) {
      debugPrint("In function _addNotesFunction of NotesBloc, $e");
      emit(state.copyWith(notesStatus: NotesStatus.error));
    }
  }

  void _nextPageFunction(NextPage event, emit) {
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
        ));
      } else {
        add(AddNotes());
      }
      event.singlenoteBloc.add(SetNote(state.currentNote ?? SingleNote()));
      event.textFieldCubit.setTextComponent(TextComponent());
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
          notesStatus: NotesStatus.success,
        ));
        event.singlenoteBloc.add(SetNote(state.currentNote ?? SingleNote()));

        event.textFieldCubit.setTextComponent(TextComponent());
      }
    } catch (e) {
      debugPrint("In function _previousPageFunction of NotesBloc, $e");
      emit(state.copyWith(notesStatus: NotesStatus.error));
    }
  }

  void _goToPageFunction(GoToPage event, emit) {
    emit(state.copyWith(notesStatus: NotesStatus.loading));
    try {
      if (event.index < state.notes.length) {
        emit(state.copyWith(
          currentNoteIndex: event.index,
          notesStatus: NotesStatus.success,
        ));
        event.singlenoteBloc.add(SetNote(state.currentNote ?? SingleNote()));
        event.textFieldCubit.setTextComponent(TextComponent());
        if (state.currentNote == null || state.currentNote!.templateId == -1) {
          event.workshopUiCubit.activateTemplatePanel();
        }
      }
    } catch (e) {
      debugPrint("In function _gotoPageFunction of NotesBloc, $e");
      emit(state.copyWith(notesStatus: NotesStatus.error));
    }
  }
}
