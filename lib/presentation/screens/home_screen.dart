import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wall_me/constants/routes.dart';
import 'package:wall_me/presentation/components/workshop/buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "WallMe",
                        style: TextStyle(
                            fontSize: 80, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 22),
                      const Text(
                        "Create your Webposter in seconds!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: CustomElevatedButton(
                          text: 'Go to Workshop',
                          icon: Icons.arrow_forward,
                          hasPadding: true,
                          onPressed: () {
                            context.go(workshopRoute);
                          },
                        ),
                      )
                    ]),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Image.asset("assets/images/homepage.jpg"),
            ),
          )
        ],
      ),
    );
  }
}
