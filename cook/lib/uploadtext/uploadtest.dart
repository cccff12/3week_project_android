import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref("test/text");
  ref.putString("Hello World !!");

  runApp(const Aaaa());
}

class Aaaa extends StatelessWidget {
  const Aaaa({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Aaaa(),
    );
  }
}

class Sdasd extends StatefulWidget {
  const Sdasd({super.key});

  @override
  State<Sdasd> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Sdasd> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
