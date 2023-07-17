import 'dart:convert';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:arnitura_site/drawer.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'appBar.dart';
import 'globals.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
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
    return Scaffold(
      drawer: const DrawerProject(),
      appBar: appBarArnitura(),
      body: SingleChildScrollView(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return DashboardSection(infoManufacturer: snapshot.data);
            }
            return const CircularProgressIndicator();
          },
          future: signFuture,
        ),
      ),
    );
  }
}

class DashboardSection extends StatefulWidget {
  const DashboardSection({Key? key, this.infoManufacturer}) : super(key: key);

  final dynamic infoManufacturer;

  @override
  State<DashboardSection> createState() => _DashboardSectionState();
}

class _DashboardSectionState extends State<DashboardSection> {
  double fontSizeTableObject = 13;

  var textEditingController = TextEditingController();

  var nameControllerObject = TextEditingController();
  var widthControllerObject = TextEditingController();
  var lengthControllerObject = TextEditingController();
  var heightControllerObject = TextEditingController();
  var articulControllerObject = TextEditingController();
  var selectedCategory;
  var categoryControllerObject = TextEditingController();
  var selectedType;
  var typeControllerObject = TextEditingController();
  var selectedMaterial;
  var materialControllerObject = TextEditingController();
  var vrControllerObject = TextEditingController();
  var vrName = '';
  var priceControllerObject = TextEditingController();
  var descriptionControllerObject = TextEditingController();

  dynamic list_to_create = [];

  var left_margin_title = 5.0;
  var rigth_margin_title = 5.0;

  var rigth_margin_content = 5.0;
  var left_margin_content = 5.0;

  var selectedProductIndex = -1; // индекс в таблице на выбраный товар
  var selectedProductSeriesIndex = -1; // индекс серии в таблице на выбраный товар

  dynamic infoManufacturer;

