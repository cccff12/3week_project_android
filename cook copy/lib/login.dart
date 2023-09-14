// ignore_for_file: use_build_context_synchronously

import 'package:cook/bagick/myappbar.dart';
import 'package:cook/bagick/mybackground.dart';
import 'package:cook/join.dart';
import 'package:cook/modules/input_form_field.dart';
import 'package:cook/modules/validate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
    User? authUser,
    required this.updateAuthUser,
  });

// required void Function(User? user) updateAuthUser 에서 required this.updateAuthUser 로 변경
// this의 똑같은 이름으로 받는다는 이야기

// state에게 전달하기 위해 선언
  final Function(User? user) updateAuthUser;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
// textformfield의 콘트롤러
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  // 콘트롤러
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

// input 박스에 입력해놓을 값을 임시로 저장하는 변수
  String _emailValue = "";
  String _passwordvalue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Form(
          key: _formKey,
          child: Container(
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
                          // focusNode: _emailFocus,
                          setValue: (value) => _emailValue = value,
                          validator: (value) => CheckValidate().emailCheck(
                              // value로 공급되는 변수가 null값이 될수 있기 때문에
                              // email: value! 에 ! 들어감
                              email: value!,
                              focusNode: _emailFocus),
                          hintText: "이메일을 입력해 주세요"),
                      const SizedBox(
                        height: 10,
                      ),
                      //  비밀번호 입력
                      inputFormField(
                          controller: _passwordController,
                          // focusNode: _passwordFocus,
                          setValue: (value) => _passwordvalue = value,
                          validator: (value) => CheckValidate().passwordCheck(
                              password: value!, focusNode: _passwordFocus),
                          hintText: "비밀번호를 입력해주세요"),
                      // 로그인 버튼
                      loginButton(context),
                      // 회원가입 버튼
                      joinButton()
                    ],
                  ),
                ),
              ],
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
          _formKey.currentState?.validate();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Join(updateAuthUser: widget.updateAuthUser),
            ),
          );
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

  Widget loginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 245, 206, 91),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        // 버튼을 누르면 textformfield의 validator실행
        onPressed: () async {
          _formKey.currentState?.validate();
          var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailValue,
            password: _passwordvalue,
          );
// context를 사용하여 현재 화면에 접근하고, result.user != null 조건을 검사
// null이 아니라면 true를 반환
          Navigator.pop(context, result.user != null);
          await widget.updateAuthUser(result.user);
          Navigator.pop(context);
        },
        child: const SizedBox(
          width: double.infinity,
          child: SizedBox(
            width: double.infinity,
            child: Text("로그인",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.black)),
          ),
        ),
      ),
    );
  }
}
