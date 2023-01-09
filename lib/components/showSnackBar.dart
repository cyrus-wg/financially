import 'package:flutter/material.dart';

SnackBar showSnackBar(String msg) {
  return SnackBar(
    content: Text(
      msg,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Colors.pink,
    duration: const Duration(seconds: 1),
  );
}
