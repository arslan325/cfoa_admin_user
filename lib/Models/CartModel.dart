import 'package:cfoa_fyp/Models/Product_Model.dart';
import 'package:flutter/cupertino.dart';
class CartItemModel{
  static const ID = "id";
  static const ProdID = "Product Id";
  static const ProdTITLE = "Product Title";
  static const ProdIMAGE = "Product Image";
  static const CATEGORY = "category";
  static const ProdPRICE = "Product Price";
  static const COST = "cost";
  static const ProdQUANTITY = "Product Quantity";
  static const ProductDESCRIPTION = "Product Description";
  String id;
  String prodId;
  String prodTitle;
  String prodImage;
  String category;
  double prodPrice;
  double cost;
  String prodDetail;
  int quantity;
  CartItemModel({
    this.id,
    this.prodId,
    this.prodTitle,
    this.prodImage,
    this.category,
    this.prodPrice,
    this.cost,
    this.prodDetail,
    this.quantity
  }
    ) ;
  CartItemModel.fromMap(Map<String, dynamic> data){
    id = data[ID];
    prodId = data[ProdID];
    prodTitle = data[ProdTITLE];
    prodImage = data[ProdIMAGE];
    category = data[CATEGORY];
    prodPrice = data[ProdPRICE].toDouble();
    quantity = data[ProdQUANTITY];
    cost = data[COST].toDouble();
    prodDetail = data[ProductDESCRIPTION];

  }


  Map toJson() => {
    ID: id,
    ProdID: prodId,
    ProdTITLE: prodTitle,
    ProdIMAGE: prodImage,
    CATEGORY: category,
    ProdQUANTITY: quantity,
    COST: prodPrice * quantity,
    ProdPRICE: prodPrice,
    ProductDESCRIPTION: prodDetail
  };

}