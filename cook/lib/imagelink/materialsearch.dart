import 'package:flutter/material.dart';

class MaterialSearch extends StatefulWidget {
  const MaterialSearch({super.key});

  @override
  State<MaterialSearch> createState() => _MaterialSearchState();
}

class _MaterialSearchState extends State<MaterialSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("재료로검색"),
      ),
    );
  }
}
