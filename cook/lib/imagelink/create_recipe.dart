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

User? user = FirebaseAuth.instance.currentUser;

class _CreateRecipeState extends State<CreateRecipe> {
  // 콘트롤러
  final _onewordcontroller = TextEditingController();
  final _introductioncontroller = TextEditingController();
  final _materialcontroller = TextEditingController();
  final _cookingmethodcontroller = TextEditingController();

  // 키
  final _formKey = GlobalKey<FormState>();

// input 박스에 입력해놓을 값을 임시로 저장하는 변수

  String _onewordvalue = "";
  String _introductionvalue = "";
  String _materialvalue = "";
  String _cookingmethodvalue = "";

  void addDataToFirestore(String uid) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference userCollection = firestore.collection('users');

    Map<String, dynamic> userData = {};

    // 사용자 컬렉션 내에 필드를 추가합니다.
    userCollection.doc(uid).set(userData).then((value) {
      print("데이터가 성공적으로 추가되었습니다.");

      // 사용자 컬렉션 내에 서브컬렉션을 추가합니다.
      CollectionReference recipeCollection =
          userCollection.doc(uid).collection('recipes');

      // _cookingmethodvalue를 필드로 추가합니다.
      Map<String, dynamic> recipeData = {
        'uid': user!.uid,
        'cookingmethod': _cookingmethodvalue,
        'oneword': _onewordvalue,
        'introduction': _introductionvalue,
        'material': _materialvalue,
      };

      recipeCollection.add(recipeData).then((value) {
        print("레시피 데이터가 성공적으로 추가되었습니다.");
      }).catchError((error) {
        print("레시피 데이터 추가 중 오류 발생: $error");
      });
    }).catchError((error) {
      print("데이터 추가 중 오류 발생: $error");
    });
  }

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
                    // myTextField(),
                    Form(
                        child: Column(
                      children: [
                        const Text("사진파일 넣을 곳"),
                        createRecipeInput(
                            controller: _onewordcontroller,
                            height: 50,
                            hintText: "한마디",
                            setValue: (value) => _onewordvalue = value),
                        const SizedBox(
                          height: 10,
                        ),
                        createRecipeInput(
                            controller: _introductioncontroller,
                            height: 40,
                            hintText: "소개글",
                            setValue: (value) => _introductionvalue = value),
                        const SizedBox(
                          height: 10,
                        ),
                        createRecipeInput(
                            controller: _materialcontroller,
                            height: 150,
                            hintText: "재료",
                            setValue: (value) => _materialvalue = value),
                        const SizedBox(
                          height: 10,
                        ),
                        createRecipeInput(
                            controller: _cookingmethodcontroller,
                            height: 300,
                            hintText: "조리방법",
                            setValue: (value) => _cookingmethodvalue = value),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              if (user != null) {
                                addDataToFirestore(
                                    user!.uid); // 데이터를 Firestore에 추가
                                FirebaseFirestore.instance
                                    .collection("recipe")
                                    .doc();
                              } else {
                                // 사용자가 로그인되어 있지 않은 경우 처리
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ));
                              }
                            } catch (e) {
                              print("에러발생");
                            }
                          },
                          child: const Text("저장"),
                        )
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

// 입력창
  TextFormField createRecipeInput(
      {String? hintText,
      required int height,
      required TextEditingController controller,
      required Function(String) setValue}) {
    return TextFormField(
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
