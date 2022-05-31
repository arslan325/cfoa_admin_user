import 'package:badges/badges.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/CategoryModel.dart';
import 'package:cfoa_fyp/Screens/HomeScreen/HomeBottomNavigationPages/ShopingCart/CartScreen.dart';
import 'package:cfoa_fyp/Screens/Products/Product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCategoryProducts extends StatefulWidget {
  final CategoryModel categoryModel;
  const AllCategoryProducts({this.categoryModel});
  @override
  _AllCategoryProductsState createState() => _AllCategoryProductsState();
}

class _AllCategoryProductsState extends State<AllCategoryProducts> {
  @override
  Widget build(BuildContext context) {
    print(productController.categoryProducts.length);
    return Scaffold(
        backgroundColor: kbackgroundColor,
        appBar: AppBar(
          title: Text(
            widget.categoryModel.cateTitle,
            style: klabelStyle,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: kbuttonColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          elevation: 0.5,
          backgroundColor: kbackgroundColor,
          actions: [
            Obx(
              () => Badge(
                showBadge: userController.authentication.value.cart.length > 0,
                position: BadgePosition(top: 0, end: 5),
                animationType: BadgeAnimationType.fade,
                badgeContent: Text(
                  userController.authentication.value.cart.length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: kbuttonColor,
                  ),
                  onPressed: () => Get.to(CartScreen()),
                ),
              ),
            ),
          ],
        ),
        body: Obx(() => (productController.categoryProducts.length > 0)
            ? ListView.builder(
                itemCount: productController.categoryProducts.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(ProductDetail(
                        product: productController.categoryProducts[index],
                      ));
                    },
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.5),
                                  blurRadius: 15)
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        height: 100,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                  image: NetworkImage(productController
                                      .categoryProducts[index].prodImage),
                                  fit: BoxFit.fitHeight,
                                  width: 120,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: EdgeInsets.all(7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productController
                                          .categoryProducts[index].prodTitle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            color: kbuttonColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                              child: Text(
                                            'Rs. ' +
                                                productController
                                                    .categoryProducts[index]
                                                    .prodPrice
                                                    .toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              cartController.addProductToCart(
                                                  productController
                                                      .categoryProducts[index]);
                                            },
                                            icon: Icon(
                                              Icons.add_shopping_cart,
                                              color: kbuttonColor,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  );
                })
            : Container(
                height: 200,
                child: Center(child: Text('No products contain in ${widget.categoryModel.cateTitle} category')),
              )));
  }
}
