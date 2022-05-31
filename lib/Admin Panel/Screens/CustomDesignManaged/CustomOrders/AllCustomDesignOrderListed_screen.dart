import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowAlert.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'CustomDesignOrderDetail.dart';

class AllCustomOrderListedScreen extends StatefulWidget {
  @override
  _AllCustomOrderListedScreenState createState() => _AllCustomOrderListedScreenState();
}

class _AllCustomOrderListedScreenState extends State<AllCustomOrderListedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kbackgroundColor,
        appBar: AppBar(
          title: Text(
            "Custom Design Orders",
            style: klabelStyle,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: kbuttonColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: true,
          elevation: 0.5,
          backgroundColor: kbackgroundColor,
        ),
        body: Obx(()=>customDesignOrderController.allCustomOrders.length >0 ?
            ListView.builder(
              itemBuilder: (context,i) {
                return
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(.5), blurRadius: 15)
                        ]),
                    child: Wrap(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                child: Text('Custom Order Id:',style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16
                                ),)
                            ),
                            Text(customDesignOrderController.allCustomOrders[i].customOrderId,style: TextStyle(
                                fontSize: 16
                            ),
                            ),
                            Visibility(
                              visible: (customDesignOrderController.allCustomOrders[i].customOrderStatus == 'pending' && customDesignOrderController.activeCustomOrders[i].paymentStatus == 'pending')?true:false,
                              child: IconButton(onPressed: (){
                                showCustomOrderDeleteAlert(customDesignOrderController.allCustomOrders[i].customOrderId);
                              },
                                icon: Icon(Icons.delete),color: Colors.redAccent,),
                            )
                          ],
                        ),
                        Divider(),
                        ListTile(
                          title: Text(
                            customDesignOrderController.allCustomOrders[i].designItem.first['Design Title'],
                            style: TextStyle(
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          leading: Image(
                            image: NetworkImage(customDesignOrderController.allCustomOrders[i].designItem.first['Design Image'],),
                            width: 70,
                          ),
                          trailing: Text(
                            'Rs ' + customDesignOrderController.allCustomOrders[i].totalAmount.toString(),
                            style: TextStyle(
                                color: kbuttonColor,
                                fontSize: 16
                            ),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Text('Payment Status', style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),),
                          trailing: Text(customDesignOrderController.allCustomOrders[i].paymentStatus,
                            style: TextStyle(
                                fontSize: 16,
                                color: customDesignOrderController.allCustomOrders[i].paymentStatus=='succeeded'? kbuttonColor: Colors.redAccent
                            ),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Text('Custom Order Status', style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),),
                          trailing: Text(customDesignOrderController.allCustomOrders[i].customOrderStatus,
                            style: TextStyle(
                                fontSize: 16,
                                color: customDesignOrderController.allCustomOrders[i].customOrderStatus=='received'? kbuttonColor: Colors.redAccent
                            ),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Text('Order on', style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),),
                          trailing: Text(
                            DateFormat.yMMMMEEEEd().format(customDesignOrderController.allCustomOrders[i].orderOn.toDate()),
                            style: TextStyle(
                                fontSize: 16
                            ),
                          ),
                        ),
                        Divider(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: CustomRoundedButton(title: 'See Details',
                            clickFuction: () {
                            Get.to(CustomOrderDetailScreen(customDesignOrder: customDesignOrderController.allCustomOrders[i],));
                            },
                          ),
                        )
                      ],
                    ),
                  );
              },
              itemCount: customDesignOrderController.allCustomOrders.length,
            ):Container(
          height: 200,
          child: Center(
              child: Text('No custom orders found')),
        )
        )
    );
  }
}


