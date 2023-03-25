import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'appBar.dart';
import 'globals.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var loginController = TextEditingController();
  var passwordController = TextEditingController();
  bool _obscureText1 = true;
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarArnitura(),
      body: Container(),
    );
  }
}
