import 'package:flutter/material.dart';

Widget appbarTitle(String text){
  return Text(
    text,
    style: const TextStyle(
      fontFamily: 'Poppins-Black',
      fontWeight: FontWeight.w900,
      letterSpacing: 0.8,
      fontSize: 30.0,
    ),
  );
}