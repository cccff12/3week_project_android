import 'package:cook/bagick/myappbar.dart';
import 'package:cook/bagick/mybackground.dart';
import 'package:cook/bagick/mytextfied.dart';
import 'package:cook/list_page.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({
    super.key,
  });

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String? meet = "고기";
  String noodle = "면";
  String snack = "안주";
  String soup = "국";
  String rice = "밥";
  String salad = "샐러드";
  String hangover = "해장";
  String pastfood = "패스트푸드";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          decoration: myBackgroundColor(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
            child: Column(children: [
              Column(
                children: [
                  myTextField(),
                  Column(
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 고기
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 80, 5, 30),
                              child: Container(
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListPage(category: meet)));
                                      },
                                      child: Stack(
                                        children: [
                                          Image.asset('images/Mask group1.png'),
                                          const Positioned(
                                              top: 20,
                                              right: 80,
                                              child: Text("고기",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22)))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // 국
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 80, 0, 30),
                              child: Container(
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListPage(category: soup)));
                                      },
                                      child: Stack(
                                        children: [
                                          Image.asset('images/Mask group2.png'),
                                          const Positioned(
                                              top: 20,
                                              right: 90,
                                              child: Text("국",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22)))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //  국
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 30, 5, 30),
                              child: Container(
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => ListPage(
                                                    category: noodle)));
                                      },
                                      child: Stack(
                                        children: [
                                          Image.asset('images/Mask group3.png'),
                                          const Positioned(
                                              top: 20,
                                              right: 90,
                                              child: Text("면",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 22)))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // 패스트푸드
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 30, 0, 30),
                              child: Container(
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => ListPage(
                                                    category: pastfood)));
                                      },
                                      child: Stack(
                                        children: [
                                          Image.asset('images/Mask group4.png'),
                                          const Positioned(
                                              top: 20,
                                              right: 30,
                                              child: Text("패스트푸드",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22)))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 밥
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 30, 5, 30),
                              child: Container(
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListPage(category: rice)));
                                      },
                                      child: Stack(
                                        children: [
                                          Image.asset('images/Mask group5.png'),
                                          const Positioned(
                                              top: 20,
                                              right: 90,
                                              child: Text("밥",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22)))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            //  안주
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 30, 0, 30),
                              child: Container(
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListPage(category: snack)));
                                      },
                                      child: Stack(
                                        children: [
                                          Image.asset('images/Mask group6.png'),
                                          const Positioned(
                                              top: 20,
                                              right: 80,
                                              child: Text("안주",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 22)))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //  샐러드
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 30, 5, 30),
                              child: Container(
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListPage(category: salad)));
                                      },
                                      child: Stack(
                                        children: [
                                          Image.asset('images/Mask group7.png'),
                                          const Positioned(
                                              top: 20,
                                              right: 80,
                                              child: Text("샐러드",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 5, 144, 236),
                                                      fontSize: 22)))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // 해장
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 30, 0, 30),
                              child: Container(
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => ListPage(
                                                    category: hangover)));
                                      },
                                      child: Stack(
                                        children: [
                                          Image.asset('images/Mask group8.png'),
                                          const Positioned(
                                              top: 20,
                                              right: 80,
                                              child: Text("해장",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22)))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
