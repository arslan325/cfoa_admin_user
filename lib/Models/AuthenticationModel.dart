import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'CartModel.dart';
import 'ShippingAddressModel.dart';
class Authentication {
  static const CART = "cart";
  static const ID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";
  static const UserPROFILE = "imageUrl";
  static const ShippingADDRESS = "Shipping Address";

  String uid;
  String name;
  String email;
  String password;
  String userProfile;
  List<CartItemModel> cart;
  List<ShippingAddressModel> userShippingAddress;
  Authentication({this.uid,this.name,this.email,this.userProfile,this.cart,this.password});

  Authentication.fromMap(Map<String, dynamic> data){
    name = data[NAME];
    email = data[EMAIL];
    userProfile = data[UserPROFILE];
    uid = data[ID];
  }

  Authentication.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot.data()[NAME];
    email = snapshot.data()[EMAIL];
    uid = snapshot.data()[ID];
    userProfile = snapshot.data()[UserPROFILE];
    cart = _convertCartItems(snapshot.data()[CART] ?? []);
    userShippingAddress = _convertAddressData(snapshot.data()[ShippingADDRESS] ?? []);
  }


List<CartItemModel> _convertCartItems(List cartFromDB){
  List<CartItemModel> _cart = [];
  logger.i(cartFromDB);
  if(cartFromDB.length > 0){
    cartFromDB.forEach((element) {
      _cart.add(CartItemModel.fromMap(element));
    });
  }
  return _cart;
}
  List cartItemsToJson() => cart.map((item) => item.toJson()).toList();

  List<ShippingAddressModel> _convertAddressData(List cartFromDB){
    List<ShippingAddressModel> _address = [];
    logger.i(cartFromDB);
    if(cartFromDB.length > 0){
      cartFromDB.forEach((element) {
        _address.add(ShippingAddressModel.fromMap(element));
      });
    }
    return _address;
  }
  List addressItemsToJson() => userShippingAddress.map((item) => item.toJson()).toList();



displayToast(String message){
  Fluttertoast.showToast(msg: message,
  );
}
}

