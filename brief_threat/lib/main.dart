import 'package:flutter/material.dart';
import 'package:brief_threat/Screens/LoginScreen.dart';
import 'package:brief_threat/Theme/colors.dart';

void main() {
  runApp(MaterialApp(
      title: 'Form app',
      home: LoginScreen(),
      theme : buildTheme()
    ));
}