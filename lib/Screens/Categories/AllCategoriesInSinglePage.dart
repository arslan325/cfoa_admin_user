import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCategoriesListedInSinglePage extends StatefulWidget {
  @override
  _AllCategoriesListedInSinglePageState createState() =>
      _AllCategoriesListedInSinglePageState();
}

class _AllCategoriesListedInSinglePageState
    extends State<AllCategoriesListedInSinglePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
        title: Text(
          "Categories",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => Container(
          padding: EdgeInsets.all(5),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            children: categoryController.categories.map((item) {
              return InkWell(
                onTap: () {
                  productController
                      .getCategoryProducts(item);
                },
                child: Card(
                  elevation: 2,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image(
                          image: NetworkImage(
                              item.cateImg),
                          width: width * 0.2,
                          color: kbuttonColor),
                      Text(
                        item.cateTitle,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            ).toList(),
          ),
        ),
      ),
    );
  }
}
