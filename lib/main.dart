import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Color(0xFF4094D0), fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 34),
          titleSmall: TextStyle(color: Color(0xFF83868B), fontFamily: 'Roboto', fontSize: 16),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _obscureText1 = true;
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const Image(
          image: AssetImage('assets/appbar/appbar_background.png'),
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        actions: <Widget>[
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
              onPressed: () {},
            ),
          ),
        ],
        leading: Container(
          margin: const EdgeInsets.only(left: 100),
          child: TextButton(
            style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
            onPressed: () {},
            child: Image.asset(
              'assets/appbar/logo_app_bar.png',
            ),
          ),
        ),
        leadingWidth: 220,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.25),
              decoration: BoxDecoration(border: Border.all(color: const Color(0xFF4094D0)), borderRadius: BorderRadius.circular(17)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
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
                          height: 35,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Text('Пароль', style: theme.textTheme.titleSmall),
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
                                child: Icon(_obscureText1 ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                              ),
                            ),
                            obscureText: _obscureText1,
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: checkBoxValue,
                              onChanged: (bool? value) {
                                // This is where we update the state when the checkbox is tapped
                                setState(() {
                                  checkBoxValue = value!;
                                });
                              },
                            ),
                            Text('Запомнить меня', style: theme.textTheme.titleSmall)
                          ],
                        ),
                        Row(
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
                                child: const Text(
                                  'ВОЙТИ',
                                  style: TextStyle(fontSize: 16, fontFamily: "Roboto", fontWeight: FontWeight.w600, color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
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
                                  style: TextStyle(fontSize: 16, fontFamily: "Roboto", fontWeight: FontWeight.w600, color: Color(0xFF4094D0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Забыли пароль?',
                          style: TextStyle(fontSize: 14, fontFamily: "Roboto", fontWeight: FontWeight.w600, color: Color(0xFF4094D0)),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp2()));
      //   },
      //   tooltip: 'Increment',s
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
