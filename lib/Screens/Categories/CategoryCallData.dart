import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/CategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'AllCategoryProducts.dart';

class CallData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width= MediaQuery.of(context).size.width;
    final height= MediaQuery.of(context).size.height;
    return Obx(()=>
      Container(
        height: 90,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,i){
            return InkWell(
              onTap: (){
                productController.getCategoryProducts(categoryController.categories[i]);
              },
              child: Container(
                width: width*0.3,
                child: Card(
                  shadowColor: Colors.red,
                  color: kbuttonColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image(
                        image: NetworkImage(categoryController.categories[i].cateImg),
                          width: width*0.1,
                          color: Colors.white
                      ),
                      Text(categoryController.categories[i].cateTitle,style: TextStyle(
                          color: Colors.white
                      ),),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: categoryController.categories.length,
        ),
      ),
    );
  }
}