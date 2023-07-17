import 'dart:convert';
import 'dart:math';

import 'package:arnitura_site/account.dart';
import 'package:arnitura_site/feedback.dart';
import 'package:arnitura_site/materials.dart';
import 'package:arnitura_site/products.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'appBar.dart';
import 'globals.dart';

class DrawerProject extends StatefulWidget {
  const DrawerProject({super.key});

  @override
  State<DrawerProject> createState() => _DrawerProjectState();
}

class _DrawerProjectState extends State<DrawerProject> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/icons/back.png',
                  height: 25,
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
          ),
          SizedBox(height: 15),
          Column(
            children: [
              SizedBox(
                width: 175,
                child: ElevatedButton(
                  onPressed: () {
                    if (dashboardSection != 0) {
                      dashboardSection = 0;
                      prefs.setInt('dashboardSection', 0);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AccountPage()));
                    }
                  },
                  clipBehavior: Clip.antiAlias,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      backgroundColor: dashboardSection == 0 ? const Color(0xff4094D0) : const Color(0xffEDEDED)),
                  child: Text(
                    'УЧЕТНАЯ ЗАПИСЬ',
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                        color: dashboardSection == 0 ? Colors.white : const Color(0xff4094D0)),
                  ),
                ),
              ),
              Container(
                width: 175,
                margin: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () {
                    if (dashboardSection != 1) {
                      dashboardSection = 1;
                      prefs.setInt('dashboardSection', 1);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProductsPage()));
                    }
                  },
                  clipBehavior: Clip.antiAlias,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      backgroundColor: dashboardSection == 1 ? const Color(0xff4094D0) : const Color(0xffEDEDED)),
                  child: Text(
                    'ТОВАРЫ',
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                        color: dashboardSection == 1 ? Colors.white : const Color(0xff4094D0)),
                  ),
                ),
              ),
              Container(
                width: 175,
                margin: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () {
                    if (dashboardSection != 2) {
                      dashboardSection = 2;
                      prefs.setInt('dashboardSection', 2);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MaterialsPage()));
                    }
                  },
                  clipBehavior: Clip.antiAlias,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      backgroundColor: dashboardSection == 2 ? const Color(0xff4094D0) : const Color(0xffEDEDED)),
                  child: Text(
                    'МАТЕРИАЛЫ',
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                        color: dashboardSection == 2 ? Colors.white : const Color(0xff4094D0)),
                  ),
                ),
              ),
              Container(
                width: 175,
                margin: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () {
                    if (dashboardSection != 3) {
                      dashboardSection = 3;
                      prefs.setInt('dashboardSection', 3);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FeedbackPage()));
                    }
                  },
                  clipBehavior: Clip.antiAlias,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      backgroundColor: dashboardSection == 3 ? const Color(0xff4094D0) : const Color(0xffEDEDED)),
                  child: Text(
                    'ПОДДЕРЖКА',
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                        color: dashboardSection == 3 ? Colors.white : const Color(0xff4094D0)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
