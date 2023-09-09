import 'package:flutter/material.dart';

class CheckValidate {
  String? emailCheck({
    required String email,
    required FocusNode focusNode,
  }) {
    if (email.isEmpty) {
      // requestFocus() : focus주기
      focusNode.requestFocus();
      return "이메일을 입력해주세요!";
    } else {
      const pattern =
          r"^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$";
      // pattern을 컴파일
      var regExp = RegExp(pattern);
      if (!regExp.hasMatch(email)) {
        focusNode.requestFocus();
        return "이메일 형식이 잘못되었습니다";
      }
    }

    return "";
  }

// FocusNode: 사용자의 포커스를 관리
  String passwordCheck({
    required String password,
    required FocusNode focusNode,
  }) {
    if (password.isEmpty) {
      focusNode.requestFocus();
      return "비밀번호를 입력해주세요!";
    } else {
      const pattern =
          r"^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$";
      var regExp = RegExp(pattern);
      if (!regExp.hasMatch(password)) {
        focusNode.requestFocus();
        return "숫자+문자+특수문자로 6~12자리로 입력";
      }
    }

    return "";
  }
}
