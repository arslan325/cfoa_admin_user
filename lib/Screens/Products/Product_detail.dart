import 'package:badges/badges.dart';
import 'package:cfoa_fyp/Models/CartModel.dart';
import 'package:cfoa_fyp/Models/Product_Model.dart';
import 'package:cfoa_fyp/Screens/HomeScreen/HomeBottomNavigationPages/ShopingCart/CartScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '/Constant/Constant.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';

class ProductDetail extends StatefulWidget {
 final ProductModel product;
  const ProductDetail({this.product});
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    final width= MediaQuery.of(context).size.width;
    final height= MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        backgroundColor: kbackgroundColor,
        elevation: 0.5,
        title: Text(
          'Product Detail',
          style: klabelStyle,
        ),
        centerTitle: true,
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
      ),
      bottomNavigationBar: BottomAppBar(
        child:
            Container(
              height:60,
              child: MaterialButton(
                onPressed: (){
                  cartController.addProductToCart(widget.product);
                },
                child:
                Align(
                  alignment: Alignment.center,
                    child: Text('Add to Cart', style:
                    TextStyle(
                        color: kbuttonColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    )
                      ,)),
              ),
            ),
      ),
      body:
          Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Image(
                    image: NetworkImage(widget.product.prodImage),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  child: ListView(
                    //physics: NeverScrollableScrollPhysics(),
                    children: [
                      SizedBox(height: 15,),
                      Center(
                        child: Text(widget.product.categoryName,style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kbuttonColor,
                            fontSize: 18

                        ),),
                      ),
                      SizedBox(height: 10,),
                      ListTile(
                        title: Text(widget.product.prodTitle,style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18

                        ),),
                        trailing: Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                            color: kbuttonColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Text(
                                'Rs. ' + widget.product.prodPrice.toString(),
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                      ListTile(
                        title: Text("Description",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),),
                        subtitle: Text(widget.product.prodDetail,
                          // textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 16
                          ),),
                      ),
                      SizedBox(height: 15,),
                    ],
                  )
                  ),
              ),
            ],
          )
          );
  }
}
