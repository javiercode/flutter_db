import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'pages/detalle.dart';
import 'pages/acerca.dart';
import 'pages/home.dart';
import 'pages/menu.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nombres de bebes',
      home: MyMainPage(),
    );
  }
}