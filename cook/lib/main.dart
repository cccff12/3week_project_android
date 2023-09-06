import 'package:cook/imagelink/category.dart';
import 'package:cook/imagelink/cooking_utensil.dart';
import 'package:cook/imagelink/create_recipe.dart';
import 'package:cook/imagelink/materialsearch.dart';
import 'package:cook/main_drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // routes: {"/category": (context) => const Category()},
      debugShowCheckedModeBanner: false,
      // home: SttPage3(),
      home: HomePage(),
      // home: TestView(),
      // home: SttPage(),
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
        // dawer 색 변경
        iconTheme: const IconThemeData(color: Colors.black),
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
                style: TextStyle(color: Colors.yellow, fontSize: 20),
              ),
              TextSpan(
                text: "를 시작해보세요",
                style: TextStyle(
                  fontSize: 20,
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
      drawer: maindrawer(context),
      // ******* textfield focus를 off하기 위해 body를 감쌌다
      // 문제 생기면 바로 지우자 *******
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
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
            padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
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
                        labelText: "레시피 검색",
                        labelStyle:
                            TextStyle(fontSize: 15, color: Colors.redAccent),
                        hintText: "입력하세요 ㅠㅠㅠㅠㅠ",
                      ),
                    ),
                    // 사각형 앱 이미지들
                    // Row로 2개씩 묶었음

                    Column(
                      children: [
                        const Padding(padding: EdgeInsets.all(10)),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(30),
                                child: Column(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Category()));
                                        },
                                        child:
                                            Image.asset('images/Group21.png')),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text("카테고리"),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(30),
                                child: Column(
                                  children: [
                                    // 아이콘 아래 2개
                                    InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CreateRecipe()));
                                        },
                                        child:
                                            Image.asset('images/Group22.png')),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text("레시피 작성"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 두번째로 Row로 사각형 앱 이미지 묶음
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(30),
                                child: Column(
                                  children: [
                                    // 아이콘 아래 2개
                                    InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CookingUtensil()));
                                        },
                                        child:
                                            Image.asset('images/Group24.png')),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text("요리기구"),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(30),
                                child: Column(
                                  children: [
                                    // 아이콘 아래 2개
                                    InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MaterialSearch()));
                                        },
                                        child:
                                            Image.asset('images/Group23.png')),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text("재료로 검색"),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
