import 'package:badges/badges.dart';
import 'package:cfoa_fyp/Screens/Products/SearchProductScreen.dart';
import 'package:circle_bottom_navigation/widgets/tab_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Constant/Constant.dart';
import '/Screens/ForgotPassword_screen.dart';
import '/Screens/Signup_Screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:circle_bottom_navigation/circle_bottom_navigation.dart';
import '/Widgets/DrawerWidgets.dart';
import 'HomeBottomNavigationPages/HomeBody.dart';
import 'HomeBottomNavigationPages/ShopingCart/CartScreen.dart';
import 'HomeBottomNavigationPages/UserProfile/UserProfileScreen.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationController.updateFCMDeviceToken();
  }
  final PageController _pageController = PageController();
  int _indexSelect = 0;
  bool _showAppBar = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showAppBar? AppBar(
        backgroundColor: kbackgroundColor,
        elevation: 0.5,
        title: Text(
          "Gujrat Furniture",
          style: TextStyle(
              fontFamily: 'Raleway-Bold',
              fontSize: 20,
              color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(SearchProductScreen());
              },
              icon: Icon(
                Icons.search_outlined,
                color: kbuttonColor,
              )),
        ],
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
      ): PreferredSize(
        child: Container(),
        preferredSize: Size(0.0, 0.0),
      ),
      drawer: DrawerWidget(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _indexSelect,
        selectedItemColor: kbuttonColor,
        unselectedItemColor: Colors.black54,
        onTap: (index) {
        setState(() {
          _indexSelect = index;
        });
        if(_indexSelect == 0){
          setState(() {
            _showAppBar = true;
          });
        }
        else{
          setState(() {
            _showAppBar = false;
          });
        }
        _pageController.jumpToPage(index);
      },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Obx(()=>
             Badge(
                 showBadge: userController.authentication.value.cart.length > 0,
                 badgeContent: Text(userController.authentication.value.cart.length.toString(),style: TextStyle(
                     color: Colors.white
                 )
                   ,),
                child: Icon(Icons.shopping_cart)),
          ),label: 'Cart'),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.search),label: 'Search'),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.person),label: 'Profile'),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          HomeBody(),
          CartScreen(index: _indexSelect,),
          SearchProductScreen(index: _indexSelect,),
          UserProfileScreen(index: _indexSelect,),
        ],
        onPageChanged: (page) {
          setState(() {
            _indexSelect = page;
          });
          if(_indexSelect == 0){
            setState(() {
              _showAppBar = true;
            });
          }
          else{
            setState(() {
              _showAppBar = false;
            });
          }
        },
      ),
    );
  }
}

