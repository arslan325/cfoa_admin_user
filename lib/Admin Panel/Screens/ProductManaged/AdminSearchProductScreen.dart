import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowAlert.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'Product_Updated.dart';
class AdminSearchProductScreen extends StatefulWidget {
  @override
  _AdminSearchProductScreenState createState() => _AdminSearchProductScreenState();
}

class _AdminSearchProductScreenState extends State<AdminSearchProductScreen> {
  TextEditingController searchTextEditing = TextEditingController();
  void initState() {
    super.initState();
    setState(() {
      productController.searchProductList.clear();
      productController.onInit();
    });
  }
  bool _searching = false;
  _search(String value) async {
    setState(() {
      _searching = true;
    });
    productController.searchProducts(value).whenComplete(() => { setState(() {
      _searching = false;
    })});
  }

  void clearText(){
    setState(() {
      searchTextEditing.clear();
      productController.searchProductList.clear();
    });
  }
  @override
  Widget build(BuildContext context) {
    RemoveList removeList = Provider.of<RemoveList>(context,listen: true);
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: kbuttonColor,),
          onPressed: (){
            Get.back();
          },
        ),
        backgroundColor: kbackgroundColor,
        elevation: 0.5,
        title: TextField(
          controller: searchTextEditing,
          // onChanged: (value){
          //   setState(() {
          //     productController.searchProducts(value);
          //   });
          // },
          onSubmitted:(value){
            setState(() {
             _search(value);
            });
          } ,
          decoration: InputDecoration(
              focusColor: Colors.black,
              hintText: 'search here..',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              suffixIcon:searchTextEditing.text.isNotEmpty ? IconButton(
                onPressed: clearText,
                icon:  Icon(Icons.clear,size: 20,color: kbuttonColor,),
              ):SizedBox()
          ),
        ),
      ),
      body:_searching == true
          ? Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(kbuttonColor),
        ),
      )
          : productController.searchProductList.length == 0
          ? Center(
        child: Text("No results found."),
      )
          :
             ListView.builder(
                itemCount: productController.searchProductList.length,
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
                                  image: NetworkImage(productController.searchProductList[index].prodImage),
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
                                      productController.searchProductList[index].prodTitle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(
                                      productController.searchProductList[index].categoryName,
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
                                        productController.searchProductList[index].prodDetail,
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
                                            'Rs. ' + productController.searchProductList[index].prodPrice.toString(),
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
                                          removeList.showProductAlert(productController.searchProductList[index],index).whenComplete(() {
                                            setState(() {

                                            });
                                          });
                                        }
                                        , icon: Icon(Icons.delete,
                                      color: Colors.redAccent,
                                    )
                                    ),
                                    IconButton(
                                        onPressed: (){
                                          Get.to(UpdatedProduct(products: productController.searchProductList[index],));
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
                }
          ),
    );
  }
}
