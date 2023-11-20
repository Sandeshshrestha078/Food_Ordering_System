import 'package:flutter/material.dart';

//Style
const headerStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
const titleStyle = TextStyle(
  color: Color.fromRGBO(255, 255, 255, 1),
  fontSize: 18,
  fontWeight: FontWeight.w200,
);
const titleStyle2 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
const chooseimg = TextStyle(fontSize: 14, color: Colors.blue);

const categoryPadding = EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0);

//Decoration
const categorieStyle = BoxDecoration(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15), topRight: Radius.circular(15)),
    color: Color.fromRGBO(26, 112, 223, 1));

//button
final buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color.fromRGBO(26, 112, 223, 1),
    minimumSize: const Size(120, 40));

//upate page title style
const updatestyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.indigo);

const updateRowStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w300);
