import 'package:flutter/material.dart';

import 'globals.dart';

class appBarArnitura extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      flexibleSpace: const Image(
        image: AssetImage('assets/appbar/appbar_background.png'),
        fit: BoxFit.cover,
      ),
      centerTitle: true,
      actions: prefs.getBool('isAuth') == false || prefs.getBool('isAuth') == null
          ? <Widget>[
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
            ]
          : <Widget>[
              Container(
                margin: EdgeInsets.only(right: 20),
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
      title: SizedBox(
        width: 150,
        child: TextButton(
          style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
          onPressed: () {},
          child: Image.asset(
            'assets/appbar/logo_app_bar.png',
          ),
        ),
      ),
      leading: prefs.getBool('isAuth') == true ? GestureDetector(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
          child: Container(
        child: Image.asset('assets/appbar/menu.png'),
        margin: EdgeInsets.only(left: 50),
      )) : Container(),
      leadingWidth: 85,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
