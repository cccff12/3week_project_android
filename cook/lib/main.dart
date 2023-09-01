import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
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
<<<<<<< HEAD
    return Scaffold(
      appBar: AppBar(title: const Text("앱 바 타이틀")),
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
                  hintText: "아잉"),
            ),
          ],
        ),
=======
    return const Scaffold(
      body: TextField(
        decoration: InputDecoration(
            labelText: "레시피 제목을 입력해주세요",
            labelStyle: TextStyle(fontSize: 20, color: Colors.amber),
            hintText: "아잉"),
>>>>>>> b7f80c5be55dd6c249dba87fc1c0aa40e4966a3a
      ),
    );
  }
}
