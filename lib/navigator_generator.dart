import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wall_me/constants/routes.dart';
import 'package:wall_me/presentation/screens/display.dart';
import 'package:wall_me/presentation/screens/home_screen.dart';
import 'package:wall_me/presentation/screens/workshop.dart';

abstract class CustomRouter {
  static GoRouter router = GoRouter(routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => MaterialPage(child: const HomeScreen()),
    ),
    GoRoute(
      path: workshopRoute,
      pageBuilder: (context, state) =>
          MaterialPage(child: const WorkshopScreen()),
    ),
    GoRoute(
      path: previewRoute,
      pageBuilder: (context, state) =>
          MaterialPage(child: const DisplayScreen()),
    ),
  ]);
}
