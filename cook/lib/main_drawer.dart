import 'package:cook/page/login.dart';
import 'package:cook/page/mypage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget maindrawer(
  BuildContext context, {
  required void Function(User? user) updateAuthUser,
  User? authUser,
}) =>
    Drawer(
      child: FutureBuilder(
        future: getUserData(), // 사용자 데이터를 가져오는 비동기 함수를 호출합니다.
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          return ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName:
                    Text(snapshot.data?['nickname'] ?? "유저이름"), // 닉네임 또는 기본값 사용
                accountEmail:
                    Text(snapshot.data?['email'] ?? "이메일 주소"), // 이메일 또는 기본값 사용
              ),
              ListTile(
                title: const Text("마이페이지"),
                trailing: const Icon(Icons.person),
                onTap: () {
                  if (authUser != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MyPage(
                          authUser: authUser,
                          updateAuthUser: updateAuthUser,
                        ),
                      ),
                    );
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          Login(updateAuthUser: updateAuthUser),
                    ));
                  }
                },
              ),
              authUser != null
                  ? ListTile(
                      title: const Text("로그아웃"),
                      trailing: const Icon(Icons.exit_to_app),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        updateAuthUser(null);
                      },
                    )
                  : ListTile(
                      title: const Text("로그인"),
                      trailing: const Icon(Icons.login),
                      onTap: () async {
                        var result = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Login(
                              authUser: authUser,
                              updateAuthUser: updateAuthUser,
                            ),
                          ),
                        );
                      },
                    ),
            ],
          );
        },
      ),
    );

Future<Map<String, dynamic>?> getUserData() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    final userData = snapshot.data();
    return userData;
  }
  return null;
}
