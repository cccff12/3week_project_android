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
  // 콘트롤러
  final _onewordcontroller = TextEditingController();
  final _introductioncontroller = TextEditingController();
  final _materialcontroller = TextEditingController();
  final _cookingmethodcontroller = TextEditingController();

  // 키
  final _formKey = GlobalKey<FormState>();

// 레시피 번호를 저장할 변수
  int recipenum = 1;

// input 박스에 입력해놓을 값을 임시로 저장하는 변수
  String _onewordvalue = "";
  String _introductionvalue = "";
  String _materialvalue = "";
  String _cookingmethodvalue = "";

  void addDataToFirestore(String uid) async {
    //   프로젝트와 연결된 Firestore 인스턴스를 가져오는 역할
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // 사용자 컬렉션안에
    CollectionReference userCollection = firestore.collection('users');

    // 사용자 문서를 참조해서
    DocumentReference userDocument = userCollection.doc(user!.uid);
    // 레시피 컬렉션을 사용자 문서 내에 추가
    CollectionReference recipeCollection = userDocument.collection('recipes');

    // 입력값을 필드에 추가
    Map<String, dynamic> recipeData = {
      'num': recipenum,
      'uid': user!.uid,
      'cookingmethod': _cookingmethodvalue,
      'oneword': _onewordvalue,
      'introduction': _introductionvalue,
      'material': _materialvalue,
    };

    // 레시피 문서를 레시피 컬렉션 내에 추가합니다.
    recipeCollection.add(recipeData).then((value) {
      print("레시피 데이터가 성공적으로 추가되었습니다.");
    }).catchError((error) {
      print("레시피 데이터 추가 중 오류 발생: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    recipenum = recipenum;
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
                                // Navigator.of(context).pop();
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

void plud() {}
