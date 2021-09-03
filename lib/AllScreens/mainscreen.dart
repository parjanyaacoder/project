import'package:flutter/material.dart';
// ignore: camel_case_types
class mainscreen extends StatefulWidget {
  static const String idScreen ="Main";

  _mainscreenState createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("mainScreen"),
      ),
    );
  }
}
