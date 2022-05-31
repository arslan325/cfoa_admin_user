import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/AuthenticationModel.dart';
import 'package:cfoa_fyp/Models/CartModel.dart';
import 'package:cfoa_fyp/Models/Product_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();
  RxDouble totalCartPrice = 0.0.obs;
  @override
  void onReady() {
    super.onReady();
    ever(userController.authentication, updateCartItem);
  }

  void addProductToCart(ProductModel product) {
    try {
      if (_isItemAlreadyAdded(product)) {
        Get.snackbar("Check your cart", "${product.prodTitle} is already added");
      } else {
        String itemId = DateTime.now().millisecondsSinceEpoch.toString();
        userController.updateUserData({
          "cart": FieldValue.arrayUnion([
            {
              "id": itemId,
              "Product Id": product.prodId,
              "Product Title": product.prodTitle,
              "Product Quantity": product.quantity,
              "Product Price": product.prodPrice,
              "Product Image": product.prodImage,
              "cost": product.prodPrice,
              "Product Description": product.prodDetail,
              "category": product.categoryName,
            }
          ])
        });
        Get.snackbar("Item added", "${product.prodTitle} was added to your cart");
      }
    } catch (e) {
      Get.snackbar("Error", "Cannot add this item");
      debugPrint(e.toString());
    }
  }

  void removeCartItem(CartItemModel cartItem) {
    try {
      userController.updateUserData({
        "cart": FieldValue.arrayRemove([cartItem.toJson()])
      });
    } catch (e) {
      Get.snackbar("Error", "Cannot remove this item");
      debugPrint(e.message);
    }
  }


  updateCartItem(Authentication authentication) {
    totalCartPrice.value = 0.0;
    if (authentication.cart.isNotEmpty) {
      authentication.cart.forEach((cartItem) {
        totalCartPrice += cartItem.cost;
      });
    }
  }

  bool _isItemAlreadyAdded(ProductModel product) =>
      userController.authentication.value.cart
          .where((item) => item.prodId == product.prodId)
          .isNotEmpty;

  void decreaseQuantity(CartItemModel item){
    if(item.quantity == 1){
      removeCartItem(item);
    }else{
      removeCartItem(item);
      item.quantity--;
      userController.updateUserData({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
    }
  }

  void increaseQuantity(CartItemModel item){
    removeCartItem(item);
    item.quantity++;
    logger.i({"quantity": item.quantity});
    userController.updateUserData({
      "cart": FieldValue.arrayUnion([item.toJson()])
    });
  }
}