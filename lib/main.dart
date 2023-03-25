import 'package:arnitura_site/globals.dart';
import 'package:arnitura_site/passwordreset.dart';
import 'package:arnitura_site/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'appBar.dart';
import 'package:http/http.dart';

import 'package:arnitura_site/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeArnitura,
      home: prefs.getBool('isRemember') == true ? DashboardPage() : SignPage(),
    );
  }
}

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  var loginController = TextEditingController();
  var passwordController = TextEditingController();
  bool isObscure = true;
  bool isRemember = false;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  void sign() async {
    var response =
        await post(Uri.parse('${url_server}api/auth_manufacturer'), body: {'login': loginController.text, 'password': passwordController.text});
    if (response.statusCode == 200) {
      prefs.setString('manufacturer', response.body);
      prefs.setBool('isAuth', true);
      prefs.setBool('isRemember', isRemember);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashboardPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: appBarArnitura(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.35),
              decoration: BoxDecoration(border: Border.all(color: const Color(0xFF4094D0)), borderRadius: BorderRadius.circular(17)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                    child: Text('Авторизация', style: theme.textTheme.titleLarge),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text('ИНН или адрес эл. почты', style: theme.textTheme.titleSmall),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextFormField(
                              controller: loginController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              style: const TextStyle(fontSize: 13)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Text('Пароль', style: theme.textTheme.titleSmall),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isObscure = !isObscure;
                                    });
                                  },
                                  child: Icon(isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                ),
                              ),
                              obscureText: isObscure,
                              style: const TextStyle(fontSize: 13)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Row(
                            children: [
                              Checkbox(
                                value: isRemember,
                                onChanged: (bool? value) {
                                  // This is where we update the state when the checkbox is tapped
                                  setState(() {
                                    isRemember = value!;
                                  });
                                },
                              ),
                              Text('Запомнить меня', style: theme.textTheme.titleSmall)
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  sign();
                                },
                                clipBehavior: Clip.antiAlias,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  'ВОЙТИ',
                                  style: TextStyle(fontSize: 13, fontFamily: "Roboto", fontWeight: FontWeight.w600, color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                clipBehavior: Clip.antiAlias,
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFFDADADA),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  'ЗАРЕГИСТРИРОВАТЬСЯ',
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 13, fontFamily: "Roboto", fontWeight: FontWeight.w600, color: Color(0xFF4094D0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 40),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PasswordResetPage()));
                            },
                            child: const Text(
                              'Забыли пароль?',
                              style: TextStyle(fontSize: 14, fontFamily: "Roboto", fontWeight: FontWeight.w600, color: Color(0xFF4094D0)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
