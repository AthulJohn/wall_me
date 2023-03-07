import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wall_me/constants/global_variables.dart';

import '../../data_providers/image_picker_provider.dart';
import '../../models/workshop/image_component_model.dart';
import '../../models/workshop/singlenote_model.dart';
import '../../models/workshop/text_component_model.dart';

part 'singlenote_event.dart';
part 'singlenote_state.dart';

class SinglenoteBloc extends Bloc<SinglenoteEvent, SinglenoteState> {
  SinglenoteBloc({SingleNote? note})
      : super(SinglenoteState(note ?? SingleNote())) {
    on<SetNote>(_setNoteFunction);
    on<AddImage>(_pickImageFunction);
    on<ChangeText>(_changeTextFunction);
    on<ChangeCurrentImage>(_changeCurrentImageFunction);
    on<ActivateBackgroundImagePanel>(_activateBackgroundImagePanelFunction);
    on<ChangeTextSelection>(_changeTextSelectionFunction);
    on<ChangeImageStyle>(_changeImageStyleFunction);
  }
  void _setNoteFunction(event, emit) async {
    emit(SinglenoteState(event.note));
  }

  void _pickImageFunction(event, emit) async {
    emit(state.copyWith(
        imageStatus: LoadingStatus.loading, currentImageIndex: event.index));
    try {
      XFile? image = await ImagePickerProvider.pickImage();
      if (image == null) {
        emit(state.copyWith(imageStatus: LoadingStatus.error));
        return;
      }
      emit(state.addImageToCurrentNote(
          imagePath: image.path, mimeType: image.mimeType ?? "image/jpeg"));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(imageStatus: LoadingStatus.error));
    }
  }

  void _changeCurrentImageFunction(event, emit) {
    emit(state.copyWith(
        imageStatus: LoadingStatus.success, currentImageIndex: event.index));
  }

  void _activateBackgroundImagePanelFunction(event, emit) {
    emit(state.addBackgroundImageToCurrentNote());
  }

  void _changeTextFunction(event, emit) {
    emit(state.copyWith(
      textStatus: LoadingStatus.loading,
    ));
    List<List<TextComponent>> textComponents = state.note
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
    } catch (e) {
      debugPrint("In the _changeTextFunction function of NotesBloc, $e");
    }
    emit(state.copyWith(
        note: state.note.copyWith(textComponents: List.of(textComponents)),
        currentTextIndex:
            textComponents[state.currentTextCollectionIndex].length,
        textStatus: LoadingStatus.success));
  }

  void _changeTextSelectionFunction(event, emit) {
    emit(state.copyWith(textStatus: LoadingStatus.loading));
    try {
      emit(state.copyWith(
          currentTextCollectionIndex: event.textCollectionIndex,
          currentTextIndex: event.textIndex,
          textStatus: LoadingStatus.success));
    } catch (e) {
      debugPrint("In function _changeTextSelectionFunction of NotesBloc, $e");
      emit(state.copyWith(textStatus: LoadingStatus.error));
    }
  }

  void _changeImageStyleFunction(event, emit) {
    emit(state.copyWith(imageStatus: LoadingStatus.loading));
    try {
      List<ImageComponent> imageComponents = state.note.imageComponents;
      imageComponents[state.currentImageIndex] = event.imageComponent;
      emit(state.copyWith(
          note: state.note.copyWith(imageComponents: List.of(imageComponents)),
          imageStatus: LoadingStatus.success));
    } catch (e) {
      debugPrint("In function _changeImageFitFunction of NotesBloc, $e");
      emit(state.copyWith(imageStatus: LoadingStatus.error));
    }
  }
}
