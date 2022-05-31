

import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowAlert.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Screens/Orders/TrackOrder_Screen.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'CustomOrderDetail_Screen.dart';

class CustomDesignOrderListed extends StatefulWidget {
  @override
  _CustomDesignOrderListedState createState() => _CustomDesignOrderListedState();
}

class _CustomDesignOrderListedState extends State<CustomDesignOrderListed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kbackgroundColor,
        appBar: AppBar(
          title: Text(
            "Custom Orders",
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
        body: Obx(()=> (customDesignOrderController.activeCustomOrders.length) > 0?
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
                        Text(customDesignOrderController.activeCustomOrders[i].customOrderId,style: TextStyle(
                            fontSize: 16
                        ),
                        ),
                        Visibility(
                          visible: (customDesignOrderController.activeCustomOrders[i].customOrderStatus == 'pending' && customDesignOrderController.activeCustomOrders[i].paymentStatus == 'pending')?true:false,
                          child: IconButton(onPressed: (){
                            showCustomOrderDeleteAlert(customDesignOrderController.activeCustomOrders[i].customOrderId);
                          },
                            icon: Icon(Icons.delete),color: Colors.redAccent,),
                        )
                      ],
                    ),
                    Divider(),
                    ListTile(
                        title: Text(
                          customDesignOrderController.activeCustomOrders[i].designItem.first['Design Title'],
                          style: TextStyle(
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        leading: Image(
                          image: NetworkImage(customDesignOrderController.activeCustomOrders[i].designItem.first['Design Image'],),
                          width: 70,
                        ),
                      trailing: Text(
                       'Rs ' + customDesignOrderController.activeCustomOrders[i].totalAmount.toString(),
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
                      trailing: Text(customDesignOrderController.activeCustomOrders[i].paymentStatus,
                        style: TextStyle(
                            fontSize: 16,
                            color: customDesignOrderController.activeCustomOrders[i].paymentStatus=='succeeded'? kbuttonColor: Colors.redAccent
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      leading: Text('Custom Order Status', style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),),
                      trailing: Text(customDesignOrderController.activeCustomOrders[i].customOrderStatus,
                        style: TextStyle(
                            fontSize: 16,
                            color: customDesignOrderController.activeCustomOrders[i].customOrderStatus=='received'? kbuttonColor: Colors.redAccent
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
                        DateFormat.yMMMMEEEEd().format(customDesignOrderController.activeCustomOrders[i].orderOn.toDate()),
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                    ),
                    Divider(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomRoundedButton2(
                              title: 'Track order',
                              clickFuction: () {
                                Get.to(TrackOrderScreen(orderId: customDesignOrderController.activeCustomOrders[i].customOrderId,
                                  orderStatus: customDesignOrderController.activeCustomOrders[i].customOrderStatus,
                                ));
                              },
                              color: kbuttonColor,
                            ),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            child: CustomRoundedButton2(
                              title: 'See Detail',
                              clickFuction: () {
                                Get.to(CustomOrderDetailScreen(customDesignOrder: customDesignOrderController.activeCustomOrders[i],));
                              },
                              color: kbuttonColor,
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              );
          },
          itemCount: customDesignOrderController.activeCustomOrders.length,
        ):Container(
          height: 200,
          child: Center(
            child: Text('No Custom Order has been found.',style: TextStyle(fontSize: 16),),
          ),
        )
        )
    );
  }
}
