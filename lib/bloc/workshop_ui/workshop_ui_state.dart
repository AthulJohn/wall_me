part of 'workshop_ui_cubit.dart';

class WorkshopUiState extends Equatable {
  final bool isOutlineOpen;
  final bool isTemplatesOpen;
  const WorkshopUiState(this.isOutlineOpen, this.isTemplatesOpen);

  @override
  List<Object?> get props => [isOutlineOpen, isTemplatesOpen];
}
