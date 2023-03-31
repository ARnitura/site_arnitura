import 'dart:math';

import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'appBar.dart';
import 'globals.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: appBarArnitura(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, top: MediaQuery.of(context).size.height * 0.10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 175,
                    child: ElevatedButton(
                      onPressed: () {
                        dashboardSection = 0;
                        setState(() {});
                      },
                      clipBehavior: Clip.antiAlias,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                          backgroundColor: dashboardSection == 0 ? const Color(0xff4094D0) : const Color(0xffEDEDED)),
                      child: Text(
                        'УЧЕТНАЯ ЗАПИСЬ',
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w600,
                            color: dashboardSection == 0 ? Colors.white : const Color(0xff4094D0)),
                      ),
                    ),
                  ),
                  Container(
                    width: 175,
                    margin: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        dashboardSection = 1;
                        setState(() {});
                      },
                      clipBehavior: Clip.antiAlias,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                          backgroundColor: dashboardSection == 1 ? const Color(0xff4094D0) : const Color(0xffEDEDED)),
                      child: Text(
                        'ТОВАРЫ',
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w600,
                            color: dashboardSection == 1 ? Colors.white : const Color(0xff4094D0)),
                      ),
                    ),
                  ),
                  Container(
                    width: 175,
                    margin: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        dashboardSection = 2;
                        setState(() {});
                      },
                      clipBehavior: Clip.antiAlias,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                          backgroundColor: dashboardSection == 2 ? const Color(0xff4094D0) : const Color(0xffEDEDED)),
                      child: Text(
                        'МАТЕРИАЛЫ',
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w600,
                            color: dashboardSection == 2 ? Colors.white : const Color(0xff4094D0)),
                      ),
                    ),
                  ),
                  Container(
                    width: 175,
                    margin: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        dashboardSection = 3;
                        setState(() {});
                      },
                      clipBehavior: Clip.antiAlias,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                          backgroundColor: dashboardSection == 3 ? const Color(0xff4094D0) : const Color(0xffEDEDED)),
                      child: Text(
                        'ПОДДЕРЖКА',
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w600,
                            color: dashboardSection == 3 ? Colors.white : const Color(0xff4094D0)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 75),
              dashboardSection == 0
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.05) - 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Text('ИНН', style: theme.textTheme.titleSmall),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Text('Наименование организации или ИП', style: theme.textTheme.titleSmall),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 280,
                                height: 35,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 280,
                                height: 35,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Text('Руководитель', style: theme.textTheme.titleSmall),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Text('Должность', style: theme.textTheme.titleSmall),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 280,
                                height: 35,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Кирсанов Дмитрий Владимирович',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 280,
                                height: 35,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Директор ',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text('ФИО ', style: theme.textTheme.titleSmall),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text('Контактное лицо', style: theme.textTheme.titleSmall),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 180,
                                height: 35,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Менеджер',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 180,
                                height: 35,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Кирсанов Дмитрий Владимирович',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 180,
                                height: 35,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: '+7 (922) 123-45-67',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Text('Должность', style: theme.textTheme.titleSmall),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Text('ФИО', style: theme.textTheme.titleSmall),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Text('Телефон', style: theme.textTheme.titleSmall),
                              ),
                            ],
                          ),
                          Divider(
                            color: Color(0xFF000000).withOpacity(0.3),
                            height: 25,
                            thickness: 1,
                            indent: 5,
                            endIndent: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 300,
                                height: 120,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      child: Text('Телефон', style: theme.textTheme.titleSmall),
                                    ),
                                    SizedBox(
                                      height: 35,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          hintText: 'Менеджер',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 300,
                                height: 120,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      child: Text('Телефон', style: theme.textTheme.titleSmall),
                                    ),
                                    SizedBox(
                                      height: 35,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          hintText: 'Менеджер',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : dashboardSection == 1
                      ? Column(children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.05) - 250,
                            child: ExpansionWidget(
                                initiallyExpanded: true,
                                titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
                                  return InkWell(
                                      onTap: () => {
                                            toogleFunction(
                                              animated: true,
                                            ),
                                          },
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Text('Серия Гамильтон',
                                                style: TextStyle(color: Color(0xff83868B), fontSize: 16, fontWeight: FontWeight.w600)),
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              margin: const EdgeInsets.only(left: 20),
                                              decoration: BoxDecoration(
                                                  border: Border.all(width: 1, color: const Color(0xff4094D0)),
                                                  borderRadius: const BorderRadius.all(Radius.circular(5))),
                                              child: Transform.rotate(
                                                angle: pi * animationValue / 2,
                                                alignment: Alignment.center,
                                                child: const Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 10,
                                                  color: Color(0xff4094D0),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                },
                                content: Container(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Table(
                                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                        children: [
                                          const TableRow(children: [
                                            Text(''),
                                            Text(
                                              'Наименование',
                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12),
                                            ),
                                            Text('Категория', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                            Text('Тип', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                            Text('Ширина', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                            Text('Длина', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                            Text('Высота', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                            Text('Артикул', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                            Text('Файл 3D модели', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                            Text('Материал', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                            Text('Цена товара', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                            Text('Описание', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                            Text('Дата и время публикации', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                                            Text('Статус', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                                            Text('Фото', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                                            Text('')
                                          ]),
                                          TableRow(children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              verticalDirection: VerticalDirection.down,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                                  width: 30,
                                                  height: 30,
                                                  padding: EdgeInsets.all(7),
                                                  child: TextButton(
                                                    onPressed: () {},
                                                    child: const Text(""),
                                                    style: ButtonStyle(
                                                      elevation: MaterialStateProperty.all(0),
                                                      backgroundColor: MaterialStateProperty.all(Color(0xff4094D0)),
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(5.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Text(
                                              'Генрих 8',
                                              style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal),
                                            ),
                                            const Text('Для спальни', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                            const Text('Кресло', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                            const Text('65 см', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                            const Text('80 см', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                            const Text('80 см', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                            const Text('ab_0017k4b', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                            const Text('Файл 3D модели', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                            const Text('Материал', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                            const Text('35,000 ₽', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                            const Text('Текст описания', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                            const Text('05.04.2022   10:24',
                                                style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                            const Text('Опубликовано', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                            const Text('Фото', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                            const Text('')
                                          ]),
                                        ],
                                        border: TableBorder.all(width: 1, color: Color(0xffC4C4C4)),
                                      ),
                                    ],
                                  ),
                                )),
                          )
                        ])
                      : dashboardSection == 2
                          ? Column(children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.05) - 250,
                                child: ExpansionWidget(
                                    initiallyExpanded: true,
                                    titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
                                      return InkWell(
                                          onTap: () => {
                                                toogleFunction(
                                                  animated: true,
                                                ),
                                              },
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                const Text('Серия Гамильтон',
                                                    style: TextStyle(color: Color(0xff83868B), fontSize: 16, fontWeight: FontWeight.w600)),
                                                Container(
                                                  padding: const EdgeInsets.all(2),
                                                  margin: const EdgeInsets.only(left: 20),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(width: 1, color: const Color(0xff4094D0)),
                                                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                                                  child: Transform.rotate(
                                                    angle: pi * animationValue / 2,
                                                    alignment: Alignment.center,
                                                    child: const Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 10,
                                                      color: Color(0xff4094D0),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ));
                                    },
                                    content: Container(
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Table(
                                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                            children: [
                                              const TableRow(children: [
                                                Text(''),
                                                Text(
                                                  'Наименование',
                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12),
                                                ),
                                                Text('Категория', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                                Text('Тип', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                                Text('Ширина', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                                Text('Длина', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                                Text('Высота', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                                Text('Артикул', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                                Text('Файл 3D модели',
                                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                                Text('Материал', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                                Text('Цена товара', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                                Text('Описание', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                                                Text('Дата и время публикации', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                                                Text('Статус', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                                                Text('Фото', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                                                Text('')
                                              ]),
                                              TableRow(children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  verticalDirection: VerticalDirection.down,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.grey.withOpacity(0.5)),
                                                          borderRadius: BorderRadius.all(Radius.circular(10))),
                                                      width: 30,
                                                      height: 30,
                                                      padding: EdgeInsets.all(7),
                                                      child: TextButton(
                                                        onPressed: () {},
                                                        child: const Text(""),
                                                        style: ButtonStyle(
                                                          elevation: MaterialStateProperty.all(0),
                                                          backgroundColor: MaterialStateProperty.all(Color(0xff4094D0)),
                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Text(
                                                  'Генрих 8',
                                                  style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal),
                                                ),
                                                const Text('Для спальни', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                                const Text('Кресло', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                                const Text('65 см', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                                const Text('80 см', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                                const Text('80 см', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                                const Text('ab_0017k4b', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                                const Text('Файл 3D модели',
                                                    style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                                const Text('Материал', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                                const Text('35,000 ₽', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                                const Text('Текст описания',
                                                    style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                                const Text('05.04.2022   10:24',
                                                    style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                                const Text('Опубликовано', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                                const Text('Фото', style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                                                const Text('')
                                              ]),
                                            ],
                                            border: TableBorder.all(width: 1, color: Color(0xffC4C4C4)),
                                          ),
                                        ],
                                      ),
                                    )),
                              )
                            ])
                          : dashboardSection == 3
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.05) - 250,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                          child: Text('Телефон', style: theme.textTheme.titleSmall),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                          child: Text('+1 (234) 567 89 01', style: theme.textTheme.titleSmall),
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
                                          SizedBox(width: 10),
                                          SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: Image.asset('assets/icons/Viber.png'),
                                          ),
                                          SizedBox(width: 10),
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
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                          child: Text('pochta@arnitura.com', style: theme.textTheme.titleSmall),
                                        ),
                                      ),
                                      Divider(
                                        color: Color(0xFF000000).withOpacity(0.3),
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
                                      SizedBox(height: 30),
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
                                            backgroundColor: Color(0xFF4094D0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            padding: EdgeInsets.zero,
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.all(10),
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
                              : Container()
            ],
          ),
        ),
      ),
    );
  }
}
