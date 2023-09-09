import 'package:cook/bagick/myappbar.dart';
import 'package:cook/bagick/mybackground.dart';
import 'package:cook/bagick/mytextfied.dart';
import 'package:flutter/material.dart';

class CookingUtensil extends StatefulWidget {
  const CookingUtensil({super.key});

  @override
  State<CookingUtensil> createState() => _CookingUtensilState();
}

class _CookingUtensilState extends State<CookingUtensil> {
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
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}