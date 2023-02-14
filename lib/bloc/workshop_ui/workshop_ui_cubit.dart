import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'workshop_ui_state.dart';

class WorkshopUiCubit extends Cubit<WorkshopUiState> {
  WorkshopUiCubit() : super(const WorkshopUiState(true, true));
  void toggleOutline() {
    emit(WorkshopUiState(!state.isOutlineOpen, state.isTemplatesOpen));
  }

  void toggleTemplates() {
    emit(WorkshopUiState(state.isOutlineOpen, !state.isTemplatesOpen));
  }
}
