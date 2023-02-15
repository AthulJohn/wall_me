import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'textfield_state.dart';

class TextFieldCubit extends Cubit<TextFieldState> {
  TextFieldCubit() : super(TextFieldState(''));

  void changeText(String text) {
    print("Changin test to $text");
    emit(TextFieldState(text));
  }
}
