part of 'textfield_cubit.dart';

class TextFieldState extends Equatable {
  const TextFieldState(this.text);
  final String text;

  @override
  List<Object> get props => [text];

  TextEditingController getController() {
    return TextEditingController(text: text);
  }
}

// class TextFieldInitial extends TextFieldState {}
