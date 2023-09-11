import 'package:cook/bagick/myappbar.dart';
import 'package:cook/bagick/mybackground.dart';
import 'package:cook/bagick/mytextfied.dart';
import 'package:cook/imagelink/category.dart';
import 'package:cook/imagelink/create_recipe.dart';
import 'package:cook/imagelink/materialsearch.dart';
import 'package:cook/main_drawer.dart';
import 'package:cook/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

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

  onButtonTap() async {
    launchUrlString(
        "https://msearch.shopping.naver.com/search/all?query=%EC%9A%94%EB%A6%AC%EA%B8%B0%EA%B5%AC");
  }

  final PageController _pageController = PageController();
  int _currentPage = 0;

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
        child: SizedBox(
          child: Container(
            decoration: myBackgroundColor(),
            child: Padding(
              // 왼 위 오 아래 순
              padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
              //   이걸로 전체를 묶어 스크롤로 만들려 했으나 화면 렌더링 오류가 남
              // child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      myTextField(),
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
                                        InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Category()));
                                            },
                                            child: Image.asset(
                                                'images/Group21.png')),
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
                                            child: Image.asset(
                                                'images/Group22.png')),
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
                                            // Navigator.of(context).push(
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             const CookingUtensil()));

                                            onButtonTap();
                                          },
                                          child: Image.asset(
                                              'images/Group24.png')),
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
                                      const Text("재료로 검색"),
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
                            for (int i = 0; i < 10; i++)
                              buildBanner("Banner${i + 1}", i)
                            // buildBanner('Banner 1', 0),
                            // buildBanner('Banner 2', 1),
                            // buildBanner('Banner 3', 2),
                            // buildBanner('Banner 4', 3),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0; i < 10; i++)
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
                ],
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
