import 'package:flutter/material.dart';

BoxDecoration myBackgroundColor() {
  return const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromRGBO(255, 192, 203, 1),
        Color.fromRGBO(243, 243, 131, 1),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );
}
