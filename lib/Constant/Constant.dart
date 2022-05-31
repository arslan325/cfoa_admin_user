import 'package:cfoa_fyp/Admin%20Panel/Controllers/AdminController.dart';
import 'package:cfoa_fyp/Admin%20Panel/Controllers/CartController.dart';
import 'package:cfoa_fyp/Admin%20Panel/Controllers/Category_Controller.dart';
import 'package:cfoa_fyp/Admin%20Panel/Controllers/CustomDesignController.dart';
import 'package:cfoa_fyp/Admin%20Panel/Controllers/CustomDesignOrderController.dart';
import 'package:cfoa_fyp/Admin%20Panel/Controllers/ImagePickerController.dart';
import 'package:cfoa_fyp/Admin%20Panel/Controllers/NotificationController.dart';
import 'package:cfoa_fyp/Admin%20Panel/Controllers/OrderController.dart';
import 'package:cfoa_fyp/Admin%20Panel/Controllers/Product_Controller.dart';
import 'package:cfoa_fyp/Admin%20Panel/Controllers/UserController.dart';
import 'package:cfoa_fyp/Admin%20Panel/Models/AdminLoginModel.dart';
import 'package:cfoa_fyp/Models/AuthenticationModel.dart';
import 'package:cfoa_fyp/Models/CategoryModel.dart';
import 'package:cfoa_fyp/Models/CustomDesignModel.dart';
import 'package:cfoa_fyp/Models/CustomDesignOrderModel.dart';
import 'package:cfoa_fyp/Models/Product_Model.dart';
import 'package:cfoa_fyp/Models/ShippingAddressModel.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
const  kbackgroundColor = Color(0xffebeef1);
const kbuttonColor = Color(0xff1fb141);
const kbuttonTextColor = Colors.white;

const kheadingStyle = TextStyle(
  fontSize: 22,
  fontFamily: 'Raleway-Bold',
);
const kbuttonStyle= TextStyle(
  fontSize: 18.0,
  color: kbuttonTextColor,
  fontFamily: 'Raleway-Bold',
);
const klabelStyle = TextStyle(
    fontSize: 16,
    color: Colors.black87,
  fontFamily: 'Raleway-Bold',
);

Authentication authentication = new Authentication();
AdminAuthentication adminAuthentication = new AdminAuthentication();
CategoryModel categoryModel = new CategoryModel();
ProductModel productModel = new ProductModel();
ShippingAddressModel addressModel = new ShippingAddressModel();
CustomDesignModel customDesignModel = new CustomDesignModel();
CustomDesignOrder customDesignOrder = new CustomDesignOrder();
Logger logger = Logger();
CategoryController categoryController = CategoryController.instance;
ProductController productController = ProductController.instance;
UserController userController = UserController.instance;
CartController cartController = CartController.instance;
OrderController orderController = OrderController.instance;
CustomDesignController customDesignController =CustomDesignController.instance;
CustomDesignOrderController customDesignOrderController =CustomDesignOrderController.instance;
NotificationController notificationController = NotificationController.instance;
ImagePickerController imagePickerController = ImagePickerController.instance;
AdminController adminController = AdminController.instance;