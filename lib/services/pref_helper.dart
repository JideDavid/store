import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {

  Future<bool> getThemeMode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? val = pref.getBool("isLight");
    if (val == null) {
      return true;
    } else {
      return val;
    }
  }

  Future<bool> setThemeMode(bool val) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isLight", val);
    return val;
  }

  Future<bool> getAppIsFresh() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? val = pref.getBool("appIsFresh");
    if (val == null) {
      return true;
    } else {
      return val;
    }
  }

  setAppIsFresh(bool val) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("appIsFresh", val);
  }

  Future<void> saveWishList(List<int> wishList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(wishList); // Convert list to JSON string
    await prefs.setString('wishList', jsonString); // Save the string
  }

  Future<List<int>> getWishList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('wishList');

    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString); // Convert back to List<dynamic>
      return jsonList.map((e) => e as int).toList(); // Convert to List<int>
    }

    return []; // Return empty list if no data found
  }
}
