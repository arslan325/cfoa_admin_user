import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowLoading.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/CategoryModel.dart';
import 'package:cfoa_fyp/Models/Product_Model.dart';
import 'package:cfoa_fyp/Screens/Categories/AllCategoryProducts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:algolia/algolia.dart';
import 'package:cfoa_fyp/Models/AlgoliaSearchProduct.dart';
class ProductController extends GetxController {
  static ProductController instance = Get.find();
  CollectionReference productReference = FirebaseFirestore.instance.collection('products');
  RxList<ProductModel> products = RxList<ProductModel>([]);
  RxList<ProductModel> categoryProducts = RxList<ProductModel>([]);
  RxList<ProductModel> searchProductList = <ProductModel>[].obs;
  RxBool loading = true.obs;
  @override
  onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
  }

  Stream<List<ProductModel>> getAllProducts() =>
    productReference.orderBy('Publish Date', descending: true).snapshots().map((
        query) =>
        query.docs.map((item) => ProductModel.fromMap(item.data())).toList());

  Future<void> getCategoryProducts(CategoryModel categoryMod) async{
    categoryProducts.clear();
   await productReference.where("Category",isEqualTo:  "${categoryMod.cateTitle}").
    get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        categoryProducts.add(ProductModel.fromMap(doc.data()));
      });
    });
    Get.to(AllCategoryProducts(categoryModel: categoryMod,));
  }

  Future<void> addProduct(String prodId , String prodTitle , String cateName , String prodImage , String prodDetail , double prodPrice) async{
    await productReference.doc(prodId).set({
      ProductModel.ProdID : prodId,
      ProductModel.CatName : cateName,
      ProductModel.ProdTITLE : prodTitle,
      ProductModel.ProductDESCRIPTION : prodDetail,
      ProductModel.ProdIMAGE : prodImage,
      ProductModel.ProdQUANTITY :1,
      ProductModel.ProdPRICE : prodPrice.toDouble(),
      'Publish Date' : DateTime.now()
    }).then((value) {
      authentication.displayToast("$prodTitle Product added successfully");
      prodId = DateTime.now().millisecondsSinceEpoch.toString();
      Get.back();
    }
    )
        .catchError((e){
      dismissibleLoading();
      authentication.displayToast("Failed to add Product: ${e.toString()}" );
    });
    //notifyListeners();
  }
  Future<void> updateProduct(String prodId , String prodTitle , String cateName , String prodImage , String prodDetail , double prodPrice ) async{
    showLoading();
    await productReference.doc(prodId).update({
      ProductModel.ProdTITLE : prodTitle,
      ProductModel.CatName : cateName,
      ProductModel.ProdIMAGE : prodImage,
      ProductModel.ProductDESCRIPTION : prodDetail,
      ProductModel.ProdPRICE : prodPrice,
    }).then((value) {
      authentication.displayToast("$prodTitle product Updated successfully");
      dismissibleLoading();
      Get.back();
    }

    )
        .catchError((e){
      dismissibleLoading();
      authentication.displayToast("Failed to Update Product: ${e.toString()}" );
    });
    // notifyListeners();
  }
  Future<void> deleteProduct(ProductModel productModel) async{
    Get.back();
    showLoading();
    await productReference.doc(productModel.prodId).delete().then((value) {
      authentication.displayToast("${productModel.prodTitle} deleted successfully");
      dismissibleLoading();
    }
    )
        .catchError((e){
      authentication.displayToast("Failed to Deleted Product: ${e.toString()}" );
      dismissibleLoading();
    });
  }


  final Algolia _algoliaApp = SearchProduct.algolia;
  Future<void> searchProducts(String input) async {
    searchProductList.clear();
    AlgoliaQuery query = _algoliaApp.instance.index("Products").query(input);
    var querySnap = await query.getObjects().then((value) {
      value.hits.forEach((element) {
        searchProductList.add(ProductModel.fromMap(element.data));
      });
    });
  }







}