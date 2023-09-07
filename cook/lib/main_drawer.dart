import 'package:cook/login.dart';
import 'package:cook/mypage.dart';
import 'package:flutter/material.dart';

Widget maindrawer(BuildContext context) => Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(),
            accountName: Text("유저이름"),
            accountEmail: Text("유저 레벨"),
            // 이부분은 나중에 추가해야 함
          ),
          ListTile(
            title: const Text("마이페이지"),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MyPage()));
            },
          ),
          ListTile(
            title: const Text("로그인"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Login()));
            },
          ),
        ],
      ),
    );
