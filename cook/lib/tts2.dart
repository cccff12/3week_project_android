import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

// 작동 잘 됨
class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  final FlutterTts tts = FlutterTts();
  final TextEditingController con = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 언어 설정
    tts.setLanguage("ko-KR");
    // 속도지정 (0.0이 제일 느리고 1.0이 제일 빠름)
    tts.setSpeechRate(0.5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Title"),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: con,
            ),
            TextButton(
              onPressed: () => tts.speak(con.text),
              child: const Text("재생버튼"),
            ),
          ],
        ),
      ),
    );
  }
}
