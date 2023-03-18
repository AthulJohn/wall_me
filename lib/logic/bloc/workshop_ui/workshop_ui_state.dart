part of 'workshop_ui_cubit.dart';

enum ActiveComponent { text, image, template }

class WorkshopUiState extends Equatable {
  final bool isOutlineOpen,
      isTemplatesOpen,
      isTextEditOpen,
      isImageEditOpen,
      isBackground;
  final ActiveComponent activeComponent;
  const WorkshopUiState(
      {this.isOutlineOpen = true,
      this.isTemplatesOpen = true,
      this.isImageEditOpen = false,
      this.isTextEditOpen = false,
      this.isBackground = false,
      this.activeComponent = ActiveComponent.template});

  @override
  List<Object?> get props => [
        isOutlineOpen,
        isTemplatesOpen,
        isImageEditOpen,
        isTextEditOpen,
        activeComponent,
        isBackground
      ];

  WorkshopUiState copyWith({
    bool? isOutlineOpen,
    bool? isTemplatesOpen,
    bool? isTextEditOpen,
    bool? isImageEditOpen,
    bool? isBackground,
    ActiveComponent? activeComponent,
  }) {
    return WorkshopUiState(
      isOutlineOpen: isOutlineOpen ?? this.isOutlineOpen,
      isTemplatesOpen: isTemplatesOpen ?? this.isTemplatesOpen,
      isImageEditOpen: isImageEditOpen ?? this.isImageEditOpen,
      isTextEditOpen: isTextEditOpen ?? this.isTextEditOpen,
      activeComponent: activeComponent ?? this.activeComponent,
      isBackground: isBackground ?? this.isBackground,
    );
  }
}
