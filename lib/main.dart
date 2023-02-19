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
        textTheme: TextTheme(
          titleLarge: TextStyle(
              color: Color(0xFF4094D0),
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 34),
          titleSmall: TextStyle(
              color: Color(0xFF83868B), fontFamily: 'Roboto', fontSize: 16),
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
        flexibleSpace: Image(
          image: AssetImage('assets/appbar/appbar_backgraund.png'),
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
                style:
                TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
        ],
        leading: Image.asset('assets/appbar/logo_app_bar.png'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              // margin: EdgeInsets.symmetric(
              //     horizontal: MediaQuery.of(context).size.width * 0.3),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF4094D0)),
                  borderRadius: BorderRadius.circular(17)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child:
                        Text('Авторизация', style: theme.textTheme.titleLarge),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text('ИНН или адрес эл. почты',
                            style: theme.textTheme.titleSmall),
                      ),
                      SizedBox(
                        width: 453,
                        height: 35,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.4 / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child:
                              Text('Пароль', style: theme.textTheme.titleSmall),
                        ),
                        SizedBox(
                          width: 453,
                          height: 35,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
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
                            Text('Запомнить меня',
                                style: theme.textTheme.titleSmall)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          width: 216,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {},
                            clipBehavior: Clip.antiAlias,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              'ВОЙТИ',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          width: 216,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {},
                            clipBehavior: Clip.antiAlias,
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFDADADA),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              'ЗАРЕГИСТРИРОВАТЬСЯ',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF4094D0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Забыли пароль?',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4094D0)),
                    ),
                  )
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
