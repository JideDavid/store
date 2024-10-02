import 'package:flutter/material.dart';
import 'package:store/services/pref_helper.dart';

import '../models/product.dart';
import '../services/api.dart';
import '../utility/constants/colors.dart';
import '../utility/constants/sizes.dart';

class ProductsProvider extends ChangeNotifier{
  bool gettingProducts = false , gettingCategories = false;
  List<ProductModel>? products;
  List<String>? productCategories;
  List<ProductModel> sortedProducts = [];
  String category = "All Products";
  List<int> wishList = [];
  List<ProductModel> wishProducts = [];

  getProducts() async {
    gettingProducts = true;
    products = await API.getAllProducts();
    getWishList();
    gettingProducts = false;
    notifyListeners();
  }

  deleteProduct(int index) async{
    bool resp = await API.deleteProduct(products![index].id.toString());
    if(resp){
      getProducts();
    }
  }

  getCategories() async {
    gettingCategories = true;
    productCategories = await API.getCategories();
    gettingCategories = false;
    notifyListeners();
  }

  sortProducts(String mCategory){
    category = mCategory;
    sortedProducts = [];
    if( products != null ){
      for(ProductModel product in products!){
        if(product.category == category){
          sortedProducts.add(product);
        }
      }
    }
    notifyListeners();
  }

  getWishList()async{
    wishList = await PrefHelper().getWishList();
    debugPrint(wishList.toString());

    /// - sorting wishlist
    wishProducts = [];
    if(products != null){
      for(int productId in wishList){
        ProductModel wish = products!.firstWhere((e) => e.id == productId);
        wishProducts.add(wish);
      }
    }
    notifyListeners();
  }

  updateWishList(BuildContext context, int productId){
    List<int> wishListUpdate = wishList;
    if(wishListUpdate.contains(productId)){
      wishListUpdate.remove(productId);

      // show snack bar
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 1),
              content: Row(
                children: [
                  Icon(Icons.info, color: TColors.secondary,),
                  SizedBox(width: TSizes.paddingSpaceMd,),
                  Text("Product removed from wish list"),
                ],
              )));
    }
    else{
      wishListUpdate.add(productId);
      // show snack bar
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              duration: Duration(seconds: 1),
              content: Row(
                children: [
                  Icon(Icons.info, color: TColors.success,),
                  SizedBox(width: TSizes.paddingSpaceMd,),
                  Text("Product added from wish list"),
                ],
              )));
    }
    PrefHelper().saveWishList(wishList);
    getWishList();
    notifyListeners();
  }


}