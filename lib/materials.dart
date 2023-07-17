import 'dart:convert';
import 'dart:io';

import 'package:arnitura_site/drawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:lottie/lottie.dart';

import 'appBar.dart';
import 'globals.dart';

class MaterialsPage extends StatefulWidget {
  const MaterialsPage({super.key});

  @override
  State<MaterialsPage> createState() => _MaterialsPageState();
}

class _MaterialsPageState extends State<MaterialsPage> {
  late Future signFuture;

  var rigth_margin_content = 5.0;
  var left_margin_content = 5.0;

  var nameControllerObject = TextEditingController();
  var colorControllerObject = TextEditingController();
  dynamic basecolorFileControllerObject;
  var filesControllerObject = TextEditingController();

  String basecolor_image_name = '';
  List listTextures = [];

  Future sign() async {
    var response = await http
        .post(Uri.parse('${url_server}api/auth_manufacturer'), body: {'login': prefs.getString('login'), 'password': prefs.getString('password')});
    if (response.statusCode == 200) {
      categoryList = jsonDecode(jsonDecode(response.body)['list_category']);
      typeList = jsonDecode(jsonDecode(response.body)['list_type']);
      prefs.setString('manufacturer', response.body);
      prefs.setBool('isAuth', true);
      return response.body;
    }
  }

