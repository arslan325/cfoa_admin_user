import 'package:cfoa_fyp/Admin%20Panel/Screens/CategoriesManaged/CategoriesListed.dart';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowLoading.dart';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowToastMessage.dart';
import 'package:cfoa_fyp/Config/Shared_Prefrences.dart';
import 'package:cfoa_fyp/Models/CategoryModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class CategoryController extends GetxController {
  static CategoryController instance = Get.find();
  CollectionReference categoryReference = FirebaseFirestore.instance.collection('category');
  CollectionReference productReference = FirebaseFirestore.instance.collection('products');
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);
  String collection = "category";

  @override
  onReady() {
    super.onReady();
    categories.bindStream(getAllCategories());
  }
  Stream<List<CategoryModel>> getAllCategories() =>
      categoryReference.orderBy('Publish Date', descending: true).snapshots().map((query) =>
          query.docs.map((item) => CategoryModel.fromMap(item.data())).toList());


  //1:
  Future<void> addCategory(String categoryId , String cateTitle , String cateImg) async{
    await categoryReference.doc(categoryId).set({
      'Category Id' : categoryId,
      'Category Title' : cateTitle,
      'Category Image' : cateImg,
      'Publish Date' : DateTime.now()
    }).then((value) {
      displayToast("$cateTitle category added successfully");
      categoryId = DateTime.now().millisecondsSinceEpoch.toString();
      Get.back();
    }

    )
        .catchError((e){
      dismissibleLoading();
      displayToast("Failed to add Category: ${e.toString()}" );
    });
  }
  Future<void> updateCategory(String categoryId , String cateTitle , String cateImage , String oldCate) async{
    showLoading();
    await categoryReference.doc(categoryId).update({
      'Category Title' : cateTitle,
      'Category Image' : cateImage,
    }).then((value) {
      _updateProductsCategory(oldCate , cateTitle);
    }

    )
        .catchError((e){
      displayToast("Failed to Update Category: ${e.toString()}" );
      dismissibleLoading();
    });
  }

  Future<void> deleteCategory(CategoryModel categoryMod) async{
    Get.back();
    showLoading();
    await categoryReference.doc(categoryMod.categoryId).delete().then((value) {
      _deleteProductsCategory(categoryMod);
    }
    )
        .catchError((e){
      displayToast("Failed to Deleted Category: ${e.toString()}" );
    });
    // notifyListeners();
  }

  Future<void> _updateProductsCategory(String oldCategory , String newCategory) async{
    productReference.where("Category", isEqualTo: "$oldCategory").get().then((snapshot){
      snapshot.docs.forEach((element) {
        element.reference.update({
          'Category': newCategory
        });
      });
    }).then((value) {
      dismissibleLoading();
      displayToast("Category Updated Successfully");
      Get.back();
    }
    )..catchError((e){
      displayToast("Failed to Update Category: ${e.toString()}" );
      dismissibleLoading();
    });
    // notifyListeners();
  }
  Future<void> _deleteProductsCategory(CategoryModel categoryMod) async{
    productReference.where("Category", isEqualTo: "${categoryMod.cateTitle}").get().then((snapshot){
      snapshot.docs.forEach((element) {
        element.reference.delete();
      });
    }).then((value) {
      dismissibleLoading();
      displayToast("deleted successfully");

    }
    )..catchError((e){
      displayToast("Failed to Deleted Category: ${e.toString()}" );
      dismissibleLoading();
    });
    // notifyListeners();
  }

}