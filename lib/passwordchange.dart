import 'package:arnitura_site/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'appBar.dart';

class PasswordChange extends StatelessWidget {
  const PasswordChange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeArnitura,
      home: PasswordChangePage(
        title: '',
      ),
    );
  }
}

class PasswordChangePage extends StatefulWidget {
  const PasswordChangePage({super.key, required this.title});

  final String title;

  @override
  State<PasswordChangePage> createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  bool _obscureText1 = true;
  bool checkBoxValue = false;

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
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                    child:
                    Text('Смена пароля', style: theme.textTheme.titleLarge),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                            child: Text(
                              'Введите ваш новый пароль в поле ниже.',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.labelMedium,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child:
                          Text('Пароль', style: theme.textTheme.titleSmall),
                        ),
                        SizedBox(
                          height: 35,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText1 = !_obscureText1;
                                  });
                                },
                                child: Icon(_obscureText1
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined),
                              ),
                            ),
                            obscureText: _obscureText1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text('Подтвердите пароль',
                              style: theme.textTheme.titleSmall),
                        ),
                        SizedBox(
                          height: 35,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 40, 0, 60),
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
                                      'ОТПРАВИТЬ',
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
