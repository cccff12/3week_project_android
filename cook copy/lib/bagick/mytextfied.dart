import 'package:flutter/material.dart';

Widget myTextField() {
  return TextField(
    decoration: InputDecoration(
      // textfiled 배경색 지정
      border: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Colors.white),
        borderRadius: BorderRadius.circular(25),
      ),
      filled: true,
      fillColor: Colors.white,
      labelText: "레시피 검색",
      labelStyle: const TextStyle(fontSize: 15, color: Colors.redAccent),
      hintText: "입력하세요 ㅠㅠㅠㅠㅠ",
    ),
  );
}
