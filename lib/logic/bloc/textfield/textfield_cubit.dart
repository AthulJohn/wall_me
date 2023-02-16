import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/workshop/text_component_model.dart';

part 'textfield_state.dart';

class TextFieldCubit extends Cubit<TextFieldState> {
  TextFieldCubit() : super(TextFieldState(TextComponent(text: '')));

  void changeText(String text) {
    emit(TextFieldState(state.textComponent.copyWith(text: text)));
  }

  void changeFont(String font) {
    emit(TextFieldState(state.textComponent.copyWith(fontFamily: font)));
  }

  void changeAlignment(TextAlign align) {
    emit(TextFieldState(state.textComponent.copyWith(textAlign: align)));
  }

  void changeBold(bool isBold) {
    emit(TextFieldState(state.textComponent.copyWith(isBold: isBold)));
  }

  void changeItalics(bool isItalics) {
    emit(TextFieldState(state.textComponent.copyWith(isItalic: isItalics)));
  }

  void changeUnderline(bool isUnderline) {
    emit(TextFieldState(
        state.textComponent.copyWith(isUnderlined: isUnderline)));
  }

  void changeColor(Color color) {
    emit(TextFieldState(state.textComponent.copyWith(fontColor: color)));
  }

  void changeSize(double size) {
    emit(TextFieldState(state.textComponent.copyWith(fontSize: size)));
  }

  void setTextComponent(TextComponent text) {
    print('setted to ${text.text}');
    emit(TextFieldState(text));
  }
}
