import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../utility/constants/api_constants.dart';

class API{

  static Future<List<String>?> getCategories() async{

    final response = await http.get(Uri.parse(ApiString.category));

    if(response.statusCode == 200) {
      try{
        List<String> productCategories = [];

        var bodyDecode = jsonDecode(response.body);
        for(String category in bodyDecode){
          productCategories.add(category);
        }

        debugPrint("all categories added");

        return productCategories;
      }
      catch(e){
        debugPrint("error getting categories: $e");
        return null;
      }
    }
    else{
      debugPrint('failed to get data: error ${response.statusCode}');
      return null;
    }
  }

  static Future<List<ProductModel>?> getAllProducts() async{

    final response = await http.get(Uri.parse(ApiString.allProducts));

    if(response.statusCode == 200) {
      List<ProductModel> allProducts = [];

      var bodyDecode = jsonDecode(response.body);

      for(Map<String, dynamic> item in bodyDecode){
        allProducts.add(ProductModel.fromJson(item));
      }

      debugPrint("all products added");

      return allProducts;
    }
    else{
      debugPrint('failed to get data: error ${response.statusCode}');
      return null;
    }
  }

  static Future<bool> deleteProduct(String productId) async{

    final response = await http.delete(Uri.parse(ApiString.pAllProducts+productId));

    if(response.statusCode == 200){
      if(response.body.toString() == "true"){
        debugPrint("product with ID: $productId successfully deleted");
        return true;
      }
      else{
        debugPrint("something went wrong");
        return false;
      }
    }
    else{
      debugPrint('failed to delete product: error ${response.statusCode}');
      return false;
    }

  }

  static Future<bool> deleteCategory(String categoryID) async{

    final response = await http.delete(Uri.parse(ApiString.pAllProducts+categoryID));

    if(response.statusCode == 200){
      if(response.body.toString() == "true"){
        debugPrint("category with ID: $categoryID successfully deleted");
        return true;
      }
      else{
        debugPrint("something went wrong");
        return false;
      }
    }
    else{
      debugPrint('failed to delete product: error ${response.statusCode}');
      return false;
    }

  }

}