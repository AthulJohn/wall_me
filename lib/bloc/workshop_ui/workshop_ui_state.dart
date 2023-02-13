part of 'workshop_ui_cubit.dart';

class WorkshopUiState extends Equatable {
  bool isOutlineOpen = true;
  bool isTemplatesOpen = true;
  WorkshopUiState(this.isOutlineOpen, this.isTemplatesOpen);

  @override
  // TODO: implement props
  List<Object?> get props => [isOutlineOpen, isTemplatesOpen];
}
