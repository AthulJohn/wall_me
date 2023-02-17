import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wall_me/constants/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
        child: Text('Workshop'),
        onPressed: () {
          context.go(workshopRoute);
        },
      )),
    );
  }
}
