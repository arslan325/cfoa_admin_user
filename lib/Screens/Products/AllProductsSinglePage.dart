import 'package:badges/badges.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Screens/HomeScreen/HomeBottomNavigationPages/ShopingCart/CartScreen.dart';
import 'package:cfoa_fyp/Screens/Products/Product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProductsListedInSingleScreen extends StatefulWidget {
  @override
  _AllProductsListedInSingleScreenState createState() =>
      _AllProductsListedInSingleScreenState();
}

class _AllProductsListedInSingleScreenState
    extends State<AllProductsListedInSingleScreen> {
  @override
  Widget build(BuildContext context) {
    print(productController.categoryProducts.length);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final double itemHeight = (height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = width / 2;
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        backgroundColor: kbackgroundColor,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: kbuttonColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          Obx(()=>
              Badge(
                showBadge: userController.authentication.value.cart.length > 0,
                position: BadgePosition(top: 0,end:5 ),
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
        title: Text(
          "Products",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Obx(
              () =>
              ListView.builder(
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    return
                      InkWell(
                        onTap: (){
                          Get.to(ProductDetail(product: productController.products[index],));
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(.5), blurRadius: 15)
                                ],
                                borderRadius: BorderRadius.circular(10), color: Colors.white),
                            height: 100,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      image: NetworkImage(productController.products[index].prodImage),
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
                                          productController.products[index].prodTitle,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 20,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                color: kbuttonColor,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                    'Rs. ' + productController.products[index].prodPrice.toString(),
                                                    style: TextStyle(color: Colors.white),
                                                  )),
                                            ),
                                            IconButton(
                                                onPressed: (){
                                                  cartController.addProductToCart(productController.products[index]);
                                                }
                                                , icon: Icon(Icons.add_shopping_cart,
                                              color: kbuttonColor,
                                            )
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),
                      );
                  }),
        ),
      ),
    );
  }
}
