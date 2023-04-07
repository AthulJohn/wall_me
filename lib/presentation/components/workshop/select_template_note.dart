import 'package:flutter/material.dart';
import 'package:wall_me/presentation/components/workshop/template_panel/template_card.dart';

class SelectTemplateNote extends StatelessWidget {
  const SelectTemplateNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Select a template to get started...",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        FractionallySizedBox(
          widthFactor: 0.5,
          child: Row(
            children: const [
              Expanded(
                child: TemplateCard(
                  templateSet: 1,
                  templateIndex: 1,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: TemplateCard(
                  templateSet: 1,
                  templateIndex: 2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        FractionallySizedBox(
          widthFactor: 0.5,
          child: Row(
            children: const [
              Expanded(
                child: TemplateCard(
                  templateSet: 1,
                  templateIndex: 3,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: TemplateCard(
                  templateSet: 1,
                  templateIndex: 4,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
