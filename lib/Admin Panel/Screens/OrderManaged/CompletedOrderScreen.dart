import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'CustomerOrderDetail_Screen.dart';
class CompletedOrders extends StatefulWidget {
  @override
  _CompletedOrdersState createState() => _CompletedOrdersState();
}

class _CompletedOrdersState extends State<CompletedOrders> {
  @override
  Widget build(BuildContext context) {
    return Obx(()=> (orderController.completedOrders.length) > 0 ?
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
                    Text(orderController.completedOrders[i].cart.length.toString(), style: TextStyle(
                        fontSize: 16
                    ),),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Rs ${orderController.completedOrders[i].totalAmount}",
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
                    children: orderController.completedOrders[i].cart
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
                  trailing: Text(orderController.completedOrders[i].paymentStatus,
                    style: TextStyle(
                        fontSize: 16,
                        color: orderController.completedOrders[i].paymentStatus == 'succeeded'? kbuttonColor: Colors.redAccent
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Text('Order Status:',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),),
                  trailing: Text(orderController.completedOrders[i].orderStatus,
                    style: TextStyle(
                        fontSize: 16,
                        color: orderController.completedOrders[i].orderStatus == 'received'? kbuttonColor: Colors.redAccent
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
                    DateFormat.yMMMMEEEEd().format(orderController.completedOrders[i].orderOn.toDate()),
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
                      Get.to(CustomerOrderDetail(orderModel: orderController.completedOrders[i],));
                    },
                  ),
                ),
              ],
            ),
          );
      },
      itemCount: orderController.completedOrders.length,
    ):Container(
      height: 200,
      child: Center(child: Text('No order has been found')),
    )
    );
  }
}
