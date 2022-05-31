import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Constant/Constant.dart';
import '/Screens/Products/Product_detail.dart';
class ProductCallData extends StatefulWidget {
  @override
  _ProductCallDataState createState() => _ProductCallDataState();
}

class _ProductCallDataState extends State<ProductCallData> {
  @override
  Widget build(BuildContext context) {
    print(productController.categoryProducts.length);
    final width= MediaQuery.of(context).size.width;
    final height= MediaQuery.of(context).size.height;
    final double itemHeight = (height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = width / 2;
    return Container(
      child: Obx(()=>
         GridView.count(
           crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
          physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            primary: false,
            children: productController.products.map((item) {
              return InkWell(
                onTap:() {
                  Get.to(ProductDetail(product: item,));
                },
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: height*.010,),
                      Expanded(
                        child: Image(
                            image: NetworkImage(item.prodImage),
                          width: width*0.36,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.categoryName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: kbuttonColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),),
                            SizedBox(height: 7,),
                            Text(item.prodTitle,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 30,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: kbuttonColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                        child: Text(
                                          'Rs. ' + item.prodPrice.toString(),
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  width: 30,
                                  child: IconButton(
                                    color: kbuttonColor,
                                    onPressed: (){
                                      cartController.addProductToCart(item);
                                    },
                                    icon: Icon(Icons.add_shopping_cart_outlined),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              );
            }
              ).toList(),
        ),
      ),
     );
  }
}