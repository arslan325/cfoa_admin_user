import 'dart:io';
import 'package:cfoa_fyp/Admin%20Panel/Screens/ProductManaged/ProductListed.dart';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowLoading.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
class ProductModel{
  static const ProdID = "Product Id";
  static const ProdTITLE = "Product Title";
  static const ProdIMAGE = "Product Image";
  static const CatName = "Category";
  static const ProdPRICE = "Product Price";
  static const ProdQUANTITY = "Product Quantity";
  static const ProductDESCRIPTION = "Product Description";
  String prodId;
  String prodTitle;
  String prodImage;
  String categoryName;
  double prodPrice;
  int prodPrice1;
  String prodDetail;
  int quantity;
  ProductModel({
    this.prodId,
    this.prodTitle,
    this.prodImage,
    this.prodPrice,
    this.prodDetail,
    this.quantity,
    this.categoryName,
    this.prodPrice1
  });
  ProductModel.fromMap(Map<String, dynamic> data){
    prodId = data[ProdID];
    prodTitle = data[ProdTITLE];
    prodImage = data[ProdIMAGE];
    categoryName = data[CatName];
    prodPrice = data[ProdPRICE].toDouble();
    quantity = data[ProdQUANTITY];
    prodDetail = data[ProductDESCRIPTION];
  }
  CollectionReference productReference = FirebaseFirestore.instance.collection('products');

}

