import 'package:cfoa_fyp/Admin%20Panel/Screens/OrderManaged/OrderListedInTabBar.dart';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowAlert.dart';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowLoading.dart';
import 'package:cfoa_fyp/Config/Shared_Prefrences.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/OrderModel.dart';
import 'package:cfoa_fyp/Screens/Orders/CustomerOrderListed_Screen.dart';
import 'package:cfoa_fyp/Screens/PlaceOrderScreen/OrderPlacedSuccessfully.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stripe_payment/stripe_payment.dart';
class OrderController extends GetxController {
  static OrderController instance = Get.find();
  String collection = "Orders";
  String url =
      'https://us-central1-cfoa-gujratfurniture.cloudfunctions.net/createPaymentIntent';
  RxList<OrderModel> activeOrders = RxList<OrderModel>([]);
  RxList<OrderModel> allOrders = RxList<OrderModel>([]);
  RxList<OrderModel> completedOrders = RxList<OrderModel>([]);
  @override
  void onReady() {
    super.onReady();
    allOrders.bindStream(getAllOrders());
    completedOrders.bindStream(getAllCompletedOrders());
    StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_test_51IC5hFDVumpVEunre4MJZ9EWxSiVl46GnzAF7A2dOHu20iNYsv7R5p6MkOsWQekEsYuCKAJPevtWaibnWr3OwCB100Kir0Oehw",
        androidPayMode: 'test'));
  }

  Future<void> createPaymentMethod(String selectedPaymentMethod) async {
    StripePayment.setStripeAccount(null);
    //step 1: add card
    PaymentMethod paymentMethod = PaymentMethod();
    paymentMethod = await StripePayment.paymentRequestWithCardForm(
      CardFormPaymentRequest(),
    ).then((PaymentMethod paymentMethod) {
      return paymentMethod;
    }).catchError((e) {
      print('Error Card: ${e.toString()}');
    });
    paymentMethod != null
        ? processPayment(paymentMethod,selectedPaymentMethod)
        : showPaymentFailedAlert();
  }

  Future<void> processPayment(PaymentMethod paymentMethod, String selectedMethod) async {
    showLoading();
    int amount = (double.parse(cartController.totalCartPrice.value.toStringAsFixed(2)) * 100).toInt();
    //step 2: request to create PaymentIntent, attempt to confirm the payment & return PaymentIntent
    final response = await Dio()
        .post('$url?amount=$amount&'
        'currency=PKR&'
        'pm_id=${paymentMethod.id}');
    print('Now i decode');
    if (response.data != null && response.data != 'error') {
      final paymentIntentX = response.data;
      final status = paymentIntentX['paymentIntent']['status'];
      if (status == 'succeeded') {
        StripePayment.completeNativePayRequest();
        placeOrder(paymentStatus: status,paymentMethod: selectedMethod);
      }else{
        placeOrder(paymentStatus: status , paymentMethod: selectedMethod);
      }
    } else {
      //case A
      StripePayment.cancelNativePayRequest();
      dismissibleLoading();
      showPaymentFailedAlert();
    }
  }

 Future<void> placeOrder({String paymentStatus, String paymentMethod}) async{
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseFirestore.instance.collection(collection).doc(orderId).set({
      "Order Id": orderId,
      "Customer Id": userController.authentication.value.uid,
      "Payment Status": paymentStatus,
      "Order Status": 'pending',
      "Payment Method": paymentMethod,
      "cart": userController.authentication.value.cartItemsToJson(),
      "Shipping Address": addressModel.addressItemsToJson(),
      "Total Amount": cartController.totalCartPrice.value.toStringAsFixed(2),
      "Order On": DateTime.now(),
    }).then((value) => {
    userController.updateUserData({"cart": []}),
      dismissibleLoading(),
      Get.off(OrderPlacedSuccessfullyScreen()),
    });
  }
  Stream<List<OrderModel>> _getActiveOrders() =>
      FirebaseFirestore.instance.collection(collection).where("Customer Id", isEqualTo: userController.authentication.value.uid).orderBy('Order On', descending: true).snapshots().map((
          query) =>
          query.docs.map((item) => OrderModel.fromMap(item.data())).toList());

  getActiveCustomerOrders(){
    showLoading();
    activeOrders.clear();
    activeOrders.bindStream(_getActiveOrders());
    dismissibleLoading();
    Get.to(() => OrderListed());
  }
  
  Stream<List<OrderModel>> getAllOrders() =>
      FirebaseFirestore.instance.collection(collection).orderBy('Order On',descending: true).snapshots().map((
          query) =>
          query.docs.map((item) => OrderModel.fromMap(item.data())).toList());
  Stream<List<OrderModel>> getAllCompletedOrders() =>
      FirebaseFirestore.instance.collection(collection).orderBy('Order On',descending: true).where('Order Status',isEqualTo:  'received').snapshots().map((
          query) =>
          query.docs.map((item) => OrderModel.fromMap(item.data())).toList());


 Future<void> updateOrder(Map<String, dynamic> data ,  OrderModel orderModel, String newStatus) async{
    logger.i("UPDATED");
   await FirebaseFirestore.instance.collection(collection)
        .doc(orderModel.orderId)
        .update(data).then((value) {
     notificationController.getFCMToken(orderModel.customerId);
     String date = DateFormat.yMMMMEEEEd().format(orderModel.orderOn.toDate());
     notificationController.sendNotification('Order Status Updated',
         'Your order ID "${'${orderModel.orderId}'}" that you placed on "${'$date'}" has been "${'$newStatus'}" . Soon you will received your order, please wait for it.',
         SharedPreferencesData.sharedPreferences.getString(SharedPreferencesData.deviceFCMTargetToken),
       //  orderModel.cart.first['Product Image']
     );
   });
    authentication.displayToast('Order status updated successfully');
  }

  Future<void> deleteOrder(String orderId) async{
    Get.back();
    showLoading();
    await FirebaseFirestore.instance.collection(collection).doc(orderId)
        .delete()
        .then((value) {}).catchError((e){
          dismissibleLoading();
      authentication.displayToast("Failed to Deleted Order: ${e.toString()}" );
    });
    authentication.displayToast('Order deleted successfully');
    dismissibleLoading();
  }
}


