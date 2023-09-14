import 'package:cook/bagick/myappbar.dart';
import 'package:cook/bagick/mybackground.dart';
import 'package:cook/bagick/mytextfied.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({
    super.key,
  });

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
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
            child: Column(
              children: [
                Column(
                  children: [
                    myTextField(),
                  ],
                ),
                // ListView.builder를 사용하여 레시피 데이터 리스트를 화면에 출력
                ListView.builder(
                  shrinkWrap: true, // 리스트 크기를 내용에 맞게 조절
                  itemBuilder: (context, index) {
                    return const ListTile();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
