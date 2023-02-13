import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'workshop_ui_state.dart';

class WorkshopUiCubit extends Cubit<WorkshopUiState> {
  WorkshopUiCubit() : super(WorkshopUiState(true, true));
  void toggleOutline() {
    emit(WorkshopUiState(!state.isOutlineOpen, state.isTemplatesOpen));
  }

  void toggleTemplates() {
    emit(WorkshopUiState(state.isOutlineOpen, !state.isTemplatesOpen));
  }
}
