// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cook/bagick/myappbar.dart';
// import 'package:cook/bagick/mybackground.dart';
// import 'package:cook/bagick/mytextfied.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class MaterialSearch extends StatefulWidget {
//   const MaterialSearch({super.key});

//   @override
//   State<MaterialSearch> createState() => _MaterialSearchState();
// }

// class _MaterialSearchState extends State<MaterialSearch> {
//   User? user = FirebaseAuth.instance.currentUser;
//   String? email;
//   String? name;
//   String? nickname;
//   String? password;
//   String? tel;
//   List<String> categories = [];
//   List<String> cookingMethods = [];
//   List<String> introductions = [];
//   List<String> materials = [];
//   List<int> nums = [];
//   List<String> onewords = [];
//   List<String> uids = [];
//   bool dataVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(),
//       body: Container(
//         decoration: myBackgroundColor(),
//         child: SizedBox(
//           width: 1000,
//           height: 1000,
//           child: SingleChildScrollView(
//             child: GestureDetector(
//               onTap: () {
//                 FocusManager.instance.primaryFocus?.unfocus();
//               },
//               child: Container(
//                 // decoration: myBackgroundColor(),
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
//                   child: Column(
//                     children: [
//                       Column(
//                         children: [
//                           // myTextField(),
//                           ElevatedButton(
//                             onPressed: () {
//                               // 버튼을 누를 때마다 기존 데이터 초기화 및 데이터 표시 토글
//                               setState(() {
//                                 dataVisible = !dataVisible;
//                                 clearData();
//                               });

//                               if (dataVisible) {
//                                 // Firestore에서 데이터를 가져온 후 화면에 표시
//                                 fetchData();
//                               }
//                             },
//                             child: Text(dataVisible ? "데이터 숨기기" : "데이터 보이기"),
//                           ),
//                           // Firestore에서 가져온 데이터를 화면에 표시
//                           if (dataVisible) ...[
//                             if (email != null) Text('이메일: $email'),
//                             if (name != null) Text('이름: $name'),
//                             if (nickname != null) Text('닉네임: $nickname'),
//                             if (password != null) Text('비밀번호: $password'),
//                             if (tel != null) Text('전화번호: $tel'),
//                             for (int i = 0; i < categories.length; i++)
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   children: [
//                                     Text('카테고리: ${categories[i]}'),
//                                     Text('조리 방법: ${cookingMethods[i]}'),
//                                     Text('소개: ${introductions[i]}'),
//                                     Text('재료: ${materials[i]}'),
//                                     Text('숫자: ${nums[i]}'),
//                                     Text('한마디: ${onewords[i]}'),
//                                     Text('UID: ${uids[i]}'),
//                                   ],
//                                 ),
//                               ),
//                           ],
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // 데이터를 불러와 알림 대화상자를 표시하는 함수
//   Future<void> fetchData() async {
//     // Firestore에서 사용자 문서를 가져오기
//     DocumentSnapshot userDocument = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(user!.uid)
//         .get();
//     Map<String, dynamic>? userData =
//         userDocument.data() as Map<String, dynamic>?;

//     // "recipes" 컬렉션의 문서 가져오기
//     QuerySnapshot recipeDocuments = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(user!.uid)
//         .collection('recipes')
//         .get();

//     // 필요한 필드를 읽어오기
//     for (var doc in recipeDocuments.docs) {
//       categories.add(doc['category']);
//       cookingMethods.add(doc['cookingmethod']);
//       introductions.add(doc['introduction']);
//       materials.add(doc['material']);
//       nums.add(doc['num']);
//       onewords.add(doc['oneword']);
//       uids.add(doc['uid']);
//     }

//     // 데이터를 화면에 표시
//     setState(() {
//       email = userData?['email'];
//       name = userData?['name'];
//       nickname = userData?['nickname'];
//       password = userData?['password'];
//       tel = userData?['tel'];
//     });
//   }

//   // 데이터 초기화 함수
//   void clearData() {
//     email = null;
//     name = null;
//     nickname = null;
//     password = null;
//     tel = null;
//     categories.clear();
//     cookingMethods.clear();
//     introductions.clear();
//     materials.clear();
//     nums.clear();
//     onewords.clear();
//     uids.clear();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook/bagick/myappbar.dart';
import 'package:cook/bagick/mybackground.dart';
import 'package:cook/bagick/mytextfied.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MaterialSearch extends StatefulWidget {
  const MaterialSearch({super.key});

  @override
  State<MaterialSearch> createState() => _MaterialSearchState();
}

class _MaterialSearchState extends State<MaterialSearch> {
  User? user = FirebaseAuth.instance.currentUser;
  String? email;
  String? name;
  String? nickname;
  String? password;
  String? tel;
  List<String> categories = [];
  List<String> cookingMethods = [];
  List<String> introductions = [];
  List<String> materials = [];
  List<int> nums = [];
  List<String> onewords = [];
  List<String> uids = [];
  bool dataVisible = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        decoration: myBackgroundColor(),
        child: SizedBox(
          width: 1000,
          height: 1000,
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          // Firestore에서 가져온 데이터를 화면에 표시
                          if (dataVisible) ...[
                            if (email != null) Text('이메일: $email'),
                            if (name != null) Text('이름: $name'),
                            if (nickname != null) Text('닉네임: $nickname'),
                            if (password != null) Text('비밀번호: $password'),
                            if (tel != null) Text('전화번호: $tel'),
                            for (int i = 0; i < categories.length; i++)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text('카테고리: ${categories[i]}'),
                                    Text('조리 방법: ${cookingMethods[i]}'),
                                    Text('소개: ${introductions[i]}'),
                                    Text('재료: ${materials[i]}'),
                                    Text('숫자: ${nums[i]}'),
                                    Text('한마디: ${onewords[i]}'),
                                  ],
                                ),
                              ),
                          ],
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
    );
  }

  // 데이터를 불러와 화면에 표시하는 함수
  Future<void> fetchData() async {
    // Firestore에서 사용자 문서를 가져오기
    DocumentSnapshot userDocument = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    Map<String, dynamic>? userData =
        userDocument.data() as Map<String, dynamic>?;

    // "recipes" 컬렉션의 문서 가져오기
    QuerySnapshot recipeDocuments = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('recipes')
        .get();

    // 필요한 필드를 읽어오기
    for (var doc in recipeDocuments.docs) {
      categories.add(doc['category']);
      cookingMethods.add(doc['cookingmethod']);
      introductions.add(doc['introduction']);
      materials.add(doc['material']);
      nums.add(doc['num']);
      onewords.add(doc['oneword']);
    }

    // 데이터를 화면에 표시
    setState(() {
      email = userData?['email'];
      name = userData?['name'];
      nickname = userData?['nickname'];
      password = userData?['password'];
      tel = userData?['tel'];
    });
  }
}
