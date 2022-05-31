import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Product_detail.dart';

class SearchProductScreen extends StatefulWidget {
  final int index;
  SearchProductScreen({this.index});
  @override
  _SearchProductScreenState createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  TextEditingController searchTextEditing = TextEditingController();
  bool enable ;
  void initState() {
    super.initState();
      if(widget.index == null){
        enable = true;
      }
      else enable = false;
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
    return WillPopScope(
      onWillPop: () async => enable,
      child: Scaffold(
        backgroundColor: kbackgroundColor,
        appBar: AppBar(
          leading: IconButton(
          icon: Icon(Icons.arrow_back,color: kbuttonColor,),
        onPressed: (){
            if(widget.index != null) return;
            else
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
         body:
         _searching == true
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
           Obx(()=>
              ListView.builder(
              itemCount: productController.searchProductList.length,
                itemBuilder: (context,index){
              return InkWell(
                onTap: (){
                  Get.to(ProductDetail(product: productController.searchProductList[index],));
                },
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: Colors.white),
                    height: 100,
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
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
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
                                    IconButton(
                                        onPressed: (){
                                          cartController.addProductToCart(productController.searchProductList[index]);
                                        }
                                        , icon: Icon(Icons.add_shopping_cart,
                                      color: kbuttonColor,
                                    )
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              );
          }),
           ),
      ),
    );
  }
}
