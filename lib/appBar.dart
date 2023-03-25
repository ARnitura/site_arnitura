import 'package:arnitura_site/password_change.dart';
import 'package:arnitura_site/passwordreset.dart';
import 'package:arnitura_site/success_password_change.dart';
import 'package:arnitura_site/success_password_reset.dart';
import 'package:flutter/material.dart';

import 'globals.dart';

class appBarArnitura extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: const Image(
        image: AssetImage('assets/appbar/appbar_background.png'),
        fit: BoxFit.cover,
      ),
      centerTitle: true,
      actions: prefs.getBool('') == true ? <Widget>[
        Container(
          margin: EdgeInsets.only(right: 100),
          child: TextButton(
            child: const Text(
              'Войти',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w200,
                fontSize: 24,
                fontFamily: 'Roboto',
              ),
            ),
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordReset()));
            },
          ),
        ),
      ] : <Widget>[Container(
        margin: EdgeInsets.only(right: 30),
        child: TextButton(
          child: const Text(
            'Главная страница',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w100,
              fontSize: 24,
              fontFamily: 'Roboto',
            ),
          ),
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordReset()));
          },
        ),
      ),
        Container(
          margin: EdgeInsets.only(right: 100),
          child: TextButton(
            child: const Text(
              'Выйти',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
                fontSize: 24,
                fontFamily: 'Roboto',
              ),
            ),
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordReset()));
            },
          ),
        )
      ],
      leading: Container(
        margin: const EdgeInsets.only(left: 100),
        child: TextButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero)),
          onPressed: () {},
          child: Image.asset(
            'assets/appbar/logo_app_bar.png',
          ),
        ),
      ),
      leadingWidth: 220,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);}
