import 'dart:math';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Stt extends StatelessWidget {
  const Stt({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: SttPage(),
    );
  }
}

class SttPage extends StatefulWidget {
  const SttPage({Key? key}) : super(key: key);

  @override
  _SttPageState createState() => _SttPageState();
}

class _SttPageState extends State<SttPage> {
  bool _hasSpeech = false;
  final bool _logEvents = false;
  double level = 0.0;
  double minSoundLevel = 4000000000000000000000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  List<LocaleName> _localeNames = [];
  SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  Future<void> initSpeechState() async {
    // 초기화 코드 전달
    _logEvent('Initialize');
    // 초기화
    var hasSpeech = await speech.initialize(
      // 오류 발생기 호출되는 콜백함수지정
      onError: errorListener,
      //  음성 인식 엔진의 상태 변경 시 호출되는 콜백 함수를 지정
      onStatus: statusListener,
      // 디버그 로깅 활성화
      debugLogging: true,
      // 음성인식 종료시간설정. 여기서는 즉시 종료
      finalTimeout: const Duration(milliseconds: 0),
    );
    if (hasSpeech) {
      // 사용가능한 음성인식 목록을 가져와 할당
      _localeNames = await speech.locales();
      // 시스템의 기본언어설정을 가져와 _currentLocaleId에 할당
      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale?.localeId ?? '';
    } else {
      // 음성 인식 초기화에 실패한 경우 처리
      // 예: 사용자에게 알림을 표시하거나 대체 기능 제공
    }
// mounted는 불린속성= 위젯이 현재 "마운트"되어 있는지 여부
    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:

            ///여기부터 배경색 넣음
            Container(
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

          ///여기까지 배경색
          /// 여기부터 화면 출력임
          child: Column(children: [
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.only(top: 100.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            // color: Theme.of(context).selectedRowColor,
                            child: Center(
                              child: Text(
                                lastWords,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        onPressed: !_hasSpeech || speech.isListening
                            ? null
                            : () {
                                if (speech.isListening) {
                                  stopListening();
                                } else {
                                  startListening();
                                }
                              },
                        icon: Icon(
                          speech.isListening ? Icons.stop : Icons.mic,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 0.0),
                        child: Text(
                          speech.isListening
                              ? "마이크가 활성화되었습니다."
                              : lastStatus == "종료되었습니다"
                                  ? "마이크가 종료되었습니다."
                                  : "마이크를 눌러 명령하세요!",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

// 음성인식시작. 결과 나타날때 resultListener() 호출
  void startListening() {
    // _logEvent('start listening');
    lastWords = '';
    lastError = '';
    speech.listen(
        onResult: resultListener,
        // 음성인식 대기최대시간
        listenFor: const Duration(seconds: 30),
        // 인식도중 일시중지할떄의 시간
        pauseFor: const Duration(seconds: 20),
        // 중간결과 수신여부
        partialResults: true,
        // 인식언어 지정
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void resultListener(SpeechRecognitionResult result) {
    // _logEvent(
    //     'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      lastWords = result.recognizedWords.toLowerCase();

      // "종료" 단어가 인식되면 음성 인식을 종료
      if (result.finalResult) {
        if (lastWords.contains("종료")) {
          stopListening();
        }
      }
    });
  }

  void stopListening() {
    // _logEvent('stop listening');
    speech.stop();
    setState(() {});
  }

// 마이크 입력의 소리 레벨이 변경될 때 호출되는 콜백 함수로
// 소리 레벨을 모니터링하고 관련 정보를 업데이트하는 역할을 한다
  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }

//  음성 인식 중에 오류가 발생했을 때 호출되는 콜백 함수

  void errorListener(SpeechRecognitionError error) {
    // _logEvent(
    //     'Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    // _logEvent(
    //     'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = status;
    });
  }

// 말한 문자열을 출력 eventTime 은 햔재 시간을 ISO 8601 형식의 문자열로 변환하여 저장
// eventDescription은 매개변수값
  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      print('$eventTime $eventDescription');
    }
  }
}
