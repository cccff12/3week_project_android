import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Mobile App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white, // 기본 색상
          )),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  PageView(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: [
                      buildBanner('Banner 1', 0),
                      buildBanner('Banner 2', 1),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 2; i++)
                            Container(
                              margin: const EdgeInsets.all(4.0),
                              width: 12.0,
                              height: 12.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == i
                                    ? Colors.grey
                                    : Colors.grey.withOpacity(0.5),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              flex: 4,
              child: Column(
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBanner(String text, int index) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // 원하는 둥근 정도를 설정합니다.
          border: const Border.fromBorderSide(BorderSide(width: 1))),
      child: Center(child: Text(text)),
    );
  }
}
