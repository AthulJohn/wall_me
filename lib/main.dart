import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wall_me/presentation/screens/workshop.dart';

import 'global_functions.dart';
import 'logic/bloc/notes/notes_bloc.dart';
import 'navigator_generator.dart';
import 'presentation/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    testInit();
    return BlocProvider<NotesBloc>(
      create: ((context) => NotesBloc()),
      child: MaterialApp.router(
        title: 'Wall.me',
        theme: ThemeData(
          fontFamily: 'Poppins',
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        routerConfig: CustomRouter.router,
      ),
    );
  }
}
