// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wall_me/bloc/workshop_ui/workshop_ui_cubit.dart';

import 'package:wall_me/main.dart';

void main() {
  group('Workshop UI', () {
    WorkshopUiCubit workshopUiCubit = WorkshopUiCubit();
    setUp(() {
      workshopUiCubit = WorkshopUiCubit();
    });

    tearDown(() {
      workshopUiCubit.close();
    });

    test('Initial state', () {
      expect(workshopUiCubit.state, WorkshopUiState(true, true));
    });

    blocTest('Toggling Notes Outline Panel',
        build: () => workshopUiCubit,
        act: (cubit) => cubit.toggleOutline(),
        expect: () => [WorkshopUiState(false, true)]);

    blocTest('Toggling Templates Panel',
        build: () => workshopUiCubit,
        act: (cubit) => cubit.toggleTemplates(),
        expect: () => [WorkshopUiState(true, false)]);
  });
}
