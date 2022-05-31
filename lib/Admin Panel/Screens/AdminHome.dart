import 'package:cfoa_fyp/Admin%20Panel/Screens/ProductManaged/ProductListed.dart';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/AdminDrawer.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Widgets/CarooselImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'CategoriesManaged/CategoriesListed.dart';
import 'CustomDesignManaged/CustomOrders/AllCustomDesignOrderListed_screen.dart';
import 'CustomersDetailScreen.dart';
import 'OrderManaged/OrderListedInTabBar.dart';
import 'ProductManaged/AdminSearchProductScreen.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: SvgPicture.asset(
              'images/menu.svg',
              color: kbuttonColor,
              width: 20,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(AdminSearchProductScreen());
              },
              icon: Icon(
                Icons.search_outlined,
                color: kbuttonColor,
              )),
        ],
        backgroundColor: kbackgroundColor,
        elevation: 0.5,
        title: Text(
          "Gujrat Furniture",
          style: TextStyle(
              fontFamily: 'Raleway-Bold', fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
      ),
      drawer: AdminDrawer(),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(children: [
            CustomCarousel(),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => Get.to(ListedCategories()),
                          child: Container(
                              height: 150,
                              child: Card(
                                  color: Color(0xff0f2057),
                                  child: Container(
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Opacity(
                                            opacity: 0.7,
                                            child: Icon(
                                              Icons.category,
                                              size: 100,
                                              color: Colors.white10,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 30,
                                          left: 0,
                                          right: 0,
                                          child: Column(
                                            //  crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                categoryController
                                                    .categories.length
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Total Categories',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              height: 35,
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'View more info',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CircleAvatar(
                                                    radius: 13,
                                                    backgroundColor:
                                                        Color(0xff0f2057),
                                                    child: Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ))
                                      ],
                                    ),
                                  ))),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => Get.to(ProductListedScreen()),
                          child: Container(
                              height: 150,
                              child: Card(
                                  color: Colors.teal,
                                  child: Container(
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Opacity(
                                            opacity: 0.9,
                                            child: SvgPicture.asset(
                                              'images/product.svg',
                                              color: Colors.black12,
                                              width: 100,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 30,
                                          left: 0,
                                          right: 0,
                                          child: Column(
                                            //  crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                productController
                                                    .products.length
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Total Products',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              height: 35,
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'View more info',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CircleAvatar(
                                                    radius: 13,
                                                    backgroundColor:
                                                        Colors.teal,
                                                    child: Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ))
                                      ],
                                    ),
                                  ))),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => AllCustomersDetailScreen());
                    },
                    child: Container(
                        height: 150,
                        child: Card(
                          color: Colors.amberAccent,
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        userController.allCustomers.length
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Total Customers',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  )),
                                  Expanded(
                                    child: Icon(
                                      Icons.supervised_user_circle,
                                      size: 120,
                                      color: Colors.black12,
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 40,
                                    color: Colors.black.withOpacity(0.4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'View more info',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        CircleAvatar(
                                          radius: 13,
                                          backgroundColor: Colors.amberAccent,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.black,
                                            size: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: () => Get.to(() => TabBarOrderListed()),
                    child: Container(
                        height: 150,
                        child: Card(
                          color: kbuttonColor,
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        orderController.allOrders.length
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Total Orders',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  )),
                                  Expanded(
                                    child: Icon(
                                      Icons.shopping_bag,
                                      size: 120,
                                      color: Colors.black12,
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 40,
                                    color: Colors.black.withOpacity(0.4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'View more info',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        CircleAvatar(
                                          radius: 13,
                                          backgroundColor: kbuttonColor,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: () => Get.to(() => AllCustomOrderListedScreen()),
                    child: Container(
                        height: 150,
                        child: Card(
                          color: Colors.redAccent,
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          customDesignOrderController.allCustomOrders.length
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Total Custom Design Orders',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: SvgPicture.asset(
                                      'images/order.svg',
                                      color: Colors.black12,
                                      width: 100,
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 40,
                                    color: Colors.black.withOpacity(0.4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'View more info',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        CircleAvatar(
                                          radius: 13,
                                          backgroundColor: Colors.redAccent,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
