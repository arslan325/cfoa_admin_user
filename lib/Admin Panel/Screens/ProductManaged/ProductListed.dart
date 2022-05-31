import 'package:cfoa_fyp/Admin%20Panel/Widgets/AdminDrawer.dart';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowAlert.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'ProductUploaded.dart';
import 'Product_Updated.dart';

class ProductListedScreen extends StatefulWidget {
  @override
  _ProductListedScreenState createState() => _ProductListedScreenState();
}

class _ProductListedScreenState extends State<ProductListedScreen> {
  @override
  Widget build(BuildContext context) {
    RemoveList removeList = Provider.of<RemoveList>(context,listen: true);
    print(productController.products.length);
    final width = MediaQuery.of(context).size.width.toInt();
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
        actions: [
          IconButton(
            onPressed: () {
              Get.to(ProductUploadedScreen());
            },
            icon: Icon(Icons.add),
            color: kbuttonColor,
          )
        ],
        title: Text(
          "Products",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
      ),
      drawer: AdminDrawer(),
      body: Obx(
        () => (productController.products.length>0)?
            ListView.builder(
        itemCount: productController.products.length,
        itemBuilder: (context, index) {
            return
                Container(
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.5), blurRadius: 15)
                  ],
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              height: 180,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: NetworkImage(productController.products[index].prodImage),
                        fit: BoxFit.fitHeight,
                        width: 120,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: 200,
                      padding: EdgeInsets.all(7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productController.products[index].prodTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            productController.products[index].categoryName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: kbuttonColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            height: 70,
                            child: Text(
                              productController.products[index].prodDetail,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 30,
                            width: 120,
                            decoration: BoxDecoration(
                              color: kbuttonColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                                child: Text(
                              'Rs. ' + productController.products[index].prodPrice.toString(),
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: (){
                                removeList.showProductAlert(productController.products[index],index);
                              }
                              , icon: Icon(Icons.delete,
                            color: Colors.redAccent,
                          )
                          ),
                          IconButton(
                              onPressed: (){
                                Get.to(UpdatedProduct(products: productController.products[index],));
                              }
                              , icon: Icon(Icons.edit_outlined,
                            color: kbuttonColor,
                          )
                          ),
                        ],
                      )
                  ),

                ],
              )
            );
          }):
        Container(
          height: 200,
          child: Center(
              child: Text('Products data is empty.')),
        )
        ),
    );
  }
}
