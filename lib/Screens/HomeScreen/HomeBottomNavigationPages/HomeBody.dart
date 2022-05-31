import 'package:cfoa_fyp/Admin%20Panel/Controllers/CartController.dart';
import 'package:cfoa_fyp/Models/CartModel.dart';
import 'package:cfoa_fyp/Screens/Categories/AllCategoriesInSinglePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '/Constant/Constant.dart';
import '/Models/Product_Model.dart';
import '/Screens/Categories/CategoryCallData.dart';

import '/Screens/Products/ProductCallData.dart';
import '/Widgets/CarooselImage.dart';
import 'package:badges/badges.dart';
class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}
class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int blockIdx) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 7,vertical: 5),
            child: Column(
              children: <Widget> [
                CustomCarousel(),
                SizedBox(height: 10,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Category",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                  ),),
                      TextButton(
                        onPressed: (){
                          Get.to(() => AllCategoriesListedInSinglePage());
                        },
                        child: Text("View All",style: TextStyle(
                          color: kbuttonColor,
                          fontSize: 16
                        ),),
                      ),
                    ],
                  ),
                ),
                CallData(),
                SizedBox(height: 20,),
                ProductCallData(),
              ],
            ),
          );
        }

      ),
    );
  }
}


