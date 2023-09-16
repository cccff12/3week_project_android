// // import 'package:cook/page/login.dart';
// // import 'package:cook/page/mypage.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';

// // User? user = FirebaseAuth.instance.currentUser;
// // Widget maindrawer(
// //   BuildContext context, {
// //   required void Function(User? user) updateAuthUser,
// //   User? authUser,
// // }) =>
// //     Drawer(
// //       child: ListView(
// //         children: [
// //           const UserAccountsDrawerHeader(
// // // 나중에 db에서 가져와야 함
// //             accountName: Text("유저이름"),
// // // 레벨은 아마 폐기
// //             accountEmail: Text("유저 레벨"),
// //             // 이부분은 나중에 추가해야 함
// //           ),
// //           // 마이페이지
// //           ListTile(
// //             title: const Text("마이페이지"),
// //             trailing: const Icon(Icons.person),
// //             onTap: () {
// //               if (AuthUser().user != null) {
// //                 Navigator.of(context).push(
// //                   MaterialPageRoute(
// //                       builder: (context) => MyPage(
// //                             authUser: authUser,
// //                             updateAuthUser: updateAuthUser,
// //                           )),
// //                 );
// //               } else {
// //                 Navigator.of(context).push(MaterialPageRoute(
// //                     builder: (context) =>
// //                         Login(updateAuthUser: updateAuthUser)));
// //               }
// //             },
// //           ),
// //           // 현재 firebase에서 로그인 되어 있으면 로그아웃 , 없으면 로그인 보이기
// //           AuthUser().user != null
// //               // 로그아웃
// //               ? ListTile(
// //                   title: const Text("로그아웃"),
// //                   trailing: const Icon(Icons.exit_to_app),
// //                   onTap: () async {
// //                     await FirebaseAuth.instance.signOut();
// //                     // state 변경함수를 전달해 화면 변경
// //                     updateAuthUser(null);
// //                   },
// //                 )
// //               // 로그인
// //               : ListTile(
// //                   title: const Text("로그인"),
// //                   trailing: const Icon(Icons.login),
// //                   onTap: () async {
// //                     var result = await Navigator.of(context).push(
// //                       MaterialPageRoute(
// //                         builder: (context) => Login(
// //                           authUser: authUser,
// //                           updateAuthUser: updateAuthUser,
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 )
// //         ],
// //       ),
// //     );

// // // 현재 firebase정보 가져온거
// // class AuthUser {
// //   var user = FirebaseAuth.instance.currentUser;
// // }
// import 'package:cook/page/login.dart';
// import 'package:cook/page/mypage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// Widget maindrawer(
//   BuildContext context, {
//   required void Function(User? user) updateAuthUser,
//   User? authUser,
// }) =>
//     Drawer(
//       child: FutureBuilder(
//         future: getUserNickname(), // 닉네임 가져오는 비동기 함수를 호출합니다.
//         builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
//           return ListView(
//             children: [
//               UserAccountsDrawerHeader(
//                 accountEmail: Text(snapshot.data ?? "로긍니해주세요"),
//                 accountName: Text(snapshot.data ?? "로그인해주세요"), // 닉네임 또는 기본값 사용
//               ),
//               ListTile(
//                 title: const Text("마이페이지"),
//                 trailing: const Icon(Icons.person),
//                 onTap: () {
//                   if (authUser != null) {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => MyPage(
//                           authUser: authUser,
//                           updateAuthUser: updateAuthUser,
//                         ),
//                       ),
//                     );
//                   } else {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) =>
//                           Login(updateAuthUser: updateAuthUser),
//                     ));
//                   }
//                 },
//               ),
//               authUser != null
//                   ? ListTile(
//                       title: const Text("로그아웃"),
//                       trailing: const Icon(Icons.exit_to_app),
//                       onTap: () async {
//                         await FirebaseAuth.instance.signOut();
//                         updateAuthUser(null);
//                       },
//                     )
//                   : ListTile(
//                       title: const Text("로그인"),
//                       trailing: const Icon(Icons.login),
//                       onTap: () async {
//                         var result = await Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => Login(
//                               authUser: authUser,
//                               updateAuthUser: updateAuthUser,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//             ],
//           );
//         },
//       ),
//     );

// Future<String?> getUserNickname() async {
//   final user = FirebaseAuth.instance.currentUser;
//   if (user != null) {
//     final snapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(user.uid)
//         .get();
//     final nickname = snapshot.get('nickname') as String?;

//     return nickname;
//   }
//   return null;
// }

// Future<String?> getUserEmail() async {
//   final user = FirebaseAuth.instance.currentUser;
//   if (user != null) {
//     final snapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(user.uid)
//         .get();

//     final email = snapshot.get('email') as String?;
//     return email;
//   }
//   return null;
// }
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