  Future newPost(List listImages) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Lottie.asset('assets/animation/loading.json'),
                  )
                ],
              ),
            ));
    var listToCreateToSend = [];
    for (var i = 0; i < list_to_create.length; i++) {
      listToCreateToSend.add({});
      for (var j = 0; j < list_to_create[i].length; j++) {
        listToCreateToSend[i][list_to_create[i].keys.toList()[j]] = list_to_create[i][list_to_create[i].keys.toList()[j]].text;
        if (vrControllerObject.text.isEmpty && listImages.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Не все поля заполнены'),
            backgroundColor: Colors.red,
          ));
          Navigator.of(context).pop();
          return;
        }
      }
      listToCreateToSend[i]['images'] = jsonEncode(listImages);
    }
    var response = await post(Uri.parse('${url_server}api/new_post'),
        body: {'data_to_save': jsonEncode(listToCreateToSend), 'manufacturer_id': jsonDecode(prefs.getString('manufacturer'))['id'].toString()});
    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ProductsPage()));
      return response.body.toString();
    }
  }

  Future delPost() async {
    var id_post = infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[selectedProductSeriesIndex].toString()]
        ['furniture'][selectedProductIndex]['id_post'];
    var response = await post(Uri.parse('${url_server}api/del_post'), body: {'id_post': id_post.toString()});
    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ProductsPage()));
      // return response.body.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    infoManufacturer = json.decode(widget.infoManufacturer);
    return Container(
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.height * 0.10,
          right: MediaQuery.of(context).size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListView.builder(
                itemBuilder: (context, index) {
                  var listTableRow = [
                    TableRow(children: [
                      const Text(''),
                      Container(
                        margin: EdgeInsets.only(left: left_margin_title, right: rigth_margin_title),
                        child: const Text(
                          'Наименование',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: left_margin_title, right: rigth_margin_title),
                        child: const Text('Категория', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: left_margin_title, right: rigth_margin_title),
                        child: const Text('Тип', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: left_margin_title, right: rigth_margin_title),
                        child: const Text('Ширина', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: left_margin_title, right: rigth_margin_title),
                        child: const Text('Длина', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: left_margin_title, right: rigth_margin_title),
                        child: const Text('Высота', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: left_margin_title, right: rigth_margin_title),
                        child: const Text('Артикул', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: left_margin_title, right: rigth_margin_title),
                        child: const Text('Файл 3D модели', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: left_margin_title, right: rigth_margin_title),
                        child: const Text('Материал', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: left_margin_title, right: rigth_margin_title),
                        child: const Text('Цена товара', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: left_margin_title, right: rigth_margin_title),
                        child: const Text('Описание', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: left_margin_title, right: rigth_margin_title),
                        child:
                            const Text('Дата и время публикации', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: left_margin_title, right: rigth_margin_title),
                        child: const Text('Статус', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: left_margin_title, right: rigth_margin_title),
                        child: const Text('Фото', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                      ),
                    ])
                  ];
                  for (var i = 0;
                      i < infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['furniture'].length;
                      i++) {
                    List<Widget> imagesList = [];
                    for (var k = 0;
                        k <
                            infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['furniture'][i]
                                    ['furniture_object']['photo_furniture']
                                .length;
                        k++) {
                      imagesList.add(SizedBox(
                        width: MediaQuery.of(context).size.width * 0.075,
                        height: MediaQuery.of(context).size.width * 0.075,
                        child: Image.network(
                            '${url_server}api/get_photos?id=${jsonDecode(prefs.getString('manufacturer'))['id']}&photo_name=${infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['furniture'][i]['furniture_object']['photo_furniture'][k].toString()}'),
                      ));
                    }
                    listTableRow.add(
                      TableRow(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          verticalDirection: VerticalDirection.down,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.withOpacity(0.5)), borderRadius: const BorderRadius.all(Radius.circular(10))),
                              width: 30,
                              height: 30,
                              padding: const EdgeInsets.all(7),
                              child: TextButton(
                                onPressed: () {
                                  selectedProductIndex = i;
                                  selectedProductSeriesIndex = index;
                                  print(this.infoManufacturer);
                                  setState(() {});
                                },
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: selectedProductIndex == i
                                      ? MaterialStateProperty.all(const Color(0xff4094D0))
                                      : MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                                child: const Text(""),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: left_margin_content, right: rigth_margin_content),
                          child: Text(
                            infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['furniture'][i]
                                ['furniture_object']['name'],
                            style: const TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: left_margin_content, right: rigth_margin_content),
                          child: Text(
                              infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['furniture'][i]
                                  ['furniture_object']['type_furniture'],
                              style: const TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: left_margin_content, right: rigth_margin_content),
                          child: Text(
                              infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['furniture'][i]
                                  ['sort'],
                              style: const TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: left_margin_content, right: rigth_margin_content),
                          child: Text(
                              infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['furniture'][i]
                                  ['furniture_object']['width'],
                              style: const TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: left_margin_content, right: rigth_margin_content),
                          child: Text(
                              infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['furniture'][i]
                                  ['furniture_object']['length'],
                              style: const TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: left_margin_content, right: rigth_margin_content),
                          child: Text(
                              infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['furniture'][i]
                                  ['furniture_object']['height'],
                              style: const TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: left_margin_content, right: rigth_margin_content),
                            child: Text(
                                infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['furniture'][i]
                                        ['furniture_object']['articul']
                                    .toString(),
                                style: const TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal))),
                        Container(
                          margin: EdgeInsets.only(left: left_margin_content, right: rigth_margin_content),
                          child: Text(
                              infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['furniture'][i]
                                      ['furniture_object']['model']
                                  .toString(),
                              style: const TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: left_margin_content, right: rigth_margin_content),
                            child: Text(
                                infoManufacturer['list_materials'].firstWhere((element) =>
                                    element['id'].toString() ==
                                    infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]
                                            ['furniture'][i]['furniture_object']['id_material']
                                        .toString())['name'],
                                style: TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal))),
                        Container(
                          margin: EdgeInsets.only(left: left_margin_content, right: rigth_margin_content),
                          child: Text(
                              infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['furniture'][i]
                                      ['furniture_object']['price']
                                  .toString(),
                              style: const TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: left_margin_content, right: rigth_margin_content),
                          child: Text(
                              infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['furniture'][i]
                                  ['furniture_object']['description'],
                              style: const TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: left_margin_content, right: rigth_margin_content),
                          child: Text(
                              infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['furniture'][i]
                                  ['furniture_object']['date'],
                              style: const TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal)),
                        ),
                        infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['furniture'][i]
                                        ['furniture_object']['status_post']
                                    .toString() ==
                                '0'
                            ? Container(
                                decoration: const BoxDecoration(color: Color(0xffFFF0A3), borderRadius: BorderRadius.all(Radius.circular(4))),
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                child: const Text(
                                  'На модерации',
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['furniture'][i]
                                            ['furniture_object']['status_post']
                                        .toString() ==
                                    '1'
                                ? Container(
                                    decoration: const BoxDecoration(color: Color(0xffCCEEB7), borderRadius: BorderRadius.all(Radius.circular(4))),
                                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                    child: const Text('Опубликовано'),
                                  )
                                : infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['furniture']
                                                [i]['furniture_object']['status_post']
                                            .toString() ==
                                        '2'
                                    ? Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/icons/error.png', width: 26),
                                          const Text('Отклонен'),
                                        ],
                                      )
                                    : const SizedBox(),
                        Wrap(children: imagesList),
                        // const Text('')
                      ]),
                    );
                  }

                  return ExpansionWidget(
                      initiallyExpanded: false,
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
                                  Text(
                                      'Серия ${infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['name_series']}',
                                      style: const TextStyle(color: Color(0xff83868B), fontSize: 16, fontWeight: FontWeight.w600)),
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
                      content: StatefulBuilder(builder: (context, setStateTable) {
                        return SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Table(
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                defaultColumnWidth: const IntrinsicColumnWidth(),
                                children: listTableRow,
                                border: TableBorder.all(width: 1, color: const Color(0xffC4C4C4)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  var decorationFieldWindow = const InputDecoration(
                                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff4094D0), width: 2)),
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff4094D0), width: 2)));
                                  var titleStyle = const TextStyle(color: Colors.black, fontWeight: FontWeight.w600);
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        var listImages = [];
                                        dynamic setStateImagesCallback;
                                        addImage() async {
                                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                                            type: FileType.image,
                                          );
                                          if (result != null) {
                                            listImages.add({'bytes': result.files.single.bytes, 'ext': result.files.single.extension});
                                            setStateImagesCallback(() {});
                                          } else {}
                                        }

                                        nameControllerObject = TextEditingController();
                                        widthControllerObject = TextEditingController();
                                        lengthControllerObject = TextEditingController();
                                        heightControllerObject = TextEditingController();
                                        articulControllerObject = TextEditingController();
                                        selectedCategory;
                                        categoryControllerObject = TextEditingController();
                                        selectedType;
                                        typeControllerObject = TextEditingController();
                                        vrControllerObject = TextEditingController();
                                        vrName = '';
                                        priceControllerObject = TextEditingController();
                                        descriptionControllerObject = TextEditingController();

                                        return AlertDialog(
                                          content: Container(
                                            width: MediaQuery.of(context).size.width * 0.8,
                                            height: MediaQuery.of(context).size.height * 0.8,
                                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const SizedBox(height: 80),
                                                  const Text(
                                                    'ДОБАВИТЬ ТОВАР',
                                                    style: TextStyle(color: Color(0xff939599), fontWeight: FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    height: 40,
                                                  ),
                                                  SizedBox(
                                                    height: 80,
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Наименование',
                                                          style: titleStyle,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Expanded(
                                                          child: TextField(
                                                            controller: nameControllerObject,
                                                            decoration: decorationFieldWindow,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  SizedBox(
                                                    height: 80,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Ширина',
                                                                style: titleStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Expanded(
                                                                  child: TextField(
                                                                      controller: widthControllerObject, decoration: decorationFieldWindow)),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Длина',
                                                                style: titleStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Expanded(
                                                                child: TextField(
                                                                  controller: lengthControllerObject,
                                                                  decoration: decorationFieldWindow,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Высота',
                                                                style: titleStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Expanded(
                                                                child: TextField(
                                                                  controller: heightControllerObject,
                                                                  decoration: decorationFieldWindow,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  SizedBox(
                                                    height: 80,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Артикул',
                                                                style: titleStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              TextField(controller: articulControllerObject, decoration: decorationFieldWindow),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                                            children: [
                                                              Text(
                                                                'Категория',
                                                                style: titleStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Expanded(
                                                                child: StatefulBuilder(builder: (context, setStateCategory) {
                                                                  return DropdownButtonHideUnderline(
                                                                    child: DropdownButton2<dynamic>(
                                                                      isExpanded: true,
                                                                      hint: Text(
                                                                        'Найдите категорию',
                                                                        style: TextStyle(
                                                                          fontSize: 14,
                                                                          color: Theme.of(context).hintColor,
                                                                        ),
                                                                      ),
                                                                      items: List<DropdownMenuItem<Object>>.from(
                                                                          categoryList.map((item) => DropdownMenuItem(
                                                                                value: item['id'],
                                                                                child: Text(
                                                                                  item['type'],
                                                                                  style: const TextStyle(
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                ),
                                                                              ))),
                                                                      value: selectedCategory,
                                                                      onChanged: (value) {
                                                                        setStateCategory(() {
                                                                          categoryControllerObject.text = value.toString();
                                                                          selectedCategory = value;
                                                                        });
                                                                      },
                                                                      buttonStyleData: ButtonStyleData(
                                                                          height: 40,
                                                                          width: 200,
                                                                          decoration: BoxDecoration(
                                                                              border: Border.all(color: const Color(0xff4094D0), width: 2),
                                                                              borderRadius: const BorderRadius.all(Radius.circular(4)))),
                                                                      dropdownStyleData: const DropdownStyleData(
                                                                        maxHeight: 200,
                                                                      ),
                                                                      menuItemStyleData: const MenuItemStyleData(
                                                                        height: 40,
                                                                      ),
                                                                      dropdownSearchData: DropdownSearchData(
                                                                        searchController: textEditingController,
                                                                        searchInnerWidgetHeight: 50,
                                                                        searchInnerWidget: Container(
                                                                          height: 50,
                                                                          padding: const EdgeInsets.only(
                                                                            top: 8,
                                                                            bottom: 4,
                                                                            right: 8,
                                                                            left: 8,
                                                                          ),
                                                                          child: TextFormField(
                                                                            expands: true,
                                                                            maxLines: null,
                                                                            controller: textEditingController,
                                                                            decoration: InputDecoration(
                                                                              isDense: true,
                                                                              contentPadding: const EdgeInsets.symmetric(
                                                                                horizontal: 10,
                                                                                vertical: 8,
                                                                              ),
                                                                              hintText: 'Найдите категорию из списка',
                                                                              hintStyle: const TextStyle(fontSize: 12),
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        searchMatchFn: (item, searchValue) {
                                                                          return (item.value.toString().contains(searchValue));
                                                                        },
                                                                      ),
                                                                      onMenuStateChange: (isOpen) {
                                                                        if (!isOpen) {
                                                                          textEditingController.clear();
                                                                        }
                                                                      },
                                                                    ),
                                                                  );
                                                                }),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                                            children: [
                                                              Text(
                                                                'Тип',
                                                                style: titleStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Expanded(
                                                                child: StatefulBuilder(builder: (context, setStateType) {
                                                                  return DropdownButtonHideUnderline(
                                                                    child: DropdownButton2(
                                                                      isExpanded: true,
                                                                      hint: Text(
                                                                        'Выберите тип',
                                                                        style: TextStyle(
                                                                          fontSize: 14,
                                                                          color: Theme.of(context).hintColor,
                                                                        ),
                                                                      ),
                                                                      items:
                                                                          List<DropdownMenuItem<Object>>.from(typeList.map((item) => DropdownMenuItem(
                                                                                value: item['id'],
                                                                                child: Text(
                                                                                  item['sort'],
                                                                                  style: const TextStyle(
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                ),
                                                                              ))),
                                                                      value: selectedType,
                                                                      onChanged: (value) {
                                                                        setStateType(() {
                                                                          typeControllerObject.text = value.toString();
                                                                          selectedType = value;
                                                                        });
                                                                      },
                                                                      buttonStyleData: ButtonStyleData(
                                                                        height: 40,
                                                                        width: 200,
                                                                        decoration: BoxDecoration(
                                                                            border: Border.all(color: const Color(0xff4094D0), width: 2),
                                                                            borderRadius: const BorderRadius.all(Radius.circular(4))),
                                                                      ),
                                                                      dropdownStyleData: const DropdownStyleData(
                                                                        maxHeight: 200,
                                                                      ),
                                                                      menuItemStyleData: const MenuItemStyleData(
                                                                        height: 40,
                                                                      ),
                                                                      dropdownSearchData: DropdownSearchData(
                                                                        searchController: textEditingController,
                                                                        searchInnerWidgetHeight: 50,
                                                                        searchInnerWidget: Container(
                                                                          height: 50,
                                                                          padding: const EdgeInsets.only(
                                                                            top: 8,
                                                                            bottom: 4,
                                                                            right: 8,
                                                                            left: 8,
                                                                          ),
                                                                          child: TextFormField(
                                                                            expands: true,
                                                                            maxLines: null,
                                                                            controller: textEditingController,
                                                                            decoration: InputDecoration(
                                                                              isDense: true,
                                                                              contentPadding: const EdgeInsets.symmetric(
                                                                                horizontal: 10,
                                                                                vertical: 8,
                                                                              ),
                                                                              hintText: 'Выберите тип из списка',
                                                                              hintStyle: const TextStyle(fontSize: 12),
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        searchMatchFn: (item, searchValue) {
                                                                          return (item.value.toString().contains(searchValue));
                                                                        },
                                                                      ),
                                                                      //This to clear the search value when you close the menu
                                                                      onMenuStateChange: (isOpen) {
                                                                        if (!isOpen) {
                                                                          textEditingController.clear();
                                                                        }
                                                                      },
                                                                    ),
                                                                  );
                                                                }),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  SizedBox(
                                                    height: 80,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                                            children: [
                                                              Text(
                                                                'Файл 3D модели',
                                                                style: titleStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Expanded(
                                                                child: StatefulBuilder(builder: (context, setStateVr) {
                                                                  return GestureDetector(
                                                                    onTap: () async {
                                                                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                                                                        type: FileType.custom,
                                                                        allowedExtensions: ['fbx'],
                                                                      );
                                                                      if (result != null) {
                                                                        vrName = result.files.single.name;
                                                                        vrControllerObject.text = result.files.single.bytes.toString();
                                                                        setStateVr(() {});
                                                                      } else {}
                                                                    },
                                                                    child: Container(
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(color: const Color(0xff4094D0), width: 2),
                                                                          borderRadius: const BorderRadius.all(Radius.circular(4))),
                                                                      child: Row(
                                                                        children: [
                                                                          Image.asset(
                                                                            'assets/icons/add_vr.png',
                                                                            width: 22,
                                                                          ),
                                                                          Text(vrName)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              //list_materials
                                                              Text(
                                                                'Материал',
                                                                style: titleStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Expanded(
                                                                child: StatefulBuilder(builder: (context, setStateType) {
                                                                  return DropdownButtonHideUnderline(
                                                                    child: DropdownButton2(
                                                                      isExpanded: true,
                                                                      hint: Text(
                                                                        'Выберите материал',
                                                                        style: TextStyle(
                                                                          fontSize: 14,
                                                                          color: Theme.of(context).hintColor,
                                                                        ),
                                                                      ),
                                                                      items: List<DropdownMenuItem<Object>>.from(
                                                                          infoManufacturer['list_materials'].map((item) => DropdownMenuItem(
                                                                                value: item['id'],
                                                                                child: Text(
                                                                                  item['name'],
                                                                                  style: const TextStyle(
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                ),
                                                                              ))),
                                                                      value: selectedMaterial,
                                                                      onChanged: (value) {
                                                                        setStateType(() {
                                                                          materialControllerObject.text = value.toString();
                                                                          selectedMaterial = value;
                                                                        });
                                                                      },
                                                                      buttonStyleData: ButtonStyleData(
                                                                        height: 40,
                                                                        width: 300,
                                                                        decoration: BoxDecoration(
                                                                            border: Border.all(color: const Color(0xff4094D0), width: 2),
                                                                            borderRadius: const BorderRadius.all(Radius.circular(4))),
                                                                      ),
                                                                      dropdownStyleData: const DropdownStyleData(
                                                                        maxHeight: 200,
                                                                      ),
                                                                      menuItemStyleData: const MenuItemStyleData(
                                                                        height: 40,
                                                                      ),
                                                                      dropdownSearchData: DropdownSearchData(
                                                                        searchController: textEditingController,
                                                                        searchInnerWidgetHeight: 50,
                                                                        searchInnerWidget: Container(
                                                                          height: 50,
                                                                          padding: const EdgeInsets.only(
                                                                            top: 8,
                                                                            bottom: 4,
                                                                            right: 8,
                                                                            left: 8,
                                                                          ),
                                                                          child: TextFormField(
                                                                            expands: true,
                                                                            maxLines: null,
                                                                            controller: textEditingController,
                                                                            decoration: InputDecoration(
                                                                              isDense: true,
                                                                              contentPadding: const EdgeInsets.symmetric(
                                                                                horizontal: 10,
                                                                                vertical: 8,
                                                                              ),
                                                                              hintText: 'Выберите материал из списка',
                                                                              hintStyle: const TextStyle(fontSize: 12),
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        searchMatchFn: (item, searchValue) {
                                                                          return (item.value.toString().contains(searchValue));
                                                                        },
                                                                      ),
                                                                      //This to clear the search value when you close the menu
                                                                      onMenuStateChange: (isOpen) {
                                                                        if (!isOpen) {
                                                                          textEditingController.clear();
                                                                        }
                                                                      },
                                                                    ),
                                                                  );
                                                                }),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Цена товара',
                                                                style: titleStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              TextField(
                                                                controller: priceControllerObject,
                                                                decoration: decorationFieldWindow,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  SizedBox(
                                                    height: 175,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 3,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Описание',
                                                                style: titleStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              TextFormField(
                                                                maxLines: 5,
                                                                controller: descriptionControllerObject,
                                                                decoration: decorationFieldWindow,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Фото',
                                                                style: titleStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              StatefulBuilder(builder: (context, setStateImages) {
                                                                setStateImagesCallback = setStateImages;
                                                                return Wrap(
                                                                  runSpacing: 10.0,
                                                                  children: List.generate(5, (index) {
                                                                    if (listImages.length > index) {
                                                                      return Container(
                                                                        margin: const EdgeInsets.only(right: 10),
                                                                        child: Image.memory(
                                                                          listImages[index]['bytes'],
                                                                          width: 54,
                                                                          height: 54,
                                                                        ),
                                                                      );
                                                                    }
                                                                    return Container(
                                                                      margin: const EdgeInsets.only(right: 10),
                                                                      child: GestureDetector(
                                                                        onTap: () async {
                                                                          addImage();
                                                                        },
                                                                        child: DottedBorder(
                                                                          borderType: BorderType.RRect,
                                                                          radius: const Radius.circular(8),
                                                                          strokeWidth: 2,
                                                                          color: const Color(0xffBBBBBB),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(10),
                                                                            child: Image.asset('assets/icons/add_photo.png',
                                                                                width: 30, height: 30, color: const Color(0xffBBBBBB)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                                );
                                                              }),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Center(
                                                      child: Container(
                                                    margin: const EdgeInsets.only(top: 20),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        list_to_create.add({
                                                          'name_series': TextEditingController(
                                                              text: infoManufacturer['list_furniture']
                                                                      [infoManufacturer['list_furniture'].keys.toList()[index].toString()]
                                                                  ['name_series']),
                                                          'name': nameControllerObject,
                                                          'category': categoryControllerObject,
                                                          'type': typeControllerObject,
                                                          'width': widthControllerObject,
                                                          'length': lengthControllerObject,
                                                          'height': heightControllerObject,
                                                          'material': materialControllerObject,
                                                          'model': articulControllerObject,
                                                          'vr': vrControllerObject,
                                                          'price': priceControllerObject,
                                                          'description': descriptionControllerObject,
                                                        });
                                                        newPost(listImages);
                                                      },
                                                      style: const ButtonStyle(
                                                        backgroundColor: MaterialStatePropertyAll(Color(0xff4094D0)),
                                                        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 20, horizontal: 30)),
                                                      ),
                                                      child: const Text('Добавить'),
                                                    ),
                                                  ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      barrierDismissible: true);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  child: const Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        Icons.add,
                                        color: Color(0xff4094D0),
                                      ),
                                      SizedBox(width: 15),
                                      Text(
                                        'Товар',
                                        style: TextStyle(color: Color(0xff83868B)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                color: Color(0xffC4C4C4),
                              ),
                              selectedProductIndex == -1
                                  ? SizedBox()
                                  : StatefulBuilder(builder: (context, setStateModerButton) {
                                      return Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(5),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                delPost();
                                              },
                                              style: ButtonStyle(
                                                backgroundColor: const MaterialStatePropertyAll(Colors.white),
                                                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                                  side: const BorderSide(color: Color(0xff4094D0), width: 1),
                                                  borderRadius: BorderRadius.circular(10),
                                                )),
                                              ),
                                              child: const Text(
                                                'Удалить публикацию',
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          infoManufacturer['list_furniture'][infoManufacturer['list_furniture']
                                                          .keys
                                                          .toList()[selectedProductSeriesIndex]
                                                          .toString()]['furniture'][selectedProductIndex]['furniture_object']['status_post']
                                                      .toString() ==
                                                  '1'
                                              ? Container(
                                                  margin: const EdgeInsets.all(5),
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      var response = await post(Uri.parse('${url_server}api/off_publication'), body: {
                                                        'id_post': infoManufacturer['list_furniture'][infoManufacturer['list_furniture']
                                                                .keys
                                                                .toList()[selectedProductSeriesIndex]
                                                                .toString()]['furniture'][selectedProductIndex]['id_post']
                                                            .toString()
                                                      });
                                                      if (response.statusCode == 200) {
                                                        Navigator.of(context)
                                                            .pushReplacement(MaterialPageRoute(builder: (context) => const ProductsPage()));
                                                      }
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor: const MaterialStatePropertyAll(Colors.white),
                                                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                                        side: const BorderSide(color: Color(0xff4094D0), width: 1),
                                                        borderRadius: BorderRadius.circular(10),
                                                      )),
                                                    ),
                                                    child: const Text(
                                                      'Снять с публкации',
                                                      style: TextStyle(color: Colors.black),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),
                                          infoManufacturer['list_furniture'][infoManufacturer['list_furniture']
                                                          .keys
                                                          .toList()[selectedProductSeriesIndex]
                                                          .toString()]['furniture'][selectedProductIndex]['furniture_object']['status_post']
                                                      .toString() ==
                                                  '2'
                                              ? Container(
                                                  margin: const EdgeInsets.all(5),
                                                  child: ElevatedButton(
                                                    onPressed: () {},
                                                    style: ButtonStyle(
                                                      backgroundColor: const MaterialStatePropertyAll(Colors.white),
                                                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                                        side: const BorderSide(color: Color(0xff4094D0), width: 1),
                                                        borderRadius: BorderRadius.circular(10),
                                                      )),
                                                    ),
                                                    child: const Text(
                                                      'Опубликовать',
                                                      style: TextStyle(color: Colors.black),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      );
                                    })
                            ],
                          ),
                        );
                      }));
                },
                itemCount: infoManufacturer['list_furniture'].length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true),
          ),
        ],
      ),
    );
  }
}
