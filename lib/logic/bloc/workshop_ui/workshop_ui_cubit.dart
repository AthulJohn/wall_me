import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'workshop_ui_state.dart';

class WorkshopUiCubit extends Cubit<WorkshopUiState> {
  WorkshopUiCubit() : super(const WorkshopUiState());
  void toggleOutline() {
    emit(state.copyWith(isOutlineOpen: !state.isOutlineOpen));
  }

  void openActivePanel() {
    emit(state.copyWith(
        isTemplatesOpen: state.activeComponent == ActiveComponent.template,
        isTextEditOpen: state.activeComponent == ActiveComponent.text,
        isImageEditOpen: state.activeComponent == ActiveComponent.image));
  }

  void closeActivePanel() {
    emit(state.copyWith(
        isTemplatesOpen: false, isTextEditOpen: false, isImageEditOpen: false));
  }

  void activateImagePanel() {
    emit(state.copyWith(
        activeComponent: ActiveComponent.image,
        isImageEditOpen: true,
        isTemplatesOpen: false,
        isTextEditOpen: false));
  }

  void activateTextPanel() {
    emit(state.copyWith(
        activeComponent: ActiveComponent.text,
        isImageEditOpen: false,
        isTemplatesOpen: false,
        isTextEditOpen: true));
  }

  void activateTemplatePanel() {
    emit(state.copyWith(
        activeComponent: ActiveComponent.template,
        isImageEditOpen: false,
        isTemplatesOpen: true,
        isTextEditOpen: false));
  }

  void toggleTemplates() {
    emit(state.copyWith(
        isTemplatesOpen: !state.isTemplatesOpen,
        isTextEditOpen: false,
        isImageEditOpen: false));
  }

  void toggleTextEdit() {
    emit(state.copyWith(
        isTextEditOpen: !state.isTextEditOpen,
        isTemplatesOpen: false,
        isImageEditOpen: false));
  }

  void toggleImageEdit() {
    emit(state.copyWith(
        isImageEditOpen: !state.isImageEditOpen,
        isTemplatesOpen: false,
        isTextEditOpen: false));
  }
}
