import 'package:arnitura_site/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'appBar.dart';

class PasswordReset extends StatelessWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeArnitura,
      home: PasswordResetPage(
        title: '',
      ),
    );
  }
}

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key, required this.title});

  final String title;

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {

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
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.35),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF4094D0)),
                  borderRadius: BorderRadius.circular(17)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                    child:
                        Text('Сброс пароля', style: theme.textTheme.titleLarge),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 80),
                            child: Text(
                              'Для сброса пароля введите адрес электронной почты.',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.labelMedium,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 80),
                          child: SizedBox(
                            height: 35,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Адрес электронной почты',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  clipBehavior: Clip.antiAlias,
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                    child: Text(
                                      'СБРОСИТЬ ПАРОЛЬ',
                                      style: theme.textTheme.labelLarge,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
