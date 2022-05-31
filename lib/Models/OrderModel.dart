import 'package:cloud_firestore/cloud_firestore.dart';
class OrderModel {
  static const ORDER_ID = "Order Id";
  static const Customer_ID = "Customer Id";
  static const CART = "cart";
  static const AMOUNT = "Total Amount";
  static const PaymentSTATUS = "Payment Status";
  static const OrderSTATUS = "Order Status";
  static const PaymentMETHOD = "Payment Method";
  static const ORDER_ON = "Order On";
  static const SHIPPING_ADDRESS = "Shipping Address";

  String orderId;
  String totalAmount;
  String orderStatus;
  String paymentStatus;
  String paymentMethod;
  String customerId;
  Timestamp orderOn;
  List cart;
  List shippingAddress;

  OrderModel({this.orderId,
    this.totalAmount,
    this.orderStatus,
    this.paymentStatus,
    this.customerId,
    this.paymentMethod,
    this.orderOn,
    this.cart,
    this.shippingAddress
  });

  OrderModel.fromMap(Map data){
    orderId = data[ORDER_ID];
    customerId = data[Customer_ID];
    orderOn = data[ORDER_ON];
    orderStatus = data[OrderSTATUS];
    paymentStatus = data[PaymentSTATUS];
    paymentMethod = data[PaymentMETHOD];
    totalAmount = data[AMOUNT];
    cart = data[CART];
    shippingAddress = data[SHIPPING_ADDRESS];
  }
}