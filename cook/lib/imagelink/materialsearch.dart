import 'package:cook/bagick/myappbar.dart';
import 'package:cook/bagick/mybackground.dart';
import 'package:cook/bagick/mytextfied.dart';
import 'package:flutter/material.dart';
import 'package:cook/detail_page.dart';

class MaterialSearch extends StatefulWidget {
  const MaterialSearch({super.key});

  @override
  State<MaterialSearch> createState() => _MaterialSearchState();
}

class _MaterialSearchState extends State<MaterialSearch> {
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
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Detail()));
                      },
                      icon: const Icon(Icons.abc_sharp))
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
