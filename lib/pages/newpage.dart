import 'package:flutter/material.dart';

class Newpage extends StatefulWidget {
  const Newpage({Key? key}) : super(key: key);
  static final String id = "newpage";

  @override
  _NewpageState createState() => _NewpageState();
}

class _NewpageState extends State<Newpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("New Page"),
      ),

    );
  }
}
