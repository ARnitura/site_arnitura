import 'package:flutter/material.dart';

class appBarArnitura extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Image(
        image: AssetImage('assets/appbar/appbar_background.png'),
        fit: BoxFit.cover,
      ),
      centerTitle: true,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {},
            child: Text(
              'Войти',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ),
      ],
      leading: Image.asset('assets/appbar/logo_app_bar.png'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);}
