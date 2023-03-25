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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarArnitura(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      dashboardSection = 0;
                      setState(() {});
                    },
                    clipBehavior: Clip.antiAlias,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        backgroundColor: dashboardSection == 0 ? Color(0xff4094D0) : Color(0xffEDEDED)),
                    child: Text(
                      'УЧЕТНАЯ ЗАПИСЬ',
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                          color: dashboardSection == 0 ? Colors.white : Color(0xff4094D0)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      dashboardSection = 1;
                      setState(() {});
                    },
                    clipBehavior: Clip.antiAlias,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        backgroundColor: dashboardSection == 1 ? Color(0xff4094D0) : Color(0xffEDEDED)),
                    child: Text(
                      'ТОВАРЫ',
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                          color: dashboardSection == 1 ? Colors.white : Color(0xff4094D0)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      dashboardSection = 2;
                      setState(() {});
                    },
                    clipBehavior: Clip.antiAlias,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        backgroundColor: dashboardSection == 2 ? Color(0xff4094D0) : Color(0xffEDEDED)),
                    child: Text(
                      'МАТЕРИАЛЫ',
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                          color: dashboardSection == 2 ? Colors.white : Color(0xff4094D0)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      dashboardSection = 3;
                      setState(() {});
                    },
                    clipBehavior: Clip.antiAlias,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        backgroundColor: dashboardSection == 3 ? Color(0xff4094D0) : Color(0xffEDEDED)),
                    child: Text(
                      'ПОДДЕРЖКА',
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                          color: dashboardSection == 3 ? Colors.white : Color(0xff4094D0)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
