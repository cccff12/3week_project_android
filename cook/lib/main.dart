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
      home: HomePage(),
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
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 192, 203, 1),
        title: Center(
          // 글자마다 색을 다르게 주기 위해 RichText를 사용했고
          //그 안에서 TextSpan을 2번 사용했다
          child: Container(
            // padding줬어야 했는데 Center안에 padding을 넣을 수 없어
            // Container로 묶고 그 안에 패딩을 줌
            padding: const EdgeInsets.only(right: 120),
            child: RichText(
                text: const TextSpan(children: [
              TextSpan(
                text: "요리",
                style: TextStyle(color: Colors.yellow, fontSize: 15),
              ),
              TextSpan(
                text: "를 시작해보세요",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ])),
          ),
        ),

        // app var그림자 진거 제거
        elevation: 0,
      ),
      // navigation 버튼
      drawer: Drawer(
        child: ListView(
          children: const [
            UserAccountsDrawerHeader(
              accountName: Text("유저이름"),
              accountEmail: Text("유저 레벨"),
              // 이부분은 나중에 추가해야 함
              currentAccountPicture: CircleAvatar(),
            )
          ],
        ),
      ),
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
        child: Padding(
          // 왼 위 오 아래 순
          padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
          child: Column(
            children: [
              Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      // textfiled 배경색 지정
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.white)),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "레시피 제목을 입력해주세요",
                      labelStyle: TextStyle(fontSize: 15, color: Colors.amber),
                      hintText: "입력하세용",
                    ),
                  ),

                  // 사각형 앱 이미지들
                  // Row로 2개씩 묶었음
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(30),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                // 아이콘 위에 2개
                                Image.asset('images/Group21.png'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(30),
                        child: Row(
                          children: [
                            // 아이콘 아래 2개
                            Image.asset('images/Group22.png'),
                          ],
                        ),
                      ),
                    ],
                  ),
// 두번째로 Row로 사각형 앱 이미지 묶음
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(30),
                        child: Row(
                          children: [
                            // 아이콘 아래 2개
                            Image.asset('images/Group23.png'),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(30),
                        child: Row(
                          children: [
                            // 아이콘 아래 2개
                            Image.asset('images/Group24.png'),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
