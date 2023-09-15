import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook/bagick/myappbar.dart';
import 'package:cook/bagick/mybackground.dart';
import 'package:cook/bagick/mytextfied.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  ListPage({
    Key? key,
    this.category,
  }) : super(key: key);
  String? category;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  User? user = FirebaseAuth.instance.currentUser;

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
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(user!.uid)
                        .collection('recipes')
                        .where('category', isEqualTo: widget.category)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }

                      // 데이터가 있는 경우
                      var recipes = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: recipes.length,
                        itemBuilder: (context, index) {
                          var recipeData =
                              recipes[index].data() as Map<String, dynamic>;

                          // 원하는 방식으로 레시피 정보를 표시
                          return ListTile(
                            onTap: () {},
                            title:
                                Text('Recipe Name: ${recipeData['category']}'),
                            subtitle: Text(
                                'Recipe Description: ${recipeData['introduction']}'),
                            // 필요한 다른 위젯 추가
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
