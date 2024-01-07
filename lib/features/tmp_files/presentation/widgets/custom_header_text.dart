import 'package:flutter/material.dart';

Widget buildHeaderText({
  String? text,
}) {
  return Text(
    text!,
    style: const TextStyle(
      fontSize: 44,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w900,
      color: Colors.white,
    ),
  );
}
