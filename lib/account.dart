import 'dart:convert';
import 'dart:math';

import 'package:arnitura_site/drawer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'appBar.dart';
import 'globals.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late Future signFuture;

  Future sign() async {
    var response = await post(Uri.parse('${url_server}api/auth_manufacturer'),
        body: {'login': prefs.getString('login'), 'password': prefs.getString('password')});
    if (response.statusCode == 200) {
      categoryList = jsonDecode(jsonDecode(response.body)['list_category']);
      typeList = jsonDecode(jsonDecode(response.body)['list_type']);
      prefs.setString('manufacturer', response.body);
      prefs.setBool('isAuth', true);
      return response.body;
    }
  }

  @override
  void initState() {
    super.initState();
    signFuture = sign();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      drawer: const DrawerProject(),
      appBar: appBarArnitura(),
      body: SingleChildScrollView(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              dynamic infoManufacturer = json.decode(snapshot.data);
              return Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    top: MediaQuery.of(context).size.height * 0.10,
                    right: MediaQuery.of(context).size.width * 0.05),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 75),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.1) - 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      child: Text('ИНН', style: theme.textTheme.titleSmall),
                                    ),
                                    SizedBox(
                                      height: 35,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 50),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      child: Text('Наименование организации или ИП', style: theme.textTheme.titleSmall),
                                    ),
                                    SizedBox(
                                      height: 35,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text('Адрес', style: theme.textTheme.titleSmall),
                          ),
                          SizedBox(
                            height: 35,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      child: Text('Руководитель', style: theme.textTheme.titleSmall),
                                    ),
                                    SizedBox(
                                      height: 35,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'ФИО',
                                          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.75)),
                                          border: const OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 50),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      child: Text('Должность', style: theme.textTheme.titleSmall),
                                    ),
                                    SizedBox(
                                      height: 35,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Директор',
                                          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.75)),
                                          border: const OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text('Контактное лицо', style: theme.textTheme.titleSmall),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 35,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Должность',
                                      hintStyle: TextStyle(color: Colors.grey.withOpacity(0.75)),
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 50),
                              Expanded(
                                child: SizedBox(
                                  height: 35,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'ФИО',
                                      hintStyle: TextStyle(color: Colors.grey.withOpacity(0.75)),
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 50),
                              Expanded(
                                child: SizedBox(
                                  height: 35,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Телефон',
                                      hintStyle: TextStyle(color: Colors.grey.withOpacity(0.75)),
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      child: Text('Email', style: theme.textTheme.titleSmall),
                                    ),
                                    SizedBox(
                                      height: 35,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 50),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      child: Text('Сайт', style: theme.textTheme.titleSmall),
                                    ),
                                    SizedBox(
                                      height: 35,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'https://',
                                          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.75)),
                                          border: const OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 50),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      child: Text('Торговая марка', style: theme.textTheme.titleSmall),
                                    ),
                                    SizedBox(
                                      height: 35,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          hintText: '',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 50),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      child: Text('Логотип', style: theme.textTheme.titleSmall),
                                    ),
                                    SizedBox(
                                      height: 35,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          hintText: '',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 40),
                            child: Divider(
                              color: const Color(0xFF000000).withOpacity(0.3),
                              height: 25,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     Container(
                          //       width: 300,
                          //       height: 120,
                          //       child: Column(
                          //         children: [
                          //           Padding(
                          //             padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          //             child: Text('Телефон', style: theme.textTheme.titleSmall),
                          //           ),
                          //           SizedBox(
                          //             height: 35,
                          //             child: TextFormField(
                          //               decoration: const InputDecoration(
                          //                 hintText: 'Менеджер',
                          //                 border: OutlineInputBorder(),
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //     Container(
                          //       width: 300,
                          //       height: 120,
                          //       child: Column(
                          //         children: [
                          //           Padding(
                          //             padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          //             child: Text('Телефон', style: theme.textTheme.titleSmall),
                          //           ),
                          //           SizedBox(
                          //             height: 35,
                          //             child: TextFormField(
                          //               decoration: const InputDecoration(
                          //                 hintText: 'Менеджер',
                          //                 border: OutlineInputBorder(),
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return const CircularProgressIndicator();
          },
          future: signFuture,
        ),
      ),
    );
  }
}