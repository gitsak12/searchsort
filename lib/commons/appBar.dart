import 'package:flutter/material.dart';

AppBar appBar(String text) {
  return AppBar(
    backgroundColor: Colors.white,
    title: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
