import 'package:cfoa_fyp/Admin%20Panel/Screens/AdminHome.dart';
import 'package:cfoa_fyp/Admin%20Panel/Screens/AdminProfile/EditAdminEmail.dart';
import 'package:cfoa_fyp/Admin%20Panel/Screens/AdminProfile/EditAdminProfile.dart';
import 'package:cfoa_fyp/Admin%20Panel/Screens/CategoriesManaged/CategoriesListed.dart';
import 'package:cfoa_fyp/Admin%20Panel/Screens/CustomDesignManaged/CustomDesignListed_Screen.dart';
import 'package:cfoa_fyp/Admin%20Panel/Screens/CustomDesignManaged/CustomOrders/AllCustomDesignOrderListed_screen.dart';
import 'package:cfoa_fyp/Admin%20Panel/Screens/CustomersDetailScreen.dart';
import 'package:cfoa_fyp/Admin%20Panel/Screens/OrderManaged/OrderListedInTabBar.dart';
import 'package:cfoa_fyp/Admin%20Panel/Screens/ProductManaged/ProductListed.dart';
import 'package:cfoa_fyp/Config/Shared_Prefrences.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Screens/HomeScreen/HomeBottomNavigationPages/UserProfile/ChangePasswordScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
class AdminDrawer extends StatefulWidget {
  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  bool expand =false;
  bool profileExpand = false;
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
                              adminController.adminAuthentication.value.adminProfile),
                          child:
                          adminController.adminAuthentication.value.adminProfile ==
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
                              Get.to(AdminEditProfileScreen());
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
                      adminController.adminAuthentication.value.name,
                      style: klabelStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      adminController.adminAuthentication.value.email,
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
                Icons.dashboard_rounded,
                color: kbuttonColor,
              ),
              title: Text('DashBoard'),
              onTap: () {
                Get.to(AdminHome());
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
                Get.to(ProductListedScreen());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.category,
                color: kbuttonColor,
              ),
              title: Text('Category'),
              onTap: () {
                Get.to(ListedCategories());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_bag,
                color: kbuttonColor,
              ),
              title: Text('Order'),
              onTap: () {
                Get.to(TabBarOrderListed());
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
                                Get.to(AllCustomDesignListed());
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
                                Get.to(AllCustomOrderListedScreen());
                              },
                            ),
                          ]),
                    ),
                  )
                ],
                expansionCallback: (int item, bool status) {
                  setState(() {
                    expand = !expand;
                  });
                }),
            ListTile(
              leading: Icon(
                Icons.people_rounded,
                color: kbuttonColor,
              ),
              title: Text('Customers'),
              onTap: () => Get.to(() => AllCustomersDetailScreen()),
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
                          leading: Icon(
                            Icons.person,
                            color: kbuttonColor,
                          ),
                          title: Text('Profile'),
                        ),
                      );
                    },
                    isExpanded: profileExpand,
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
                              title: Text('Change Email Address'),
                              onTap: () {
                                Get.to(EditAdminEmailScreen());
                              },
                            ),
                            ListTile(
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: kbuttonColor,
                              ),
                              title: Text('Change Password'),
                              onTap: () {
                                Get.to(ChangePasswordScreen());
                              },
                            ),
                          ]),
                    ),
                  )
                ],
                expansionCallback: (int item, bool status) {
                  setState(() {
                    profileExpand = !profileExpand;
                  });
                }),
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
          ],
        ),
      ),
    );
  }
}
