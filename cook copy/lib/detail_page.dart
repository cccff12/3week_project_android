import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook/bagick/myappbar.dart';
import 'package:cook/bagick/mybackground.dart';
import 'package:cook/bagick/mytextfied.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({
    super.key,
  });

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  User? user = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> recipeList = []; // 레시피 데이터를 저장할 리스트

  // initState에서 데이터 가져오기
  @override
  void initState() {
    super.initState();
    takerecipe();
  }

  void takerecipe() async {
    if (user == null) {
      print('User is not logged in.');
      return;
    }

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference userCollection = firestore.collection('users');
    DocumentReference userDocument = userCollection.doc(user!.uid);
    CollectionReference recipeCollection = userDocument.collection('recipes');

    try {
      QuerySnapshot recipeQuery = await recipeCollection.get();

      for (var recipeDoc in recipeQuery.docs) {
        Map<String, dynamic> recipe = recipeDoc.data() as Map<String, dynamic>;
        // 레시피 정보를 사용하거나 출력할 수 있습니다.
        print('Recipe Name: ${recipe['name']}');
        print('Recipe Description: ${recipe['nicname']}');
        // 필요한 작업 수행
      }
    } catch (e) {
      print('Error fetching recipes: $e');
    }
  }

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
                  itemCount: recipeList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Recipe Name: ${recipeList[index]['name']}'),
                      subtitle: Text(
                          'Recipe Description: ${recipeList[index]['nickname']}'),
                    );
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
