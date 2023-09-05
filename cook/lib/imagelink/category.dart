import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text("카테고리 페이지"),
      appBar: AppBar(
        title: const Text("카테고리"),
      ),
    );
  }
}
