import 'package:cook/stt2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SttPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("앱 바 타이틀 . 물론 타이틀은 안넣을거다")),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 192, 203, 1),
              Color.fromRGBO(243, 243, 131, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  labelText: "레시피 제목을 입력해주세요",
                  labelStyle: TextStyle(fontSize: 20, color: Colors.amber),
                  hintText: "입력하세용"),
            ),
          ],
        ),
      ),
    );
  }
}
