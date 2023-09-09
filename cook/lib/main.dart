import 'package:cook/bagick/myappbar.dart';
import 'package:cook/bagick/mybackground.dart';
import 'package:cook/bagick/mytextfied.dart';
import 'package:cook/imagelink/category.dart';
import 'package:cook/imagelink/cooking_utensil.dart';
import 'package:cook/imagelink/create_recipe.dart';
import 'package:cook/imagelink/materialsearch.dart';
import 'package:cook/main_drawer.dart';
import 'package:cook/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // firebase와 연결
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
  late User? _authUser;

// widget 초기화
  @override
  void initState() {
    super.initState();
    // login된 사용자 정보를 firebaseAuth에게 요청해 _authUser에 담음
    _authUser = FirebaseAuth.instance.currentUser;
  }

// state는 직접 전달할 수 없고 변경함수는 전달할 수 있다
// 그러므로 변경함수를 전달한다
  void updateAuthUser(User? user) {
    setState(() {
      _authUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      // navigation 버튼
      drawer: maindrawer(
        context,
        authUser: _authUser,
        updateAuthUser: updateAuthUser,
      ),
      // ******* textfield focus를 off하기 위해 body를 감쌌다
      // 문제 생기면 바로 지우자 *******
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          decoration: myBackgroundColor(),
          child: Padding(
            // 왼 위 오 아래 순
            padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
            child: Column(
              children: [
                Column(
                  children: [
                    myTextField(),
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
