import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'OrderDetail_Screen.dart';
import 'TrackOrder_Screen.dart';

class OrderListed extends StatefulWidget {
  @override
  _OrderListedState createState() => _OrderListedState();
}

class _OrderListedState extends State<OrderListed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        title: Text(
          "Orders",
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
      body: Obx(()=> (orderController.activeOrders.length) > 0?
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
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "ITEMS:",
                        style: TextStyle(
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    Text(orderController.activeOrders[i].cart.length.toString(), style: TextStyle(
                        fontSize: 16
                    ),),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Rs ${orderController.activeOrders[i].totalAmount}",
                        style: TextStyle(
                            color: kbuttonColor,
                            fontSize: 16
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    )
                  ],
                ),
                Divider(),
                Column(
                    children: orderController.activeOrders[i].cart
                        .map((item) =>
                        ListTile(
                            title: Text(
                              item['Product Title'],
                            ),
                            trailing: Text(
                              "Rs ${item['cost']}" ?? "",
                            ),
                            leading: Image(
                              image: NetworkImage(item['Product Image'],),
                              width: 50,
                            )
                        ))
                        .toList()),
                Divider(),
                ListTile(
                  leading: Text('Payment Status:',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),),
                  trailing: Text(orderController.activeOrders[i].paymentStatus,
                    style: TextStyle(
                        fontSize: 16,
                        color: orderController.activeOrders[i].paymentStatus == 'succeeded'? kbuttonColor: Colors.redAccent
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Text('Order Status:',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),),
                  trailing: Text(orderController.activeOrders[i].orderStatus,
                    style: TextStyle(
                        fontSize: 16,
                        color: orderController.activeOrders[i].orderStatus == 'received'? kbuttonColor: Colors.redAccent
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Text('Order on:', style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),),
                  trailing: Text(
                    DateFormat.yMMMMEEEEd().format(orderController.activeOrders[i].orderOn.toDate()),
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
                      Get.to(OrderDetails(orderModel: orderController.activeOrders[i],));
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: (){
                        Get.to(TrackOrderScreen(orderId: orderController.activeOrders[i].orderId,
                          orderStatus: orderController.activeOrders[i].orderStatus,
                        ));
                      },
                      child: Text('Track Order',
                        style: TextStyle(
                            color: kbuttonColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: orderController.activeOrders.length,
        ):Container(
        height: 200,
        child: Center(
          child: Text('No order has been found.',style: TextStyle(fontSize: 16),),
        ),
      )
      )
    );
  }
}
