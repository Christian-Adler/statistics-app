import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsCard({Key? key, required this.title, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}
