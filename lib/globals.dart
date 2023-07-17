import 'package:shared_preferences/shared_preferences.dart';

var url_server = 'http://192.168.0.8:8001/';

late dynamic prefs;

late dynamic categoryList;
late dynamic typeList;

late dynamic setStateModerButtonCallback;

var dashboardSection = 0;

Future initPrefs() async {
  prefs = await SharedPreferences.getInstance();
}
