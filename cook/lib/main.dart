import 'package:cook/bagick/myappbar.dart';
import 'package:cook/bagick/mybackground.dart';
import 'package:cook/imagelink/create_recipe.dart';
import 'package:cook/imagelink/materialsearch.dart';
import 'package:cook/page/login.dart';
import 'package:cook/main_drawer.dart';
import 'package:cook/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher_string.dart';

void main() async {
  // firebase와 연결
  WidgetsFlutterBinding.ensureInitialized();
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

  onButtonTap() async {
    launchUrlString("https://shopping.naver.com/home");
  }

  final PageController _pageController = PageController();
  final int _currentPage = 0;

  String banner_name = "여기에 firebase에서 레시피 제목 가져와 넣을거임";
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
        child: SingleChildScrollView(
          child: SizedBox(
            child: Container(
              decoration: myBackgroundColor(),
              child: Padding(
                // 왼 위 오 아래 순
                padding: const EdgeInsets.fromLTRB(50, 150, 50, 500),
                //   이걸로 전체를 묶어 스크롤로 만들려 했으나 화면 렌더링 오류가 남
                // child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        // myTextField(),
                        // 2개의 Row를 묶은 Column
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              // 사각형 앱 이미지들 Row로 2개씩 묶었음
                              child: Center(
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
                                              if (_authUser == null) {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) => Login(
                                                            updateAuthUser:
                                                                updateAuthUser)));
                                              } else {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CreateRecipe(
                                                      context,
                                                      authUser: _authUser,
                                                      updateAuthUser:
                                                          updateAuthUser,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Image.asset(
                                                'images/Group22.png'),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text("장바구니 작성하기"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
                                            onButtonTap();
                                          },
                                          child:
                                              Image.asset('images/Group24.png'),
                                        ),
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
                                            child: Image.asset(
                                                'images/Group23.png')),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text("장바구니 "
                                            "전체확인"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // 여기부터

                    // Expanded(
                    //   flex: 1,
                    //   child: Stack(
                    //     children: [
                    //       PageView(
                    //         controller: _pageController,
                    //         onPageChanged: (int page) {
                    //           setState(() {
                    //             _currentPage = page;
                    //           });
                    //         },
                    //         children: [
                    //           for (int i = 0; i < 10; i++)
                    //             buildBanner("Banner${i + 1}", i)
                    //         ],
                    //       ),
                    //       Align(
                    //         alignment: Alignment.bottomCenter,
                    //         child: Container(
                    //           margin: const EdgeInsets.symmetric(vertical: 8.0),
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               for (int i = 0; i < 10; i++)
                    //                 Container(
                    //                   margin: const EdgeInsets.all(4.0),
                    //                   width: 12.0,
                    //                   height: 12.0,
                    //                   decoration: BoxDecoration(
                    //                     shape: BoxShape.circle,
                    //                     color: _currentPage == i
                    //                         ? Colors.grey
                    //                         : Colors.grey.withOpacity(0.5),
                    //                   ),
                    //                 ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // ),
    );
  }

  Widget buildBanner(String? text, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20.0), // 원하는 둥근 정도를 설정합니다.
        // color: Colors.blueGrey,
      ),
      child: Center(child: Text(text!)),
    );
  }
}
