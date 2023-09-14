// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook/bagick/myappbar.dart';
import 'package:cook/bagick/mybackground.dart';
import 'package:cook/page/login.dart';
import 'package:cook/modules/input_form_field.dart';
import 'package:cook/modules/validate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Join extends StatefulWidget {
  const Join({
    super.key,
    User? authUser,
    required this.updateAuthUser,
  });

// required void Function(User? user) updateAuthUser 에서 required this.updateAuthUser 로 변경
// this의 똑같은 이름으로 받는다는 이야기

// state에게 전달하기 위해 선언
  final Function(User? user) updateAuthUser;

  @override
  State<Join> createState() => _LoginState();
}

class _LoginState extends State<Join> {
// textformfield의 콘트롤러
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _nameFocus = FocusNode();
  final _phonenumberFocus = FocusNode();
  final _nicknameFocus = FocusNode();

  // 콘트롤러
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _nameController = TextEditingController();

  // 키
  final _formKey = GlobalKey<FormState>();

// input 박스에 입력해놓을 값을 임시로 저장하는 변수
  String _emailValue = "";
  String _passwordvalue = "";
  String _namevalue = "";
  String _phonenumbervalue = "";
  String _nicknamevalue = "";

  String? currentUserUid;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              height: double.infinity,
              // ignore: avoid_overflow
              decoration: myBackgroundColor(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
                    child: Column(
                      children: [
                        // 이메일 입력
                        inputFormField(
                          controller: _emailController,
                          setValue: (value) => _emailValue = value,
                          hintText: "이메일을 입력해 주세요",
                          validator: (value) => CheckValidate().emailCheck(
                              email: _emailValue, focusNode: _emailFocus),
                        ),
                        //  비밀번호 입력
                        inputFormField(
                            controller: _passwordController,
                            setValue: (value) => _passwordvalue = value,
                            validator: (value) => CheckValidate().passwordCheck(
                                password: _passwordvalue,
                                focusNode: _passwordFocus),
                            hintText: "비밀번호를 입력해주세요"),
                        inputFormField(
                            controller: _phonenumberController,
                            setValue: (value) => _phonenumbervalue = value,
                            validator: (value) => CheckValidate().phoneCheck(
                                phonenum: _phonenumbervalue,
                                focusNode: _phonenumberFocus),
                            hintText: "전화번호를 입력해 주세요"),
                        inputFormField(
                            controller: _nicknameController,
                            setValue: (value) => _nicknamevalue = value,
                            validator: (value) => null,
                            hintText: "닉네임을 입력해 주세요"),
                        inputFormField(
                            controller: _nameController,
                            setValue: (value) => _namevalue = value,
                            validator: (value) => null,
                            hintText: "이름을 입력해 주세요"),

                        // 회원가입 버튼
                        const SizedBox(
                          height: 180,
                        ),
                        joinButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget joinButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 42, 222, 235),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        // 버튼을 누르면 textformfield의 validator실행
        onPressed: () async {
          // _formKey.currentState?.validate();
          final isValid = _formKey.currentState?.validate();
          if (isValid == true) {
            try {
              var result =
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _emailValue,
                password: _passwordvalue,
              );

              widget.updateAuthUser(result.user);

              if (result.user != null) {
                // firebaseStore에
                await FirebaseFirestore.instance
                    // user 라는 컬렉션을 만들고
                    .collection("users")
                    // document는  uid로 만들어라
                    .doc(result.user!.uid)
                    .set({
                  // "email": result.user!.email,
                  "email": _emailValue,
                  "password": _passwordvalue,
                  "name": _namevalue,
                  "tel": _phonenumbervalue,
                  "nickname": _nicknamevalue,
                });
              }
              Navigator.pop(context, result.user != null);
              await widget.updateAuthUser(result.user);
              Navigator.pop(context);
              // 로그아웃 시키고
              await FirebaseAuth.instance.signOut();
              // 로그인페이지로 이동
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      Login(updateAuthUser: widget.updateAuthUser)));
              // 다른 회원정보는 fireStore에 저장해야한다.
              // 나중에 Dto만들어서 변경

              // firebase에서 에러나면 snackbar로 보여주는 것
            } on FirebaseException catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.message!),
                ),
              );
            }
          }
        },
        child: const SizedBox(
          width: double.infinity,
          child: SizedBox(
            width: double.infinity,
            child: Text("회원가입",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.black)),
          ),
        ),
      ),
    );
  }
}
