import 'package:flutter/material.dart';
import 'package:store/models/cart_model.dart';
import 'package:store/services/pref_helper.dart';
import 'package:store/utility/custom_widgets/dialog.dart';

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
  int offsetProduct = 4;
  bool loadingProducts = false;
  int offsetSort = 4;
  bool loadingSort = false;
  List<ProductModel> searchProduct = [];
  List<ProductModel> searchSorted = [];
  List<CartModel> cartItems = [];
  List<ProductModel> cartList = [];

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
    offsetSort = 4;
    if( products != null ){

      sortedProducts = products!.where((product) => product.category == category).toList();

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

  moreProducts(int offset) async {
    int newLength = offsetProduct + offset;
    if(newLength >= products!.length){
      offsetProduct = products!.length;
    }
    else{
      await Future.delayed(const Duration(milliseconds: 600));
      offsetProduct = newLength;
      }
    debugPrint("offsetProduct: $offsetProduct");
    notifyListeners();
  }

  moreSorted(int offset) async {
    int newLength = offsetSort + offset;
    if(newLength >= sortedProducts.length){
      offsetSort = sortedProducts.length;
    }
    else{
      await Future.delayed(const Duration(milliseconds: 600));
      offsetSort = newLength;
    }
    debugPrint("offsetSort: $offsetSort");
    notifyListeners();
  }

  searchProducts(String searchTerm){
    if(searchTerm.isEmpty){
      searchProduct = [];
      searchSorted = [];
    }
    else if (products != null){
      searchProduct = products!.where((product) => product.title.toLowerCase().contains(searchTerm.toLowerCase())).toList();
      searchSorted = sortedProducts.where((product) => product.title.toLowerCase().contains(searchTerm.toLowerCase())).toList();
    }

    notifyListeners();
  }

  modifyCartItemUnit(bool add, index){
    if(add){
      cartItems[index].units += 1;
    }
    else if(cartItems[index].units != 1){
      cartItems[index].units -= 1;
    }
    PrefHelper().setCartItems(cartItems);
    getCartList();
    notifyListeners();
  }

  getCartList()async{
    cartItems = await PrefHelper().getCartItems();
    cartList = [];
    if(products != null){
      for(CartModel productId in cartItems){
        ProductModel cart = products!.firstWhere((e) => e.id == productId.id);
        cartList.add(cart);
      }
    }
    debugPrint("cart list updated");
    notifyListeners();
  }

  addItemToCart(BuildContext context, int id){

    if(cartItems.any((item) => item.id == id)){
      debugPrint("-- product is already in cart --");
      MDialog(context: context).error("Error", "product is already in cart");
    }
    else{
      cartItems.add(CartModel(id: id, units: 1));
      PrefHelper().setCartItems(cartItems);
      debugPrint("-- product $id added to cart --");
      MDialog(context: context).success("Success", "product is successfully added to cart");
    }
    notifyListeners();
  }

  removeItemFromCart(BuildContext context, int id){
    cartItems.remove(cartItems.firstWhere((item) => item.id.toString() == id.toString()));
    PrefHelper().setCartItems(cartItems);
    debugPrint("-- product $id is removed from cart --");
    getCartList();
    notifyListeners();
    MDialog(context: context).success("Success", "product is successfully removed from cart");
  }
}