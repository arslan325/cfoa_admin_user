import 'package:cloud_firestore/cloud_firestore.dart';
class CustomDesignOrder{
  static const ORDER_ID = "Custom Order Id";
  static const Design_Item = "Custom Design Item";
  static const AMOUNT = "Total Amount";
  static const PaymentSTATUS = "Payment Status";
  static const OrderSTATUS = "Custom Order Status";
  static const PaymentMETHOD = "Payment Method";
  static const Customer_ID = "Customer Id";
  static const ORDER_ON = "Order On";
  static const SHIPPING_ADDRESS = "Shipping Address";

  String customOrderId;
  String totalAmount;
  String customOrderStatus;
  String paymentStatus;
  String customerId;
  String paymentMethod;
  Timestamp orderOn;
  List designItem;
  List shippingAddress;

  CustomDesignOrder({this.customOrderId,
    this.totalAmount,
    this.customOrderStatus,
    this.paymentStatus,
    this.customerId,
    this.paymentMethod,
    this.orderOn,
    this.designItem,
    this.shippingAddress
  });

  CustomDesignOrder.fromMap(Map data){
    customOrderId = data[ORDER_ID];
    orderOn = data[ORDER_ON];
    customOrderStatus = data[OrderSTATUS];
    paymentStatus = data[PaymentSTATUS];
    customerId = data[Customer_ID];
    paymentMethod = data[PaymentMETHOD];
    totalAmount = data[AMOUNT];
    designItem = data[Design_Item];
    shippingAddress = data[SHIPPING_ADDRESS];
  }
}