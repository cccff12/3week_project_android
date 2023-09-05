import 'package:flutter/material.dart';

class CookingUtensil extends StatefulWidget {
  const CookingUtensil({super.key});

  @override
  State<CookingUtensil> createState() => _CookingUtensilState();
}

class _CookingUtensilState extends State<CookingUtensil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("요리기구"),
      ),
    );
  }
}
