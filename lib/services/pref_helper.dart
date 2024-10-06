import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/models/cart_model.dart';

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

  saveWishList(List<int> wishList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(wishList);
    await prefs.setString('wishList', jsonString);
  }

  Future<List<int>> getWishList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('wishList');

    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => e as int).toList();
    }

    return [];
  }

  setCartItems(List<CartModel> cartModel) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(cartModel.map((items) => items.toJson()).toList());
    await prefs.setString("cartItems", jsonString);
  }

  Future<List<CartModel>> getCartItems() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString("cartItems");

    if(jsonString != null){
      List<dynamic> jsonList = jsonDecode(jsonString);
      List<CartModel> cartItems = jsonList.map((items) => CartModel.fromJson(items)).toList();
      return cartItems;
    }
    return [];
  }

}
