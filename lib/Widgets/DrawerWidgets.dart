import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Screens/Categories/AllCategoriesInSinglePage.dart';
import 'package:cfoa_fyp/Screens/HomeScreen/HomeBottomNavigationPages/ShopingCart/CartScreen.dart';
import 'package:cfoa_fyp/Screens/HomeScreen/HomeBottomNavigationPages/UserProfile/EditProfileScreen.dart';
import 'package:cfoa_fyp/Screens/HomeScreen/HomeBottomNavigationPages/UserProfile/UserProfileScreen.dart';
import 'package:cfoa_fyp/Screens/Products/AllProductsSinglePage.dart';
import 'package:cfoa_fyp/Screens/Products/SearchProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool expand = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Obx(()=>
         ListView(
          children: [
            Container(
              height: 210,
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: kbackgroundColor,
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              userController.authentication.value.userProfile),
                          child:
                              userController.authentication.value.userProfile ==
                                      null
                                  ? Icon(
                                      Icons.person_rounded,
                                      size: 80,
                                      color: Colors.black12,
                                    )
                                  : null,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: InkWell(
                            onTap: (){
                              Get.to(EditProfileScreen());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80),
                                  border: Border.all(color: Colors.white,
                                      width: 2
                                  )
                              ),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: kbuttonColor,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      userController.authentication.value.name,
                      style: klabelStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      userController.authentication.value.email,
                      style: TextStyle(
                        color: kbuttonColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.search_outlined,
                color: kbuttonColor,
              ),
              title: Text('Search'),
              onTap: () {
                Get.to(() => SearchProductScreen());
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                'images/product.svg',
                color: kbuttonColor,
                width: 25,
              ),
              title: Text('Product'),
              onTap: () {
                Get.to(() => AllProductsListedInSingleScreen());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.category,
                color: kbuttonColor,
              ),
              title: Text('Category'),
              onTap: () {
                Get.to(() => AllCategoriesListedInSinglePage());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_cart,
                color: kbuttonColor,
              ),
              title: Text('Shopping Cart'),
              onTap: () {
                Get.to(() => CartScreen());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_bag,
                color: kbuttonColor,
              ),
              title: Text('Order'),
              onTap: () {
                orderController.getActiveCustomerOrders();
              },
            ),
            ExpansionPanelList(
                elevation: 0,
                animationDuration: Duration(milliseconds: 1000),
                children: [
                  ExpansionPanel(
                    backgroundColor: Colors.white10,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Container(
                        child: ListTile(
                          leading: SvgPicture.asset(
                            'images/order.svg',
                            color: kbuttonColor,
                            width: 25,
                          ),
                          title: Text('Custom Design'),
                        ),
                      );
                    },
                    isExpanded: expand,
                    body: Container(
                      padding: EdgeInsets.only(left: 30,right: 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: kbuttonColor,
                              ),
                              title: Text('Custom Designs Listed'),
                              onTap: () {
                                customDesignController.getActiveCustomerDesign();
                              },
                            ),
                            ListTile(
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: kbuttonColor,
                              ),
                              title: Text('Custom Orders'),
                              onTap: () {
                                customDesignOrderController.getActiveCustomDesignOrders();
                              },
                            ),
                          ]),
                    ),
                  ),
                ],
                expansionCallback: (int item, bool status) {
                  setState(() {
                    expand = !expand;
                  });
                }),
            ListTile(
              leading: Icon(
                Icons.person,
                color: kbuttonColor,
              ),
              title: Text('Profile'),
              onTap: () {
                Get.to(UserProfileScreen());
              },
            ),
            Divider(
              thickness: 1,
              endIndent: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: kbuttonColor,
              ),
              title: Text('Logout'),
              onTap: () {
                userController.signOut();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.details,
                color: kbuttonColor,
              ),
              title: Text('About'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
