import 'package:flutter/material.dart';

PreferredSizeWidget MyAppBar() {
  return AppBar(
    // dawer 색 변경
    iconTheme: const IconThemeData(color: Colors.black),
    backgroundColor: const Color.fromARGB(255, 255, 192, 203),
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
  );
}
