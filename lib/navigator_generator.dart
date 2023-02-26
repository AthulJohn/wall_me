import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wall_me/constants/routes.dart';
import 'package:wall_me/logic/bloc/notes/notes_bloc.dart';
import 'package:wall_me/presentation/screens/home_screen.dart';
import 'package:wall_me/presentation/screens/workshop.dart';

import 'logic/bloc/site_data/sitedata_cubit.dart';
import 'logic/bloc/textfield/textfield_cubit.dart';
import 'presentation/screens/preview.dart';
import 'presentation/screens/selectUrl.dart';

abstract class CustomRouter {
  static final NotesBloc _notesBloc = NotesBloc();
  static GoRouter router = GoRouter(routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(child: HomeScreen()),
    ),
    GoRoute(
      path: workshopRoute,
      pageBuilder: (context, state) => MaterialPage(
          child: BlocProvider.value(
        value: _notesBloc,
        child: const WorkshopScreen(),
      )),
      routes: [
        GoRoute(
          path: 'preview',
          pageBuilder: (context, state) => MaterialPage(
              child: BlocProvider.value(
                  value: _notesBloc, child: const PreviewScreen())),
        ),
        GoRoute(
          path: 'selectUrl',
          builder: (context, state) => MultiBlocProvider(providers: [
            BlocProvider.value(
              value: _notesBloc,
            ),
            BlocProvider(create: (context) => TextFieldCubit()),
            BlocProvider(create: (context) => SitedataCubit()),
          ], child: const SelectUrlScreen()),
        ),
      ],
    ),
  ]);
}
