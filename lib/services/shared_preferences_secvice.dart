import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future setCache(String name, String value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString(name, value);
  }

  Future createList(List<String> value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    _preferences.setStringList("checklist", value);
  }

  Future readCache() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cache = _preferences.getString("password");

    return cache;
  }

  Future readList() async {
    return SharedPreferences.getInstance().then((preferences) {
      var cache = preferences.getStringList("checklist");
      List<bool> boolList =
          cache?.map((str) => str.toLowerCase() == 'true').toList() ?? [];
      return boolList;
    });
  }

  Future removeCache(String password) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("password");
  }
}
