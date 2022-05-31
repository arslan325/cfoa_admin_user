import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/CategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:cfoa_fyp/Models/Product_Model.dart';
import 'package:get/get.dart';
class RemoveList with ChangeNotifier{
  Future<void> showProductAlert(ProductModel productModel, int index) async{
    Get.defaultDialog(
      title: 'Are you sure you want to delete it?',
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaterialButton(onPressed: (){Get.back();},
              child: Text("Cancel",style: TextStyle(
                  fontSize: 16
              ),),
            ),
            MaterialButton(onPressed:(){ productController.deleteProduct(productModel).whenComplete(() {
              productController.searchProductList.removeAt(index);
              notifyListeners();
            });
            },
              child: Text("Delete",style: TextStyle(
                  color: Colors.red,
                  fontSize: 16
              ),),
            ),
          ],
        ),
      ),
    );
  }
}


showCategoryAlert(CategoryModel categoryModel){
  Get.defaultDialog(
    title: 'Are you sure you want to delete it?',
    content: Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MaterialButton(onPressed: (){Get.back();},
            child: Text("Cancel",style: TextStyle(
                fontSize: 16
            ),),
          ),
          MaterialButton(onPressed:(){ categoryController.deleteCategory(categoryModel);
          },
            child: Text("Delete",style: TextStyle(
                color: Colors.red,
                fontSize: 16
            ),),
          ),
        ],
      ),
    ),
  );
}
showOrderDeleteAlert(String orderId){
  Get.defaultDialog(
    title: 'Are you sure you want to delete it?',
    content: Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MaterialButton(onPressed: (){Get.back();},
            child: Text("Cancel",style: TextStyle(
                fontSize: 16
            ),),
          ),
          MaterialButton(onPressed:(){
            orderController.deleteOrder(orderId).whenComplete(() {
              Get.back();
            });
          },
            child: Text("Delete",style: TextStyle(
                color: Colors.red,
                fontSize: 16
            ),),
          ),
        ],
      ),
    ),
  );
}
showCustomDesignDeleteAlert(String designId){
  Get.defaultDialog(
    title: 'Are you sure you want to delete it?',
    content: Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MaterialButton(onPressed: (){Get.back();},
            child: Text("Cancel",style: TextStyle(
                fontSize: 16
            ),),
          ),
          MaterialButton(onPressed:(){
            customDesignController.deleteCustomDesign(designId).whenComplete(() => {
              Get.back()
            });
          },
            child: Text("Delete",style: TextStyle(
                color: Colors.red,
                fontSize: 16
            ),),
          ),
        ],
      ),
    ),
  );
}

showCustomOrderDeleteAlert(String customOrderId){
  Get.defaultDialog(
    title: 'Are you sure you want to delete it?',
    content: Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MaterialButton(onPressed: (){Get.back();},
            child: Text("Cancel",style: TextStyle(
                fontSize: 16
            ),),
          ),
          MaterialButton(onPressed:(){
            customDesignOrderController.deleteCustomOrder(customOrderId);
          },
            child: Text("Delete",style: TextStyle(
                color: Colors.red,
                fontSize: 16
            ),),
          ),
        ],
      ),
    ),
  );
}

void showPaymentFailedAlert() {
  Get.defaultDialog(
      content: Text(
        "Payment failed, try another card",
      ),
      actions: [
        GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Okay",
              ),
            ))
      ]);
}