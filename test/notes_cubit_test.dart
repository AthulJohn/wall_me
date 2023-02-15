import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wall_me/logic/bloc/notes/notes_bloc.dart';

void main() {
  group('Notes Bloc', () {
    NotesBloc notesBloc = NotesBloc();
    setUp(() {
      notesBloc = NotesBloc();
    });

    tearDown(() {
      notesBloc.close();
    });

    test('Initial state', () {
      expect(
          notesBloc.state,
          const NotesState(
              notes: [],
              currentNoteIndex: 0,
              notesStatus: NotesStatus.initial,
              notesCount: 0));
    });

// Should be added
    // blocTest('Previous Page- non Starting ',
    //     build: () => notesBloc,
    //     act: (bloc) => bloc.add(PreviousPage()),
    //     expect: () => [const NotesState(
    //         notes: [],
    //         currentNoteIndex: 0,
    //         notesStatus: NotesStatus.initial,
    //         notesCount: 0)]);

    blocTest('Next Page- Starting',
        build: () => notesBloc,
        act: (bloc) => bloc.add(NextPage()),
        expect: () => [
              const NotesState(
                  notes: [],
                  currentNoteIndex: 0,
                  notesStatus: NotesStatus.initial,
                  notesCount: 0)
            ]);
  });
}
