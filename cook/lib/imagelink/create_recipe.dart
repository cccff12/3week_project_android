import 'package:cook/bagick/myappbar.dart';
import 'package:cook/bagick/mybackground.dart';
import 'package:cook/bagick/mytextfied.dart';
import 'package:flutter/material.dart';

class CreateRecipe extends StatefulWidget {
  const CreateRecipe({super.key});

  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: GestureDetector(
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
                    Form(
                        child: Column(
                      children: [
                        const Text("사진파일 넣을 곳"),
                        createRecipeInput(height: 50, hintText: "한마디"),
                        const SizedBox(
                          height: 10,
                        ),
                        createRecipeInput(height: 40, hintText: "소개글"),
                        const SizedBox(
                          height: 10,
                        ),
                        createRecipeInput(height: 150, hintText: "재료"),
                        const SizedBox(
                          height: 10,
                        ),
                        createRecipeInput(height: 150, hintText: "조리방법"),
                      ],
                    ))
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField createRecipeInput({String? hintText, required int height}) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: height.toDouble() ?? 0),
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
      ),
      textAlign: TextAlign.center,
    );
  }
}
