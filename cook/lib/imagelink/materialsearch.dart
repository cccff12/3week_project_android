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
                    ElevatedButton(
                      onPressed: () async {
                        DocumentSnapshot userDocument = await FirebaseFirestore
                            .instance
                            .collection('users')
                            .doc(user!.uid)
                            .get();
                        Map<String, dynamic>? userData =
                            userDocument.data() as Map<String, dynamic>?;

                        // 필드를 읽어오려면 필드 이름을 사용합니다.
                        if (userData != null) {
                          setState(() {
                            email = userData['email'];
                            name = userData['name'];
                            nickname = userData['nickname'];
                            password = userData['password'];
                            tel = userData['tel'];
                          });
                        }
                      },
                      child: const Text("데이터 가져오기"),
                    ),
                    // 데이터를 화면에 표시
                    if (email != null) Text('이메일: $email'),
                    if (name != null) Text('이름: $name'),
                    if (nickname != null) Text('닉네임: $nickname'),
                    if (password != null) Text('비밀번호: $password'),
                    if (tel != null) Text('전화번호: $tel'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
