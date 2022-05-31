import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Screens/PlaceOrderScreen/PaymentMethod_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class ShippingAddressModel {
  static const ID = "Id";
  static const Name = "Name";
  static const PhoneNO = "Phone Number";
  static const Address = "Address";
  static const CityNAME = "City Name";
  static const ZipCODE = "Zip Code";
  static const Province = "Province";
  String id;
  String name;
  String phoneNo;
  String address;
  String cityName;
  int zipCode;
  String province;

  ShippingAddressModel({
    this.id,
    this.name,
    this.phoneNo,
    this.address,
    this.cityName,
    this.zipCode,
    this.province
});

  ShippingAddressModel.fromMap(Map<String, dynamic> data){
    id = data[ID];
    name = data[Name];
    phoneNo = data[PhoneNO];
    address = data[Address];
    cityName = data[CityNAME];
    zipCode = data[ZipCODE];
    province = data[Province];
  }
  Map toJson() => {
    ID: id,
    Name: name,
    PhoneNO: phoneNo,
    Address: address,
    CityNAME: cityName,
    ZipCODE: zipCode,
    Province: province,
  };


  Future<void> addShippingAddress() async{
    try {
        String id = DateTime.now().millisecondsSinceEpoch.toString();
       await userController.updateUserData({
          "Shipping Address": FieldValue.arrayUnion([
            {
              ID: id,
              Name: name,
              PhoneNO: phoneNo,
              Address: address,
              CityNAME: cityName,
              ZipCODE: zipCode,
              Province : province,
            }
          ])
        });
        Get.snackbar("Address added", "New Address was added successfully");
    } catch (e) {
      Get.snackbar("Error", "Cannot add this item");
      debugPrint(e.toString());
    }
  }
  List<ShippingAddressModel> selectedModel =[];
  selectedAddress(ShippingAddressModel addressModel){
    selectedModel.clear();
    selectedModel.add(addressModel);
    Get.to(PaymentMethodScreen());
  }
  List addressItemsToJson() => selectedModel.map((item) => item.toJson()).toList();

  void removeAddress(ShippingAddressModel addressModel) {
    userController.updateUserData({
      "Shipping Address": FieldValue.arrayRemove([addressModel.toJson()])
    });
  }
  void updateShippingAddress(ShippingAddressModel addressModel){
    removeAddress(addressModel);
    userController.updateUserData({
      "Shipping Address": FieldValue.arrayUnion([
        {
          "Id":id,
          "Name": name,
          "Phone Number": phoneNo,
          "Address": address,
          "City Name": cityName,
          "Zip Code": zipCode,
          "Province": province,
        }
      ])
    });
    Get.back();
  }
}