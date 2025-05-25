import 'package:flutter/material.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() => DevicesStateScreen();
}

class DevicesStateScreen extends State<DevicesScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var children = [const SizedBox(height: 60), const Text("ПУПУ2")];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: children),
      ),
    );
  }
}
