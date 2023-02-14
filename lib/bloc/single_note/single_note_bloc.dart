// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:wall_me/bloc/notes/notes_bloc.dart';
// import 'package:wall_me/models/workshop/singleNote_model.dart';

// import '../../data_providers/image_picker_provider.dart';

// part 'single_note_event.dart';
// part 'single_note_state.dart';

// class SingleNoteBloc extends Bloc<SingleNoteEvent, SingleNoteState> {
//   // final NotesBloc notesBloc;
//   // late StreamSubscription notesSubscription;
//   SingleNoteBloc() : super(SingleNoteState(note: SingleNote())) {
//     on<ChangePage>(_changePage);
//     on<UploadImage>(_pickImageFunction);
//     // notesSubscription = notesBloc.stream.listen((state) {
//     //   if (state is TodosLoadSuccess) {
//     //     add(TodosUpdated((todosBloc.state as TodosLoadSuccess).todos));
//     //   }  });
//   }

//   void _changePage(event, emit) {
//     emit(SingleNoteState(
//         note: event.note, singleNoteStatus: SingleNoteStatus.success));
//   }

//   void _pickImageFunction(event, emit) async {
//     emit(SingleNoteState(
//         note: state.note, singleNoteStatus: SingleNoteStatus.loading));
//     try {
//       String? imagePath = await ImagePickerProvider.pickImage();
//       if (imagePath == null) {
//         emit(SingleNoteState(
//             note: state.note, singleNoteStatus: SingleNoteStatus.error));
//         return;
//       }

//       emit(SingleNoteState(
//           note: state.note, singleNoteStatus: SingleNoteStatus.success)
//         ..note.addImage(imagePath));
//       print("Adding ${state.note.imageComponents.length} images");
//     } catch (e) {
//       debugPrint(e.toString());
//       emit(SingleNoteState(
//           note: state.note, singleNoteStatus: SingleNoteStatus.error));
//     }
//   }
// }
