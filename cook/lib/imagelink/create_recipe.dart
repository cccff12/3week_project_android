import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook/bagick/myappbar.dart';
import 'package:cook/bagick/mybackground.dart';
import 'package:cook/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateRecipe extends StatefulWidget {
  const CreateRecipe(BuildContext context,
      {super.key, User? authUser, required this.updateAuthUser});

  final Function(User? user) updateAuthUser;

  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  User? user = FirebaseAuth.instance.currentUser;

  final _categorycontroller = TextEditingController();
  final _onewordcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _categoryvalue = "";
  String _onewordvalue = "";

  void addDataToFirestore(String uid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference userCollection = firestore.collection('users');
    DocumentReference userDocument = userCollection.doc(user!.uid);
    CollectionReference recipeCollection = userDocument.collection('recipes');

    Map<String, dynamic> recipeData = {
      'category': _categoryvalue,
      'oneword': _onewordvalue,
      'uid': user!.uid,
    };

    recipeCollection.add(recipeData).then((value) {
      print("레시피 데이터가 성공적으로 추가되었습니다.");
    }).catchError((error) {
      print("레시피 데이터 추가 중 오류 발생: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        decoration: myBackgroundColor(),
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: SizedBox(
              height: 800,
              child: Center(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 30, 50, 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Form(
                              child: Column(
                                children: [
                                  createRecipeInput(
                                      controller: _categorycontroller,
                                      height: 20,
                                      hintText: "메뉴",
                                      setValue: (value) =>
                                          _categoryvalue = value),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  createRecipeInput(
                                      controller: _onewordcontroller,
                                      height: 150,
                                      hintText: "목록",
                                      setValue: (value) =>
                                          _onewordvalue = value),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        if (user != null) {
                                          addDataToFirestore(user!.uid);
                                        } else {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage(),
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        print("에러발생");
                                      }
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("저장"),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField createRecipeInput(
      {String? hintText,
      required int height,
      required TextEditingController controller,
      required Function(String) setValue}) {
    return TextFormField(
      keyboardType: TextInputType.text,
      onChanged: (value) => setValue(value),
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
