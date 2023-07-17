import 'package:arnitura_site/drawer.dart';
import 'package:flutter/material.dart';

import 'appBar.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      drawer: const DrawerProject(),
      appBar: appBarArnitura(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.height * 0.10,
              right: MediaQuery.of(context).size.width * 0.05),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.1) - 250,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text('Телефон', style: theme.textTheme.titleSmall),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text('+1 (234) 567 89 01', style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text('Свяжитесь с нами через мессенджер', style: theme.textTheme.titleSmall),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: Image.asset('assets/icons/Telegram.png'),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: Image.asset('assets/icons/Viber.png'),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: Image.asset('assets/icons/WhatsApp.png'),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text('Свяжитесь с нами по электронной почте', style: theme.textTheme.titleSmall),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: SelectableText('pochta@arnitura.com', style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Divider(
                      color: const Color(0xFF000000).withOpacity(0.3),
                      height: 25,
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text('Тема', style: theme.textTheme.titleSmall),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text('Сообщение', style: theme.textTheme.titleSmall),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.topLeft,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => US_Support(),
                          //   ),
                          // );
                        },
                        clipBehavior: Clip.antiAlias,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4094D0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: const Text(
                            'ОТПРАВИТЬ',
                            style: TextStyle(fontSize: 16, fontFamily: "Roboto", fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
