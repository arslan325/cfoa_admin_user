import 'package:cfoa_fyp/Admin%20Panel/Screens/CategoriesManaged/Category_Update.dart';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/AdminDrawer.dart';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowAlert.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Category_Uploaded.dart';

class ListedCategories extends StatefulWidget {
  @override
  _ListedCategoriesState createState() => _ListedCategoriesState();
}

class _ListedCategoriesState extends State<ListedCategories> {
  @override
  Widget build(BuildContext context) {
    print(productController.loading);
    // List<CategoryModel> category = cateModel.loadedData;
    return Scaffold(
        backgroundColor: kbackgroundColor,
        appBar: AppBar(
          backgroundColor: kbackgroundColor,
          elevation: 0.5,
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(UploadedCategoryScreen());
                },
                icon: Icon(
                  Icons.add,
                  color: kbuttonColor,
                ))
          ],
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
            "Category",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
          ),
          centerTitle: true,
        ),
        drawer: AdminDrawer(),
        body: Obx(() => (categoryController.categories.length > 0)
            ? ListView.builder(
                itemCount: categoryController.categories.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                blurRadius: 15)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        height: 120,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              width: 100,
                              child: Image(
                                image: NetworkImage(categoryController
                                    .categories[index].cateImg),
                                color: kbuttonColor,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Id: ' +
                                            categoryController
                                                .categories[index].categoryId,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        categoryController
                                            .categories[index].cateTitle,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: kbuttonColor),
                                      ),
                                    ],
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showCategoryAlert(categoryController
                                              .categories[index]);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Get.to(UpdatedCategoryScreen(
                                              category: categoryController
                                                  .categories[index]));
                                        },
                                        icon: Icon(
                                          Icons.edit_outlined,
                                          color: kbuttonColor,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                })
            : Container(
                height: 200,
                child: Center(child: Text('Categories data is empty.')),
              )));
  }
}
