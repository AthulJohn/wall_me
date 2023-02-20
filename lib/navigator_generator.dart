import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wall_me/constants/routes.dart';
import 'package:wall_me/presentation/screens/display.dart';
import 'package:wall_me/presentation/screens/home_screen.dart';
import 'package:wall_me/presentation/screens/workshop.dart';

import 'presentation/screens/preview.dart';
import 'presentation/screens/selectUrl.dart';

abstract class CustomRouter {
  static GoRouter router = GoRouter(routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(child: HomeScreen()),
    ),
    GoRoute(
      path: workshopRoute,
      pageBuilder: (context, state) =>
          const MaterialPage(child: WorkshopScreen()),
      routes: [
        GoRoute(
          path: 'preview',
          pageBuilder: (context, state) =>
              const MaterialPage(child: PreviewScreen()),
        ),
        GoRoute(
          path: 'selectUrl',
          pageBuilder: (context, state) =>
              const MaterialPage(child: SelectUrlScreen()),
        ),
      ],
    ),
    GoRoute(
      path: siteRoute,
      builder: (context, state) => DisplayScreen(
        siteUrl: state.params['siteUrl'],
      ),
    ),
  ]);
}
