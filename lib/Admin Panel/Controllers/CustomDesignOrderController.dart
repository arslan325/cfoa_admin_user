import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowAlert.dart';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowLoading.dart';
import 'package:cfoa_fyp/Config/Shared_Prefrences.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/CustomDesignOrderModel.dart';
import 'package:cfoa_fyp/Screens/CustomDesign/CustomDesignOrder/CustomOrderListedScreen.dart';
import 'package:cfoa_fyp/Screens/PlaceOrderScreen/OrderPlacedSuccessfully.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stripe_payment/stripe_payment.dart';

class CustomDesignOrderController extends GetxController {
  static CustomDesignOrderController instance = Get.find();
  String collection = "Custom Design Orders";
  String designId = '';
  String url =
      'https://us-central1-cfoa-gujratfurniture.cloudfunctions.net/createPaymentIntent';
  RxList<CustomDesignOrder> activeCustomOrders = RxList<CustomDesignOrder>([]);
  RxList<CustomDesignOrder> allCustomOrders = RxList<CustomDesignOrder>([]);
  @override
  void onReady() {
    super.onReady();
    allCustomOrders.bindStream(getAllCustomOrders());
    StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_test_51IC5hFDVumpVEunre4MJZ9EWxSiVl46GnzAF7A2dOHu20iNYsv7R5p6MkOsWQekEsYuCKAJPevtWaibnWr3OwCB100Kir0Oehw",
        androidPayMode: 'test'));
  }

  Future<void> createPaymentMethodForCustomOrder(String selectedPaymentMethod) async {
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
        ? processPaymentForCustomOrder(paymentMethod,selectedPaymentMethod)
        : showPaymentFailedAlert();
  }

  Future<void> processPaymentForCustomOrder(PaymentMethod paymentMethod, String selectedMethod) async {
    showLoading();
    int amount = (double.parse(customDesignController.totalPrice.toStringAsFixed(2)) * 100).toInt();
    //step 2: request to create PaymentIntent, attempt to confirm the payment & return PaymentIntent
    final response = await Dio()
        .post('$url?amount=$amount&currency=USD&pm_id=${paymentMethod.id}');
    print('Now i decode');
    if (response.data != null && response.data != 'error') {
      final paymentIntentX = response.data;
      final status = paymentIntentX['paymentIntent']['status'];
      if (status == 'succeeded') {
        StripePayment.completeNativePayRequest();
        placeCustomOrder(paymentStatus: status,paymentMethod: selectedMethod);
      }else{
        placeCustomOrder(paymentStatus: status , paymentMethod: selectedMethod);
      }
    } else {
      //case A
      StripePayment.cancelNativePayRequest();
      dismissibleLoading();
      showPaymentFailedAlert();
    }
  }



  Future<void> placeCustomOrder({String paymentStatus, String paymentMethod}) async{
    showLoading();
    String customOrderId = DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseFirestore.instance.collection(collection).doc(customOrderId).set({
      "Custom Order Id": customOrderId,
      "Customer Id": userController.authentication.value.uid,
      "Payment Status": paymentStatus,
      "Custom Order Status": 'pending',
      "Payment Method": paymentMethod,
      "Custom Design Item": customDesignController.customDesignItemsToJson(),
      "Shipping Address": addressModel.addressItemsToJson(),
      "Total Amount": customDesignController.totalPrice.toStringAsFixed(2),
      "Order On": DateTime.now(),
    }).then((value) => {
      dismissibleLoading(),
      Get.off(OrderPlacedSuccessfullyScreen()),
      customDesignController.deleteCustomDesign(designId),
    });
  }
  Stream<List<CustomDesignOrder>> _getActiveCustomOrders() =>
      FirebaseFirestore.instance.collection(collection).where("Customer Id", isEqualTo: userController.authentication.value.uid).orderBy('Order On', descending: true).snapshots().map((
          query) =>
          query.docs.map((item) => CustomDesignOrder.fromMap(item.data())).toList());

  getActiveCustomDesignOrders(){
    showLoading();
    activeCustomOrders.clear();
    activeCustomOrders.bindStream(_getActiveCustomOrders());
    dismissibleLoading();
   Get.to(() => CustomDesignOrderListed());
  }

  Stream<List<CustomDesignOrder>> getAllCustomOrders() =>
      FirebaseFirestore.instance.collection(collection).orderBy('Order On',descending: true).snapshots().map((
          query) =>
          query.docs.map((item) => CustomDesignOrder.fromMap(item.data())).toList());


  Future<void> updateCustomOrderData(Map<String, dynamic> data ,  CustomDesignOrder customDesignOrder , String newStatus) async{
    logger.i("UPDATED");
    await FirebaseFirestore.instance.collection(collection)
        .doc(customDesignOrder.customOrderId)
        .update(data).then((value) {
      notificationController.getFCMToken(customDesignOrder.customerId);
      String date = DateFormat.yMMMMEEEEd().format(customDesignOrder.orderOn.toDate());
      notificationController.sendNotification('Order Status Updated',
        'Your order ID "${'${customDesignOrder.customOrderId}'}" that you placed on "${'$date'}" has been "${'$newStatus'}" . Soon you will received your order, please wait for it.',
        SharedPreferencesData.sharedPreferences.getString(SharedPreferencesData.deviceFCMTargetToken),
        //  orderModel.cart.first['Product Image']
      );
    });;
    authentication.displayToast('Custom Order status updated successfully');
    //Get.off(TabBarOrderListed());
  }

  Future<void> deleteCustomOrder(String orderId) async{
    Get.back();
    showLoading();
    await FirebaseFirestore.instance.collection(collection).doc(orderId)
        .delete()
        .then((value) {}).catchError((e){
      dismissibleLoading();
      authentication.displayToast("Failed to Deleted Custom Order: ${e.toString()}" );
    });
    authentication.displayToast('Custom Order deleted successfully');
    dismissibleLoading();
  }
}