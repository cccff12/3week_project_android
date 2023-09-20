import 'package:cook/bagick/myappbar.dart';
import 'package:cook/bagick/mybackground.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({
    super.key,
    required this.authUser,
    required this.updateAuthUser,
  });

  final User? authUser;
  final Function(User? user) updateAuthUser;
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  // login된 사용자 정보를 firebaseAuth에게 요청해 _authUser에 담음
  final _authUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        decoration: myBackgroundColor(),
        child: Column(
          children: [
            SimpleDialog(
              title: const Text("마이페이지"),
              children: <Widget>[
                // Text("이메일 : ${_authUser?.email}"),
                // Text("uid : ${_authUser?.uid}"),
                // Text("displayname : ${_authUser?.displayName}"),
                // Text("마지막 로그인 : ${_authUser?.metadata.lastSignInTime}"),
                // Text("아이디 생성일 : ${_authUser?.metadata.creationTime}"),
                // Text("전화번호 : ${_authUser?.phoneNumber}"),
                // Text("사진 : ${_authUser?.photoURL}"),
                // const Text("여기부터 모든 정보"),
                Text("${_authUser!}")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
