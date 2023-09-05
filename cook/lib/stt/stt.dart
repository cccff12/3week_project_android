import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

// 이 페이지는 거의 폐기
void main() {
  runApp(const Stt());
}

class Stt extends StatelessWidget {
  const Stt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speech to Text Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SttPage2(),
    );
  }
}

class SttPage2 extends StatefulWidget {
  const SttPage2({Key? key}) : super(key: key);

  @override
  _SttPageState createState() => _SttPageState();
}

class _SttPageState extends State<SttPage2> {
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;
  String _lastWords = '';
  String _lastError = '';

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  Future<void> initSpeechState() async {
    await _speech.initialize(
      onError: _errorListener,
      onStatus: _statusListener,
    );

    if (mounted) {
      setState(() {});
    }
  }

  void _startListening() {
    _speech.listen(
      onResult: _resultListener,
      cancelOnError: true,
    );

    setState(() {
      _isListening = true;
      _lastWords = '';
      _lastError = '';
    });
  }

  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  void _resultListener(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords.toLowerCase();
      if (result.finalResult) {
        if (_lastWords == "종료") {
          _stopListening(); // "종료" 명령을 들으면 음성 인식을 중단합니다.
        }
      }
    });
  }

  void _errorListener(SpeechRecognitionError error) {
    setState(() {
      _lastError = error.errorMsg;
    });
  }

  void _statusListener(String status) {
    print('Speech status: $status');
  }

  @override
  void dispose() {
    _speech.cancel();
    // _speech.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech to Text Example'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16),
            Text(
              _isListening ? 'Listening...' : 'Not listening',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(
              'Last words: $_lastWords',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(
              'Last error: $_lastError',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isListening ? null : _startListening,
              child: const Text('Start Listening'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isListening ? _stopListening : null,
              child: const Text('Stop Listening'),
            ),
          ],
        ),
      ),
    );
  }
}
