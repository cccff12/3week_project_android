import 'package:flutter/material.dart';

Widget inputFormField({
  // required FocusNode focusNode,
  required TextEditingController controller,
  String? hintText,
  // 함수도 매개변수로 전달 받을 수 있음
  required Function(String) setValue,
  // 함수에 공급해주는 String, 위에서 매개변수로 넣을 값
  required Function(String?) validator,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      // validator : 입력값의 유효성 검사- 빈칸, 형식

      validator: (value) => validator(value),
      // onChanged : input box에 값을 입력 할 때 발생하는 함수
      onChanged: (value) => setValue(value),
      // focusNode: _emailFocus,
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
    ),
  );
}
