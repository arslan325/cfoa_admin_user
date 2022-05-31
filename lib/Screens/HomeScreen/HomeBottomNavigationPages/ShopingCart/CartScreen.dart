import 'package:cfoa_fyp/Models/CartModel.dart';
import 'package:cfoa_fyp/Screens/HomeScreen/HomeScreenMain.dart';
import 'package:cfoa_fyp/Screens/PlaceOrderScreen/UserAddress_Screen.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Constant/Constant.dart';
class CartScreen extends StatefulWidget {
  final int index;
  CartScreen({this.index});
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool enable = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.index == null){
      enable = true;
    }
    else enable = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => enable,
      child: Scaffold(
        backgroundColor: kbackgroundColor,
        appBar: AppBar(
          title: Text("Cart",style: klabelStyle,),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_sharp,color: kbuttonColor,),
            onPressed: (){
              if(widget.index != null){
               return;
              }
              else
             Get.back();
            },
          ),
          centerTitle: true,
          elevation: 0.5,
          backgroundColor: kbackgroundColor,
          actions: [
            IconButton(
                onPressed: (){
                  userController.updateUserData({"cart": []});
                },
                icon: Icon(Icons.clear_all,
                  color: kbuttonColor,
                ),)
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: kbackgroundColor,
          elevation: 0,
          child: Obx(()=> (userController.authentication.value.cart.length) > 0 ?
            Container(
              height: 170,
              padding: EdgeInsets.only(left: 30,right: 30,top: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Price',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontSize: 20
                          )),
                          Text(':',style: klabelStyle,),
                          Text('${cartController.totalCartPrice} Rs' ,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kbuttonColor,
                                fontSize: 20
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40,),
                      CustomRoundedButton(
                        title: 'Buy Now',
                        clickFuction: (){
                          Get.to(ShippingAddress());
                        },
                      )

                    ],
                  )
                ],
              ),
            ):Container(
            height: 200,
          ),
          ),
        ),
        body: Obx(()=> (userController.authentication.value.cart.length) > 0 ?
           Column(
            children: [
              Expanded(
                child: ListView.builder(
                  //physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return
                      Container(
                        height: 120,
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        child: Dismissible(
                          direction: DismissDirection.endToStart,
                          key: ObjectKey(userController.authentication.value.cart.length),
                          background: Container(
                              padding: EdgeInsets.all(30),
                              color: kbuttonColor,
                              alignment: AlignmentDirectional.centerEnd,
                              child: Icon(Icons.delete,
                                color: Colors.white,
                              )),
                          onDismissed: (direction){
                            cartController.removeCartItem(userController.authentication.value.cart[index]);
                          },
                          child: Card(
                            child: Align(
                              alignment: Alignment.center,
                              child: ListTile(
                                title: Text(userController.authentication.value.cart[index].prodTitle),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 50,),
                                    InkWell(
                                        onTap: (){
                                          cartController.decreaseQuantity(userController.authentication.value.cart[index]);
                                        },
                                        child: Icon(Icons.remove_circle)),
                                    SizedBox(width: 15,),
                                    Text(userController.authentication.value.cart[index].quantity.toString(),
                                      style: TextStyle(
                                          fontSize: 16
                                      ),
                                    ),
                                    SizedBox(width: 15,),
                                    InkWell(
                                        onTap: (){
                                          cartController.increaseQuantity(userController.authentication.value.cart[index]);
                                        },
                                        child: Icon(Icons.add_circle)),
                                    SizedBox(width: 15,),
                                    Text("${userController.authentication.value.cart[index].prodPrice} Rs",
                                      style: TextStyle(
                                          color: kbuttonColor,
                                          fontSize: 16
                                      ),
                                    ),
                                  ],
                                ),
                                leading: Image(
                                  image:NetworkImage(userController.authentication.value.cart[index].prodImage),
                                  width: 100,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                  },
                  itemCount: userController.authentication.value.cart.length,
                  shrinkWrap: true,
                ),
              ),
            ],

          ): Container(
          height: 200,
            child: Center(
         child: Text('Cart is empty.',style: TextStyle(
             fontSize: 16
         ),)
        ),
          )
        ),
      ),
    );
  }
}
