import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowLoading.dart';
import 'package:cfoa_fyp/Config/Shared_Prefrences.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/CustomDesignModel.dart';
import 'package:cfoa_fyp/Screens/CustomDesign/CustomDesignListed.dart';
import 'package:cfoa_fyp/Screens/PlaceOrderScreen/UserAddress_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CustomDesignController extends GetxController {
  static CustomDesignController instance = Get.find();
  CollectionReference designReference = FirebaseFirestore.instance.collection('Custom Design');
  RxList<CustomDesignModel> activeCustomDesigns = RxList<CustomDesignModel>([]);
  RxList<CustomDesignModel> allDesigns = RxList<CustomDesignModel>([]);
  @override
  onReady() {
    super.onReady();
    allDesigns.bindStream(getAllDesigns());
  }
  Stream<List<CustomDesignModel>> getAllDesigns() =>
      designReference.orderBy('Publish Date', descending: true).snapshots().map((
          query) =>
          query.docs.map((item) => CustomDesignModel.fromMap(item.data())).toList());

  Stream<List<CustomDesignModel>> _getActiveCustomerDesign() =>
      designReference.where("Customer Id", isEqualTo: userController.authentication.value.uid).orderBy('Publish Date', descending: true).snapshots().map((
          query) =>
          query.docs.map((item) => CustomDesignModel.fromMap(item.data())).toList());

  getActiveCustomerDesign(){
    showLoading();
    activeCustomDesigns.bindStream(_getActiveCustomerDesign());
    dismissibleLoading();
    Get.to(() => CustomOrderListed());
  }
  double totalPrice = 0.0;
  List<CustomDesignModel> selectedDesignList =[];
  selectedDesign(CustomDesignModel customDesignModel , double price){
    totalPrice =price;
    selectedDesignList.clear();
    userController.updateUserData({"cart": []});
    selectedDesignList.add(customDesignModel);
    Get.to(ShippingAddress());
  }
  List customDesignItemsToJson() => selectedDesignList.map((item) => item.toJsonMap()).toList();

  Future<void> addCustomDesign(String designId , String designTitle , String designImage , designDescription) async{
    await designReference.doc(designId).set({
      CustomDesignModel.DesignID : designId,
      CustomDesignModel.DesignTITLE : designTitle,
      CustomDesignModel.DesignIMAGE : designImage,
      CustomDesignModel.DesignDESCRIPTION : designDescription,
      "Customer Id": userController.authentication.value.uid,
      CustomDesignModel.DesignSTATUS:'not accepted',
      'Publish Date' : DateTime.now()
    }).then((value) {
      authentication.displayToast("$designTitle design added successfully");
      Get.back();
    }
    )
        .catchError((e){
      dismissibleLoading();
      authentication.displayToast("Failed to add design: ${e.toString()}" );
    });
  }
  Future<void> updateCustomDesign(String designId , String designTitle ,  String designImage , String designDescription) async{
    showLoading();
    await designReference.doc(designId).update({
      CustomDesignModel.DesignTITLE:designTitle,
      CustomDesignModel.DesignDESCRIPTION:designDescription,
      CustomDesignModel.DesignIMAGE:designImage
    }).then((value) {
      authentication.displayToast("$designTitle design data updated successfully");
      dismissibleLoading();
      Get.back();
    }

    )
        .catchError((e){
      dismissibleLoading();
      authentication.displayToast("Failed to Update design data: ${e.toString()}" );
    });
  }


  deleteCustomDesign(String designId) async{
    showLoading();
    await designReference.doc(designId)
        .delete()
        .then((value) {}).catchError((e){
      dismissibleLoading();
      authentication.displayToast("Failed to Deleted Design: ${e.toString()}" );
    });
    dismissibleLoading();
    authentication.displayToast('Design deleted successfully');
  }

  Future<void> updateCustomDesignStatus(Map<String, dynamic> data ,  CustomDesignModel customDesignModel) async{
    logger.i("UPDATED");
    await designReference
        .doc(customDesignModel.designId)
        .update(data).then((value) {
      notificationController.getFCMToken(customDesignModel.customerId);
      notificationController.sendNotification('Design Accepted',
          'Your Design "${'${customDesignModel.designTitle}'}" has been accepted by the admin. please check the details and proceed your orders.',
          SharedPreferencesData.sharedPreferences.getString(SharedPreferencesData.deviceFCMTargetToken),
        //customDesignModel.designImage
      );
      authentication.displayToast('Custom design data updated successfully');
    });
  }



}