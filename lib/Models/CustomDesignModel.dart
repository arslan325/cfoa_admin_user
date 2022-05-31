import 'dart:io';

import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowLoading.dart';
import 'package:cfoa_fyp/Config/Shared_Prefrences.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class CustomDesignModel{
  static const DesignID = "Design Id";
  static const CustomerID = "Customer Id";
  static const DesignTITLE = "Design Title";
  static const DesignIMAGE = "Design Image";
  static const DesignPRICE = "Design Price";
  static const MANUTime = "Manufacturing Time";
  static const DesignSTATUS = "Design Status";
  static const DesignDESCRIPTION = "Design Description";
  String designId;
  String customerId;
  String designTitle;
  String designImage;
  String designDescription;
  String manufacturingTime;
  String designStatus;
  double designPrice;
  CustomDesignModel({
    this.designId,
    this.designTitle,
    this.customerId,
    this.designImage,
    this.designDescription,
    this.designPrice,
    this.designStatus,
    this.manufacturingTime,
  });
  CustomDesignModel.fromMap(Map<String, dynamic> data){
    designId = data[DesignID];
    designTitle = data[DesignTITLE];
    designImage = data[DesignIMAGE];
    designPrice = data[DesignPRICE];
    designStatus = data[DesignSTATUS];
    customerId = data[CustomerID];
    manufacturingTime = data[MANUTime];
    designDescription = data[DesignDESCRIPTION];
  }

  Map toJsonMap() => {
    DesignID: designId,
    DesignTITLE: designTitle,
    DesignIMAGE: designImage,
    DesignPRICE: designPrice,
    MANUTime: manufacturingTime,
    DesignDESCRIPTION: designDescription,
  };

  final userReference = FirebaseFirestore.instance.collection("Users");
  CollectionReference customDesignReference = FirebaseFirestore.instance.collection('Custom Design');

}