  Future newMaterial() async {
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
    if (nameControllerObject.text.isEmpty || colorControllerObject.text.isEmpty || basecolor_image_name.isEmpty || listTextures.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Не все поля заполнены'),
        backgroundColor: Colors.red,
      ));
      Navigator.of(context).pop();
      return;
    }
    try {
      var request = http.MultipartRequest('POST', Uri.parse('${url_server}api/new_material'));
      var textures_name = [];
      request.fields['name'] = nameControllerObject.text;
      request.fields['color'] = colorControllerObject.text;
      request.fields['file_name_basecolor'] = basecolor_image_name;
      request.fields['manufacturer_id'] = jsonDecode(prefs.getString('manufacturer'))['id'].toString();
      request.fields['file_basecolor_bytes'] = jsonEncode(basecolorFileControllerObject);
      for (var i = 0; i < listTextures.length; i++) {
        request.fields[listTextures[i]['name']] = jsonEncode(listTextures[i]['bytes']);
        textures_name.add(listTextures[i]['name']);
      }
      request.fields['textures_name'] = textures_name.join(', ');
      var response = await request.send();

      var totalBytes = response.contentLength;
      var bytesTransferred = 0.0;

      response.stream.transform(utf8.decoder).listen((value) {
        bytesTransferred += value.length;
        int progress = ((bytesTransferred / totalBytes!) * 100).toInt();
        print('Upload progress: $progress %');
      });

      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MaterialsPage()));
        return 'response.body.toString()';
      }
    } catch (e) {
      print(e);
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
              dynamic infoManufacturer = json.decode(snapshot.data);
              return Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    top: MediaQuery.of(context).size.height * 0.10,
                    right: MediaQuery.of(context).size.width * 0.05),
                child: Column(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          var listTableRow = [
                            const TableRow(children: [
                              Text(
                                'Наименование материала',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                              Text('Наименование цвета',
                                  textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                              Text('Файл материала base color',
                                  textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                              Text('Карты материала',
                                  textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12)),
                            ])
                          ];
                          for (var i = 0; i < infoManufacturer['list_materials'].length; i++) {
                            var object_material = infoManufacturer['list_materials'][i];
                            // List<Widget> imagesList = [];
                            // for (var k = 0;
                            // k <
                            //     infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['furniture'][i]
                            //     ['furniture_object']['photo_furniture']
                            //         .length;
                            // k++) {
                            //   imagesList.add(SizedBox(
                            //     width: MediaQuery.of(context).size.width * 0.075,
                            //     height: MediaQuery.of(context).size.width * 0.075,
                            //     child: Image.network(
                            //         '${url_server}api/get_photos?id=${jsonDecode(prefs.getString('manufacturer'))['id']}&photo_name=${infoManufacturer['list_furniture'][infoManufacturer['list_furniture'].keys.toList()[index].toString()]['furniture'][i]['furniture_object']['photo_furniture'][k].toString()}'),
                            //   ));
                            // }
                            listTableRow.add(TableRow(children: [
                              Container(
                                  margin: EdgeInsets.only(left: left_margin_content, right: rigth_margin_content),
                                  child: Text(object_material['name'].toString(),
                                      style: const TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal))),
                              Container(
                                  margin: EdgeInsets.only(left: left_margin_content, right: rigth_margin_content),
                                  child: Text(object_material['color'].toString(),
                                      style: const TextStyle(color: Color(0xff2D2D2D), fontWeight: FontWeight.normal))),
                              Container(
                                margin: EdgeInsets.only(left: left_margin_content, right: rigth_margin_content, top: 10, bottom: 10),
                                width: 100,
                                height: 100,
                                child: SizedBox(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    fit: StackFit.loose,
                                    children: [
                                      Image.network(
                                        '${url_server}api/get_photo_file_texture?manufacturer_id=${infoManufacturer['id']}&material_id=${object_material['id']}&selected_texture=${(object_material['textures'] as List).firstWhere((element) => element.toLowerCase().contains('basecolor') || element.toLowerCase().contains('base_color'))}',
                                      ),
                                      SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(7)),
                                                color: Colors.white,
                                              ),
                                              margin: const EdgeInsets.only(top: 5, right: 5),
                                              padding: const EdgeInsets.all(2),
                                              child: const Icon(Icons.close, size: 15, color: Color(0xff4094D0)),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: left_margin_content, right: rigth_margin_content),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: (object_material['textures'] as List)
                                        .map((e) => Row(
                                              children: [
                                                Icon(Icons.close, size: 15, color: Color(0xff4094D0)),
                                                Text(e),
                                              ],
                                            ))
                                        .toList(),
                                  )),
                            ]));
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Table(
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
                                        dynamic setStateBasecolorCallback;
                                        dynamic setStateTexturesCallback;

                                        addBasecolor() async {
                                          FilePickerResult? result = await FilePicker.platform
                                              .pickFiles(type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg'], allowMultiple: false);
                                          if (result != null) {
                                            basecolor_image_name = result.files.single.name;
                                            basecolorFileControllerObject = result.files.single.bytes;
                                            setStateBasecolorCallback(() {});
                                            // setStateVr(() {});
                                          } else {}
                                        }

                                        addTextures() async {
                                          FilePickerResult? result = await FilePicker.platform
                                              .pickFiles(type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg'], allowMultiple: true);
                                          if (result != null) {
                                            for (var i = 0; i < result.files.length; i++) {
                                              listTextures.add({'name': result.files[i].name, 'bytes': result.files[i].bytes});
                                            }
                                            setStateTexturesCallback(() {});
                                          } else {}
                                        }

                                        nameControllerObject = TextEditingController();
                                        colorControllerObject = TextEditingController();

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
                                                    'ДОБАВИТЬ МАТЕРИАЛ',
                                                    style: TextStyle(color: Color(0xff939599), fontWeight: FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    height: 40,
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
                                                                'Наименование материала',
                                                                style: titleStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Expanded(
                                                                  child:
                                                                      TextField(controller: nameControllerObject, decoration: decorationFieldWindow)),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Наименование цвета',
                                                                style: titleStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Expanded(
                                                                child: TextField(
                                                                  controller: colorControllerObject,
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
                                                                'Файл материала base color',
                                                                style: titleStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Expanded(
                                                                child: StatefulBuilder(builder: (context, setStateBasecolor) {
                                                                  setStateBasecolorCallback = setStateBasecolor;
                                                                  return GestureDetector(
                                                                    onTap: addBasecolor,
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
                                                                          Text(basecolor_image_name)
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
                                                            mainAxisSize: MainAxisSize.min,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Карты',
                                                                style: titleStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Expanded(
                                                                child: StatefulBuilder(builder: (context, setStateTextures) {
                                                                  setStateTexturesCallback = setStateTextures;
                                                                  return GestureDetector(
                                                                    onTap: addTextures,
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
                                                                          Text('Карты:' + listTextures.length.toString())
                                                                        ],
                                                                      ),
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
                                                  Center(
                                                      child: Container(
                                                    margin: const EdgeInsets.only(top: 20),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        newMaterial();
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
                            ],
                          );
                        },
                        itemCount: 1,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true),
                  )
                ]),
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
