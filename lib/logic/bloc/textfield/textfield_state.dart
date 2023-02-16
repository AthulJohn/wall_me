part of 'textfield_cubit.dart';

class TextFieldState extends Equatable {
  const TextFieldState(this.textComponent);
  final TextComponent textComponent;

  @override
  List<Object> get props => [textComponent];

  TextEditingController getController() {
    return TextEditingController(text: textComponent.text);
  }
}

// class TextFieldInitial extends TextFieldState {}
